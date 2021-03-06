
/* auto-generated by gen_syscalls.py, don't edit */

#ifndef _ASMLANGUAGE

#include <syscall_list.h>
#include <syscall_macros.h>

#ifdef __cplusplus
extern "C" {
#endif

K_SYSCALL_DECLARE2(K_SYSCALL_Z_ZEPHYR_READ_STDIN, z_zephyr_read_stdin, int, char *, buf, int, nbytes)

K_SYSCALL_DECLARE2(K_SYSCALL_Z_ZEPHYR_WRITE_STDOUT, z_zephyr_write_stdout, int, const void *, buf, int, nbytes)

K_SYSCALL_DECLARE2(K_SYSCALL_ZEPHYR_FPUTC, zephyr_fputc, int, int, c, FILE *, stream)

K_SYSCALL_DECLARE4(K_SYSCALL_ZEPHYR_FWRITE, zephyr_fwrite, size_t, const void *_MLIBC_RESTRICT, ptr, size_t, size, size_t, nitems, FILE *_MLIBC_RESTRICT, stream)

#ifdef __cplusplus
}
#endif

#endif
