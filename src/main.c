#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "../include/hello.h"
#include "../include/utils.h"

/**
 * @brief Program entry point
 *
 * @param argc - the number of command line arguments
 * @param argv - an array of command line arguments
 * @return int - the exit status
 */
int main(int argc, char* argv[]) {
  if (argc == MIN_ARGS) {
    hello();
  } else {
    usage(*argv);
  }
  return EXIT_SUCCESS;
}