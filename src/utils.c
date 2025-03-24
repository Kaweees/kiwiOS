#include "../include/utils.h"
#include <stdio.h>
#include <stdlib.h>

/**
 * @brief panic - A function that prints an error message and exits the program
 * @param str - a pointer to the error message to print
 */
void panic(char* str) {
  fprintf(stderr, "%s\n", str);
  exit(EXIT_FAILURE);
}

/**
 * @brief usage - A function that prints the proper usage of the program and
 * exits unsuccessfully.
 * @param prog_name - a pointer to the program name
 */
void usage(char* prog_name) {
  fprintf(stderr, USAGE_STRING, prog_name);
  exit(EXIT_FAILURE);
}