
#include <stdio.h>

void no_stdout_buffer__() { setvbuf(stdout,0,_IONBF,0); }
