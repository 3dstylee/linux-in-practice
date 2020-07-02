#include <unistd.h>
#include <sys/mman.h>
#include <stdio.h>
#include <stdlib.h>
#include <err.h>

#define BUFFER_SIZE 1000
// #define ALLOC_SIZE (100*1024*1024)
#define ALLOC_SIZE (32)

static char command[BUFFER_SIZE];

int main(void)
{
	pid_t pid;

	pid = getpid();
	snprintf(command, BUFFER_SIZE, "cat /proc/%d/maps", pid);

	puts("*** memory map before malloc memory allocation ***");
	fflush(stdout);
	system(command);

	int *array;
 	// ALLOC_SIZEが sizeof(int)で割り切れる必要があるが省略
	array = (int *)malloc(ALLOC_SIZE);
	if (array == NULL)
		err(EXIT_FAILURE, "malloc() failed");

	puts("");
	printf("*** succeeded to allocate memory: address = %p; size = 0x%x ***\n",
           array, ALLOC_SIZE);
	puts("");

	puts("*** memory map after malloc memory allocation ***");
	fflush(stdout);
	system(command);

	free(array);

	exit(EXIT_SUCCESS);
}
