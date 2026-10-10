import os, glob, subprocess, tempfile, hashlib, collections
h = lambda p: hashlib.sha256(open(p, 'rb').read()).hexdigest()
c = collections.Counter(); problemas = []
for pak in sorted(glob.glob('Contenedores_Binarios_MME/CW95_Turbo_Assembler_*/**/*.PAK', recursive=True)):
    rel = os.path.splitext(pak[len('Contenedores_Binarios_MME/'):])[0]
    dest = os.path.join('Herramientas_Borland_Extraidas', rel)
    with tempfile.TemporaryDirectory() as t:
        r = subprocess.run(['7z', 'x', '-y', '-tlzh', '-o' + t, pak], capture_output=True, text=True)
        if r.returncode != 0:
            c['pak_no_extraible'] += 1; problemas.append((pak, 'fallo 7z')); continue
        have = {}
        if os.path.isdir(dest):
            for dp, _, fs in os.walk(dest):
                for f in fs:
                    p = os.path.join(dp, f); have[os.path.relpath(p, dest).lower()] = p
        for dp, _, fs in os.walk(t):
            for f in fs:
                p = os.path.join(dp, f); k = os.path.relpath(p, t).lower()
                if k not in have: c['falta_en_extraidas'] += 1; problemas.append((pak, 'falta ' + k))
                elif h(p) != h(have[k]): c['HASH_DISTINTO'] += 1; problemas.append((pak, 'hash ' + k))
                else: c['identico'] += 1
print(dict(c))
for p in problemas[:30]: print(p)
