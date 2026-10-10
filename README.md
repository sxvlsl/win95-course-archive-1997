# Preservación Histórica: Curso de C++ y Turbo Assembler para Windows 95 (Planeta DeAgostini, 1997-1998)

Repositorio de preservación digital, verificación de integridad y consolidación de código fuente del **Curso de Programación para Windows 95** distribuido por **Planeta DeAgostini** en España entre finales de 1997 y principios de 1998 (contenidos MME / IIC).

La obra completa abarca **13 volúmenes en CD-ROM** (`CW95_Turbo_CPP_1..10` y `CW95_Turbo_Assembler_1..3`) dedicados a desarrollar software para el ecosistema de 32 bits de Microsoft con herramientas de **Borland**: **Turbo C++ Visual Edition 4.5** y **Turbo Assembler 5.0 (TASM32)**.

---

## Contenido del repositorio

| Ruta | Descripción |
| :--- | :--- |
| `CW95_*/` | Árboles de los 13 CD-ROM tal como están en las imágenes originales (13 carpetas). |
| `Codigo_Fuente_Coleccion/` | Réplica depurada que contiene solo el código fuente y los recursos (2361 ficheros, ~24,5 MiB). |
| `scripts/` | Herramientas de extracción y verificación (Python). |
| `tools/` | Fuentes en C del decodificador Quantum usado durante el análisis del formato. |
| `metadata/` | Manifiestos de hashes SHA-256 y tablas CSV de extracción. |
| `docs/FORMATOS.md` | Documentación técnica de los formatos de empaquetado y del método de extracción. |
| `work/` | Material generado localmente (ISOs, extracciones intermedias). **No se versiona.** |

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
| **Volumen total de datos** | **457,56 MB** (13 imágenes ISO) |
| **Rango de producción** | 13 de noviembre de 1997 — 2 de abril de 1998 |
| **Archivos escaneados** | 4.820 |
| **Líneas de código fuente (LOC)** | 522.102 |
| **Líneas de comentarios** | 87.623 (16,8 %) |

### Principales tipos de fichero

- Cabeceras C/C++ (`.H`): 862
- Código C++ (`.CPP` / `.C`): 795
- Ensamblador (`.ASM` / `.INC`): 92
- Recursos y diálogos Win32 (`.RC`): 289
- Proyectos Borland IDE (`.IDE`): 238

---

## Extracción y verificación de integridad

Los instaladores de los CD usan contenedores `.PAK` propios, que en realidad son dos formatos distintos (detalle completo en [`docs/FORMATOS.md`](docs/FORMATOS.md)):

| Colección | Formato del `.PAK` | Resultado |
| :--- | :--- | :--- |
| Turbo C++ (10 CD) | Archivos **Quantum** (`.Q`, David Stafford) | 223 PAK → 1.714 ficheros extraídos |
| Turbo Assembler (3 CD) | **LHA** (`-lh5-`) | 24 PAK → 209 ficheros extraídos |

**Verificación**

- C++: 1.348 ficheros son idénticos al árbol de instalación, 362 existen solo dentro de los PAK y 4 diferencias fueron falsos positivos de comparación.
- Turbo Assembler: los 209 ficheros coinciden byte a byte con el árbol de instalación.
- Hashes SHA-256: 13 ISOs y 1.924 ficheros extraídos, todos verificados.

Los hashes de cada ISO y de cada fichero extraído están en `metadata/`.

---

## Reproducir

Requisitos: Python 3, `7z` (con soporte LHA), y para la extracción Quantum, Wine, Xvfb y xdotool (el descompresor original `UNPAQ.EXE` es un programa Win16).

Coloca las 13 ISOs en `work/ISOs_Originales/` y ejecuta desde la raíz del repositorio:

```sh
python3 scripts/pak_manifest.py     # manifiesto de cabeceras de los PAK
python3 scripts/fastextract.py      # extracción C++ (Wine + Xvfb, en paralelo)
python3 scripts/verify_tasm.py      # verificación de los PAK de Turbo Assembler

# Verificación de integridad
(cd work && sha256sum -c ../metadata/MANIFEST_isos.sha256)
(cd work && sha256sum -c ../metadata/MANIFEST_extraidos.sha256)
```

La extracción completa tarda unos 100 segundos con 8 procesos en paralelo.

---

## Arquitectura de software y paradigma

A diferencia de otros cursos de la época basados en abstracciones propietarias, el código revela una enseñanza orientada a la **Win32 API pura** y a la optimización con ensamblador de 32 bits:

```text
[Aplicación Win32 (C++)]  --->  [Win32 API (windows.h)]  --->  [GDI / User32]
         │
         └───> [Módulos TASM32 (STDCALL / FLAT)]  --->  [Subrutinas en ensamblador]
```

### Hallazgos sobre la API de Windows 95

- **Sin frameworks propietarios**: OWL (Object Windows Library) está ausente (0 %), por lo que el curso prioriza el bucle de mensajes nativo.
- **Funciones raíz de Win32**:
    - `WinMain`: 172 declaraciones
    - `WndProc` / `DefWindowProc`: 332 llamadas
    - `CreateWindow`: 117 llamadas
- **GDI**: uso intensivo de `TextOut` (202) y `BitBlt` (120) para manipular mapas de bits en memoria.
- **Integración C++ / ensamblador de 32 bits**: presente en 243 ficheros, con rutinas en modo FLAT compiladas con TASM 5.0.

---

## Nota legal y propósito

Este repositorio tiene un propósito educativo, de investigación y de preservación de la historia de la informática. Las imágenes ISO originales no se publican (`work/` está excluido del control de versiones). El código de los ejemplos y ejercicios pertenece a sus autores y editores; las herramientas, librerías y marcas de Borland y Microsoft pertenecen a sus respectivos titulares. Si eres titular de derechos y deseas que se retire algún contenido, abre una incidencia.