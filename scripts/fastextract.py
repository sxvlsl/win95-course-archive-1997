import csv, os, sys, time, shutil, subprocess, threading, queue, collections
ROOT = os.getcwd(); OUT = os.path.join(ROOT, 'work/Extraccion_UNPAQ'); N = int(sys.argv[1]) if len(sys.argv) > 1 else 8
BASE = '/tmp/uq'; UNPAQ = BASE + '/UNPAQ.EXE'
jobs = collections.OrderedDict()
for r in csv.DictReader(open('metadata/pak_manifest.csv', encoding='latin1')):
    if r['archivo'].startswith('<<'): continue
    jobs.setdefault(r['pak'], []).append((r['archivo'], int(r['tam_orig'])))
lock = threading.Lock(); stats = collections.Counter(); logf = open(OUT + '_log.txt', 'a')
def log(s):
    with lock: logf.write(s + '\n'); logf.flush()

def verify(d, files):
    have = {}
    for dp, _, fs in os.walk(d):
        for f in fs:
            p = os.path.join(dp, f); have[os.path.relpath(p, d).replace('/', '\\').lower()] = os.path.getsize(p)
    return all(have.get(n.lower()) == s for n, s in files)

class Worker:
    def __init__(s, n):
        s.n = n; s.disp = ':%d' % (110 + n); s.w = '%s/w%d' % (BASE, n); s.o = s.w + '/o'
        s.env = dict(os.environ, DISPLAY=s.disp, WINEPREFIX='/tmp/wp/%d' % n, WINEDEBUG='-all',
                     WINEDLLOVERRIDES='winemenubuilder.exe=d;mscoree=d;mshtml=d')
        os.makedirs(s.o, exist_ok=True); s.xv = None; s.wine = None
    def x(s, *a, **k): return subprocess.run(['xdotool', *a], env=s.env, capture_output=True, text=True, **k)
    def start_x(s):
        s.xv = subprocess.Popen(['Xvfb', s.disp, '-screen', '0', '1024x768x24', '-nolisten', 'tcp'],
                                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL); time.sleep(0.5)
    def start_wine(s):
        s.stop_wine()
        s.wine = subprocess.Popen(['wine', UNPAQ], env=s.env, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        for _ in range(1200):
            r = s.x('search', '--name', 'Quantum Windows').stdout.split()
            if r: s.win = r[0]; break
            time.sleep(0.05)
        else: return False
        time.sleep(0.4); s.x('windowfocus', s.win)
        for y, txt in ((17, 'Z:\\tmp\\uq\\w%d\\A.PAK' % s.n), (45, 'Z:\\tmp\\uq\\w%d\\o\\' % s.n)):
            s.x('mousemove', '--window', s.win, '300', str(y), 'click', '1'); time.sleep(0.1)
            s.x('key', 'End', 'shift+Home'); s.x('type', '--delay', '12', txt); time.sleep(0.1)
        return True
    def stop_wine(s):
        subprocess.run(['wineserver', '-k'], env=s.env, capture_output=True)
        s.wine = None
    def clear(s):
        for f in os.listdir(s.o):
            p = os.path.join(s.o, f); shutil.rmtree(p) if os.path.isdir(p) else os.remove(p)
    def attempt(s, pak, files, tmo):
        s.clear(); shutil.copyfile(pak, s.w + '/A.PAK')
        s.x('mousemove', '--window', s.win, '528', '108', 'click', '1'); time.sleep(0.15)
        s.x('mousemove', '--window', s.win, '528', '256', 'click', '1')
        t0 = time.time()
        while time.time() - t0 < tmo:
            if verify(s.o, files): time.sleep(0.15); return verify(s.o, files)
            time.sleep(0.05)
        return False
    def run(s, q):
        s.start_x(); ok = s.start_wine()
        while True:
            try: pak, files = q.get_nowait()
            except queue.Empty: break
            rel = os.path.splitext(pak.split('work/Contenedores_Binarios_MME/')[1])[0]; dest = os.path.join(OUT, rel)
            if os.path.isdir(dest) and verify(dest, files): stats['saltado'] += 1; continue
            tmo = 8 + sum(x[1] for x in files) / 2e5; res = 'FALLO'
            for intento in (1, 2):
                if ok and s.attempt(pak, files, tmo): res = 'OK' if intento == 1 else 'OK_reintento'; break
                stats['reinicios'] += 1; ok = s.start_wine()
            if res.startswith('OK'):
                shutil.rmtree(dest, ignore_errors=True); os.makedirs(os.path.dirname(dest), exist_ok=True); shutil.copytree(s.o, dest)
            if res.startswith('OK'): ok = s.start_wine()   # UNPAQ solo sirve para una extraccion
            stats[res] += 1; log('%s esperados=%d %s' % (res, len(files), rel))
            with lock: print('\r' + ' '.join('%s=%d' % kv for kv in sorted(stats.items())), end='', flush=True)
        s.stop_wine(); s.xv.terminate()

q = queue.Queue()
for k, v in jobs.items(): q.put((os.path.join(ROOT, k), v))
os.makedirs(OUT, exist_ok=True); os.makedirs('/tmp/wp', exist_ok=True)
t0 = time.time(); ths = [threading.Thread(target=Worker(i).run, args=(q,)) for i in range(N)]
[t.start() for t in ths]; [t.join() for t in ths]
print('\nterminado en %.0f s' % (time.time() - t0), dict(stats))
