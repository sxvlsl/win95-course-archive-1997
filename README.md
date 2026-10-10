# Preservación Histórica: Curso de Programación para Windows 95 (Planeta DeAgostini, 1997-1998)

Repositorio de preservación digital, análisis de metadatos y consolidación de código fuente del histórico **Curso de Programación para Windows 95** distribuido por **Planeta DeAgostini** en España entre finales de 1997 y principios de 1998.

La obra completa abarca **13 volúmenes en CD-ROM** enfocados en la enseñanza de desarrollo de software para el ecosistema de 32 bits de Microsoft utilizando las herramientas de **Borland**: **Turbo C++ Visual Edition 4.5** y **Turbo Assembler 5.0 (TASM32)**.

---

## Métricas y Análisis del Código Fuente

Tras el volcado e inspección de los 13 discos masterizados mediante *CeQuadrat 32bit ISO-9660 Formatter*, se han extraído y catalogado las siguientes métricas:

| Métrica | Valor Consolidado |
| :--- | :--- |
| **Volumen Total de Datos** | **457.56 MB** (13 imágenes ISO) |
| **Rango de Producción** | 13 de Noviembre de 1997 — 2 de Abril de 1998 |
| **Archivos Totales Escaneados** | **4,820 archivos** |
| **Líneas de Código Fuente (LOC)** | **522,102 líneas** |
| **Líneas de Comentarios** | **87,623 líneas** (16.8% del total) |

### Top Formatos y Fuentes Identificados

- **Archivos de cabecera C/C++ (`.H`)**: 862 archivos
- **Código Fuente C++ (`.CPP` / `.C`)**: 795 archivos
- **Código Fuente Assembler (`.ASM` / `.INC`)**: 92 archivos
- **Recursos y Diálogos Win32 (`.RC`)**: 289 archivos
- **Proyectos Borland IDE (`.IDE`)**: 238 archivos

---

## Arquitectura de Software y Paradigma

A diferencia de otros cursos de la época basados en abstracciones propietarias, el análisis de código revela una enseñanza profunda orientada a la **Win32 API pura** y la optimización a nivel de ensamblador de 32 bits:

```text
[Aplicación Win32 (C++)]  --->  [Win32 API (windows.h)]  --->  [GDI / User32]
         │
         └───> [Módulos TASM32 (STDCALL / FLAT)]  --->  [Subrutinas Ensamblador]
```

## Hallazgos Clave de la API de Windows 95
- Sin dependencia de frameworks propietarios: OWL (Object Windows Library) está ausente (0% de presencia), priorizando el ciclo de mensajes nativo de Windows.
- Ciclo de Mensajes Cánonico: Detección masiva de funciones raíz de Win32:
-- WinMain: 172 declaraciones.
-- WndProc / DefWindowProc: 332 llamadas.
-- CreateWindow: 117 llamadas.
-- Renderizado Gráfico (GDI): Uso intensivo de TextOut (202) y BitBlt (120) para manipulación directa de mapas de bits en memoria.
-- Integración C++ / Assembler de 32 Bits: Presente en 243 archivos, enseñando la integración de rutinas de montaje en modo FLAT de 32 bits compiladas con TASM 5.0.

## Estructura del Repositorio
```txt
├── Codigo_Fuente_Coleccion/    # Fuentes consolidados (.CPP, .C, .ASM, .H, .RC)
├── .gitignore                  # Exclusión de binarios (.EXE, .DLL, .PAK, .ISO)
└── README.md                   # Documentación de preservación
```

## Nota Legal y Propósito
Este repositorio tiene un propósito puramente educativo, de investigación y preservación de la historia de la informática. No se incluyen ejecutables comerciales, librerías compiladas (.DLL/.LIB) ni binarios propietarios de Borland o Microsoft.