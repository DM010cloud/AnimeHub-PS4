#include <sstream>
#include <iostream>
#include <orbis/libkernel.h>

int main(void)
{
    int sleepSeconds = 2;

    setvbuf(stdout, NULL, _IONBF, 0);

    sceKernelUsleep(2 * 1000000);

    for (;;) {}
}
