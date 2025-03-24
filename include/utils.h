#pragma once

#define UNIMPLEMENTED                                                                                                  \
  do {                                                                                                                 \
    fprintf(stderr, "%s:%d: %s is not implemented yet\n", __FILE__, __LINE__, __func__);                               \
    abort();                                                                                                           \
  } while (0)

#define UNREACHABLE                                                                                                    \
  do {                                                                                                                 \
    fprintf(stderr, "%s:%d: %s is unreachable\n", __FILE__, __LINE__, __func__);                                       \
    abort();                                                                                                           \
  } while (0)

#define UNUSED(x) ((void)(x))

#define USAGE_STRING "Usage: %s [ infile ]\n" /* Program usage string */
#define MIN_ARGS 1
#define MAX_ARGS 2
#define SYSCALL_ERROR -1

/* Begin function prototype declarations */
void panic(char* str);
void usage(char* prog_name);