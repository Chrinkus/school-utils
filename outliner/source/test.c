#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
	char  s1[8];
	s1[0] = '\0';

	printf("Size of empty, null-terminated char-array: %zu\n", strlen(s1));

	char* s2 = NULL;
	printf("Size of NULL char-ptr: %zu\n", strlen(s2));
}
