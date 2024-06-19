#include <getopt.h>

#ifndef PARSE_H
#define PARSE_H

typedef struct {
  int non_null;
  int show_end;
  int number;
  int squeeze_blank;
  int show_tabs;
  int show_nonprinting;
} config;

int parse_params(int argc, char **argv, char *short_options,
                 struct option long_options[], config *conf);

#endif