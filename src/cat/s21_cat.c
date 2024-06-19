
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "parse.h"

int cat(FILE *file, config conf);

int main(int argc, char **argv) {
  config conf = {0};

  FILE *file;
  char *short_options = "beEnstTv";
  struct option long_options[] = {{"number-nonblank", no_argument, NULL, 'b'},
                                  {"number", no_argument, NULL, 'n'},
                                  {"squeeze-blank", no_argument, NULL, 's'}};

  int error = parse_params(argc, argv, short_options, long_options, &conf);

  if (error) {
    fprintf(stderr, "Error");
    return -1;
  }

  int i = optind;

  while (i < argc) {
    char *file_name = argv[i++];
    file = fopen(file_name, "r");

    if (file == NULL) {
      printf("%s: no such file or directory", file_name);
      printf("\n");
      continue;
    } else {
      cat(file, conf);
    }

    fclose(file);
  }

  return 0;
}

int cat(FILE *file, config conf) {
  int c = 0;
  int non_null = 0;
  int number = 0;
  int empty = 0;
  int prev = 0;

  for (prev = '\n'; (c = fgetc(file)) != EOF; prev = c) {
    if (conf.squeeze_blank) {
      if (prev == '\n' && c == '\n') {
        if (empty) {
          empty = 2;
          if (empty == 2) {
            continue;
          }

        } else {
          empty = 1;
        }
      } else {
        empty = 0;
      }
    }

    if (conf.non_null) {
      if (prev == '\n' && c != '\n') {
        (non_null)++;
        printf("%6d\t", non_null);
      }
    }
    if (conf.number && !conf.non_null) {
      if (prev == '\n') {
        (number)++;
        printf("%6d\t", number);
      }
    }
    if (conf.show_end) {
      if (c == '\n') {
        printf("$");
      }
    }
    if (conf.show_tabs) {
      if (c == '\t') {
        printf("^I");
        continue;
      }
    }
    if (conf.show_nonprinting) {
      if ((c >= 1 && c <= 8) || (c >= 12 && c <= 31)) {
        printf("^%c", c + 64);
        continue;
      } else if (c == 127) {
        printf("^%c", c - 64);
        continue;
      } else if (c >= 128 && c <= 159) {
        printf("M-^%c", c - 64);
        continue;
      } else if (c >= 160) {
        printf("M-%c", c - 128);
        continue;
      }
    }

    printf("%c", c);
  }

  return 0;
}
