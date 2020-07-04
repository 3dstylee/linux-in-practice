#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <err.h>

#define BUFFER_SIZE	1000
#define ALLOC_SIZE	(100*1024*1024)

static char command[BUFFER_SIZE];
static char file_contents[BUFFER_SIZE];
static char overwrite_data[] = "HELLO";


int main(void)
{
	pid_t pid;

	pid = getpid();
	snprintf(command, BUFFER_SIZE, "cat /proc/%d/maps", pid);

	puts("*** memory map before mapping file ***");
	fflush(stdout);
	system(command);

	FILE *fp;
	if ((fp = fopen("testfile", "r+")) == NULL)
		err(EXIT_FAILURE, "open() failed");

    fgets(file_contents, BUFFER_SIZE, fp);

    puts("");
    printf("*** succeeded to map file: address = %p ***\n", fp);

	puts("");
	puts("*** memory map after fopen file ***");
	fflush(stdout);
	system(command);


	puts("");
    printf("*** file contens before overwrite mapped region: %s", file_contents);

	// overwrite mapped region
    fseek(fp, 0, SEEK_SET);
    fputs(overwrite_data, fp);
    fflush(fp);

    puts("");
    printf("*** overwritten mapped region with: %s\n", overwrite_data);

close_file:
    fclose(fp);
	exit(EXIT_SUCCESS);
}
