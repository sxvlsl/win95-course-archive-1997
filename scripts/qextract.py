import struct, glob, os, subprocess, sys, csv
OUT = 'work/Extraccion_PAK'; rows = []; ok = fail = skip = 0
for p in sorted(glob.glob('work/Contenedores_Binarios_MME/**/*', recursive=True)):
    if not (os.path.isfile(p) and p.lower().endswith('.pak')): continue
    d = open(p, 'rb').read()
    if d[:3] != b'DS\x00':
        skip += 1; continue            # LHA de TASM, ya extraidos
    n = struct.unpack_from('<H', d, 4)[0]; wb = d[6]; o = 8; ents = []
    for _ in range(n):
        l = d[o]; name = d[o+1:o+1+l].decode('latin1'); o += 1 + l
        cl = d[o]; o += 1 + cl         # comentario
        sz, tm, dt = struct.unpack_from('<IHH', d, o); o += 8
        ents.append((name, sz, tm, dt))
    tot = sum(e[1] for e in ents)
    dest = os.path.join(OUT, os.path.splitext(p[len('work/Contenedores_Binarios_MME/'):])[0])
    os.makedirs(dest, exist_ok=True); tmp = dest + '/_stream.bin'
    r = subprocess.run(['tools/qdec', p, str(o), str(wb), str(tot), tmp], capture_output=True)
    s = open(tmp, 'rb').read() if os.path.exists(tmp) else b''
    if os.path.exists(tmp): os.remove(tmp)
    good = (r.returncode == 0 and len(s) == tot)
    pos = 0
    for name, sz, tm, dt in ents:
        if good: open(os.path.join(dest, name), 'wb').write(s[pos:pos+sz])
        pos += sz
        rows.append((p, name, sz, wb, 'OK' if good else 'FALLO rc=%d got=%d' % (r.returncode, len(s))))
    ok += good; fail += (not good)
w = csv.writer(open('metadata/extraccion_resultado.csv', 'w')); w.writerow(['pak','archivo','tam','wbits','estado']); w.writerows(rows)
print('PAK ok:', ok, '| fallo:', fail, '| LHA omitidos:', skip)
