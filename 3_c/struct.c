

#include <stdio.h>  // For using printf
#include <string.h> // For using memcpy

typedef struct
{
	unsigned int age;
	unsigned int height;
} person;



int main(int argc, char const *argv[])
{
	
	person juan = { .age = 15, .height = 123 };
	person pedro;
	person luis;

	pedro = juan; // Copy by value

	//     dest   source  number of bytes
	memcpy(&luis, &juan,  sizeof(person)  ); // Copy by value

	printf("juan = %d, %d\n", juan.age, juan.height);
	printf("pedro = %d, %d\n", pedro.age, pedro.height);
	printf("luis = %d, %d\n", luis.age, luis.height);

	juan.age++;


	printf("juan = %d, %d\n", juan.age, juan.height);
	printf("pedro = %d, %d\n", pedro.age, pedro.height);

	return 0;
}