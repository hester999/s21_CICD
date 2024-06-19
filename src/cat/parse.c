#include "parse.h"

#include <getopt.h>
#include <stdio.h>

int parse_params(int argc, char **argv, char *short_options,
                 struct option long_options[], config *conf) {
  int res;
  int error = 0;

  while ((res = getopt_long(argc, argv, short_options, long_options, NULL)) !=
         -1) {
    switch (res) {
      case 'b':
        conf->non_null = 1;
        break;
      case 'e':
        conf->show_end = 1;
        conf->show_nonprinting = 1;
        break;
      case 'E':
        conf->show_end = 1;
        break;
      case 'n':
        conf->number = 1;
        break;
      case 's':
        conf->squeeze_blank = 1;
        break;
      case 't':
        conf->show_tabs = 1;
        conf->show_nonprinting = 1;
        break;
      case 'T':
        conf->show_tabs = 1;
        break;
      case 'v':
        conf->show_nonprinting = 1;
        break;
      case '?':
        error = 1;
        break;
      default:
        error = 1;
        break;
    }
  }

  return error;
}
