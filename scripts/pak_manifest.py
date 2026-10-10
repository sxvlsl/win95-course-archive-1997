import struct, glob, csv, os
rows = []; bad = 0
for p in sorted(glob.glob('work/Contenedores_Binarios_MME/**/*', recursive=True)):
    if not p.lower().endswith('.pak') or not os.path.isfile(p):
        continue
    d = open(p, 'rb').read()
    if d[:3] != b'DS\x00':
        print('NO DS:', p); bad += 1; continue
    n = struct.unpack_from('<H', d, 4)[0]
    par = d[6:8].hex()
    o = 8
    try:
        for _ in range(n):
            l = d[o]
            name = d[o+1:o+1+l].decode('latin1')
            o += 1 + l
            cl = d[o]; o += 1 + cl
            sz, tm, dt = struct.unpack_from('<IHH', d, o)
            o += 8
            rows.append((p, par, name, sz, 1980 + (dt >> 9), (dt >> 5) & 15, dt & 31))
        rows.append((p, par, '<<DATA_OFFSET>>', o, len(d), 0, 0))
    except Exception as e:
        print('ERROR parseando', p, e); bad += 1
w = csv.writer(open('metadata/pak_manifest.csv', 'w'))
w.writerow('pak,params,archivo,tam_orig,anio,mes,dia'.split(','))
w.writerows(rows)
print('entradas:', len(rows), '| PAK invalidos:', bad)
