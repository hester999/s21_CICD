#include <getopt.h>

#ifndef PARSE_H
#define PARSE_H

typedef struct {
  int regextand;
  int e;
  int i;
  int v;
  int c;
  int l;
  int n;
  int h;
  int s;
  int f;
  int o;
  char *str;
  char *str_e;
} flags;

int parse_params(int argc, char **argv, char *short_options, flags *flag);
void free_flags(flags *flag);

#endif