#include <stdio.h>
#include <stdlib.h>
#include <mspack.h>
#include <system.h>
#include <qtm.h>
/* uso: qdec <pak> <offset> <window_bits> <total_bytes> <salida> */
int main(int argc, char **argv) {
    struct mspack_system *sys = mspack_default_system;
    if (argc < 6) return 2;
    struct mspack_file *in  = sys->open(sys, argv[1], MSPACK_SYS_OPEN_READ);
    struct mspack_file *out = sys->open(sys, argv[5], MSPACK_SYS_OPEN_WRITE);
    if (!in || !out) return 3;
    sys->seek(in, atol(argv[2]), MSPACK_SYS_SEEK_START);
    struct qtmd_stream *q = qtmd_init(sys, in, out, atoi(argv[3]), 4096);
    if (!q) return 4;
    int err = qtmd_decompress(q, atol(argv[4]));
    qtmd_free(q); sys->close(in); sys->close(out);
    return err ? 10 + err : 0;
}
