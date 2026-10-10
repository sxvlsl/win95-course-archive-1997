# Preservación Histórica: Curso de C++ y Turbo Assembler para Windows 95 (Planeta DeAgostini, 1997-1998)

Repositorio de preservación digital, verificación de integridad y consolidación de código fuente de la colección en CD-ROM **Curso de C++ y Turbo Assembler para Windows 95**, distribuida por **Planeta DeAgostini** en España entre finales de 1997 y principios de 1998 (contenidos MME / IIC).

La colección consta de **13 CD-ROM**: `CW95_Turbo_CPP_1..10` (Borland Turbo C++ para Windows 4.5) y `CW95_Turbo_Assembler_1..3` (Turbo Assembler 5.0).

---

## Qué contiene realmente la colección

El análisis del contenido muestra que la colección es, sobre todo, una **distribución de herramientas, ejemplos y manuales de Borland** con un instalador propio de la edición, no un conjunto de lecciones escritas por la editorial:

- **Turbo C++ 4.5 (`TCWIN45`)** con sus ejemplos oficiales, repartidos en áreas: OWL (la mayor), ClassLib, Windows, IDE y OCF. El código usa **OWL** en abundancia, además de la API de Windows directa.
- **Turbo Assembler 5.0 (`TASM`)** con documentación y utilidades.
- **Manuales de Borland en PDF** (CD 10, carpeta `BOOKS`): guía de usuario, guía del programador, guía del programador de OWL, tutorial de OWL y guía de inicio. Fechados en febrero de 1995.
- **Ayudas `.HLP`** de Borland (OWL, OCF, ClassLib, BCPP, etc.) repetidas en varios CD.
- **Carpeta `DELPHI`** en el CD 1, con manuales, información técnica y dos vídeos promocionales (`BORLAND.AVI`, `DELPHI.AVI`).
- **Material propio de la edición**: instaladores `INSTALAR.EXE` / `INSTALAR.DOC`, `MOREPROC.BAT` y `UNISAM.DLL`.

Los mismos árboles (`TCWIN45`, `TASM`) se repiten entre varios discos, por lo que las cifras totales deben leerse con cuidado: de los 2.361 ficheros de `Codigo_Fuente_Coleccion`, solo **1.170 son únicos por contenido**.

---

## Contenido del repositorio

| Ruta | Descripción |
| :--- | :--- |
| `CW95_*/` | Árboles de los 13 CD-ROM, con el contenido que se versiona (sin librerías `.LIB`, ISOs ni `.PAK`). |
| `Codigo_Fuente_Coleccion/` | Réplica depurada con solo el código fuente y los recursos (2.361 ficheros, ~24,5 MiB; 1.170 únicos). |
| `scripts/` | Herramientas de extracción y verificación (Python). |
| `tools/` | Fuentes en C del decodificador Quantum usado para analizar el formato. |
| `metadata/` | Manifiestos SHA-256 y tablas CSV de extracción. |
| `docs/FORMATOS.md` | Formatos de empaquetado y método de extracción. |
| `work/` | Material generado localmente (ISOs, extracciones). **No se versiona.** |

```text
.
├── CW95_Turbo_CPP_1 … CW95_Turbo_CPP_10/
├── CW95_Turbo_Assembler_1 … CW95_Turbo_Assembler_3/
├── Codigo_Fuente_Coleccion/
├── scripts/      fastextract.py  pak_manifest.py  verify_tasm.py  qextract.py
├── tools/        decodificador Quantum (fuentes C)
├── metadata/     MANIFEST_isos.sha256  MANIFEST_extraidos.sha256
│                 pak_manifest.csv  extraccion_resultado.csv
├── docs/         FORMATOS.md
└── work/         (ignorado) ISOs y extracciones intermedias
```

---

## Métricas

| Métrica | Valor |
| :--- | :--- |
| Volumen de datos | 457,56 MB (13 imágenes ISO) |
| Rango de producción | 13 de noviembre de 1997 — 2 de abril de 1998 |
| Ficheros en `Codigo_Fuente_Coleccion` | 2.361 (1.170 únicos por contenido) |
| Líneas de código únicas (`.cpp .c .h .asm .inc .rc`) | 279.029 |

---

## Extracción y verificación de integridad

Los instaladores usan contenedores `.PAK` que en realidad son dos formatos distintos (detalle en [`docs/FORMATOS.md`](docs/FORMATOS.md)):

| Colección | Formato del `.PAK` | Resultado |
| :--- | :--- | :--- |
| Turbo C++ (10 CD) | Archivos **Quantum** (`.Q`, David Stafford) | 223 PAK → 1.714 ficheros |
| Turbo Assembler (3 CD) | **LHA** (`-lh5-`) | 24 PAK → 209 ficheros |

**Verificación**

- C++: 1.348 ficheros idénticos al árbol de instalación, 362 existentes solo dentro de los PAK y 4 falsos positivos de comparación.
- Turbo Assembler: los 209 ficheros coinciden byte a byte con el árbol de instalación.
- SHA-256: 13 ISOs y 1.924 ficheros extraídos, todos verificados.

---

## Reproducir

Requisitos: Python 3, `7z` (con soporte LHA) y, para la extracción Quantum, Wine, Xvfb y xdotool (el descompresor original `UNPAQ.EXE` es un programa Win16).

Coloca las 13 ISOs en `work/ISOs_Originales/` y, desde la raíz del repositorio:

```sh
python3 scripts/pak_manifest.py     # manifiesto de cabeceras de los PAK
python3 scripts/fastextract.py      # extracción C++ (Wine + Xvfb, en paralelo)
python3 scripts/verify_tasm.py      # verificación de los PAK de Turbo Assembler

(cd work && sha256sum -c ../metadata/MANIFEST_isos.sha256)
(cd work && sha256sum -c ../metadata/MANIFEST_extraidos.sha256)
```

La extracción completa tarda unos 100 segundos con 8 procesos en paralelo.

---

## Nota legal y propósito

Este repositorio tiene un propósito educativo, de investigación y de preservación de la historia de la informática. Las imágenes ISO originales y las librerías compiladas (`.LIB`) no se versionan. Los árboles de los CD incluyen, con fines de preservación, ejemplos y documentación de Borland, cuyos derechos pertenecen a sus respectivos titulares, igual que las marcas de Borland y Microsoft. Si eres titular de derechos y quieres que se retire algún contenido, abre una incidencia.