#define _GNU_SOURCE
#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <string.h>

#include "grep.h"
#include "parse.h"

int main(int argc, char **argv) {
  flags flag = {0};
  char *short_option = "e:ivclnhsf:o";
  int err = parse_params(argc, argv, short_option, &flag);
  if (err == 1) {
    fprintf(stderr, "Error - parser error");
    return -1;
  } else if (err == 2) {
    return -1;
  }

  if (flag.v && flag.o) flag.o = 0;
  FILE *file;

  char *pattern = flag.e ? flag.str : flag.f ? flag.str : argv[optind];

  for (int i = flag.e || flag.f ? optind : optind + 1; i < argc; ++i) {
    char *file_name = argv[i];
    file = fopen(file_name, "r");

    if (file == NULL) {
      if (!flag.s) {
        fprintf(stderr, "Error: file not found\n");
      }
    } else {
      grep(file, flag, pattern, argc, argv[i]);
      fclose(file);
    }
  }
  free_flags(&flag);

  return 0;
}
