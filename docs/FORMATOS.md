# Formatos del Curso de C++ y Turbo Assembler (1997)

Colección: 13 CD-ROM (`CW95_Turbo_CPP_1..10`, `CW95_Turbo_Assembler_1..3`).
Total de contenedores `.PAK`: 247 (223 C++ + 24 TASM).

## Contenedores `.PAK` de C++ (Quantum `.Q`, David Stafford)

Descompresor original: `UNPAQ.EXE` ("Quantum Windows Decompressor ver 0.92",
ejecutable Win16 NE, en `CW95_Turbo_CPP_1/TCWIN45/`).

Cabecera:

| Offset | Tamaño | Contenido |
|--------|--------|-----------|
| 0      | 3      | `44 53 00` (`DS\0`), el 4.º byte varía (`5a`/`5c`) |
| 3      | u16 LE | número de ficheros |
| 5      | u8     | bits de ventana (p. ej. `0x0f` = 15) |
| 6      | u8     | segundo byte de parámetros (significado sin confirmar) |
| 7      | ...    | tabla de entradas |

Entrada (repetida N veces):

    u8 len_nombre  | nombre
    u8 len_comentario | comentario
    u32 tamaño_descomprimido
    u16 hora_DOS
    u16 fecha_DOS

El flujo comprimido empieza justo tras la tabla (en `CALC.PAK`, offset 79).

Decodificación: el decodificador Quantum de libmspack (variante CAB) solo
decodifica parte del flujo; el framing de `.Q` difiere y no está resuelto.
Los experimentos están en `scripts/qextract.py` y `tools/` (aparcados).

## Contenedores `.PAK` de Turbo Assembler (LHA)

Son archivos LHA `-lh5-`: `7z x -tlzh fichero.PAK`.

## Método de extracción de los PAK de C++

`scripts/fastextract.py` ejecuta `UNPAQ.EXE` bajo Wine + Xvfb + xdotool:

- 8 workers en paralelo, cada uno con su Xvfb (`:110+n`) y su `WINEPREFIX`.
- Wine se reinicia tras cada PAK (UNPAQ no admite reutilización).
- Necesario `WINEDLLOVERRIDES="mscoree=d;mshtml=d;winemenubuilder.exe=d"`
  para evitar el diálogo de Wine Mono.
- Resultado: 223 PAK, 0 fallos, ~100 s en total.

## Verificación

- C++: 1714 ficheros extraídos del PAK. 1348 idénticos (SHA-256) a la copia
  instalada en `CW95_*`, 362 existen solo dentro de PAK, y 4 aparentes
  discrepancias eran falsos positivos (se comparó contra una sola copia; al
  comparar contra todas las del mismo nombre coinciden).
- TASM: 209 ficheros, todos idénticos (`scripts/verify_tasm.py`).
- Tamaños por fichero contrastados con `metadata/pak_manifest.csv` (1937 entradas).
- Hashes: `metadata/MANIFEST_isos.sha256` (13 ISOs) y `metadata/MANIFEST_extraidos.sha256`.

## Reproducir

    python3 scripts/pak_manifest.py     # manifiesto de cabeceras
    python3 scripts/fastextract.py      # extracción C++ (Wine, Xvfb, xdotool)
    python3 scripts/verify_tasm.py      # verificación TASM
    (cd work && sha256sum -c ../metadata/MANIFEST_extraidos.sha256)
