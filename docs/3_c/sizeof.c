#include <stdio.h>
//#include <stdlib.h>
#include <stdint.h>

typedef struct
{
    uint8_t oppacity;
    uint8_t RGB[20];
} Color;


// Assumes little endian
void printBits(size_t const size, void const * const ptr)
{
    unsigned char *b = (unsigned char*) ptr;
    unsigned char byte;
    int i, j;

    for (i=size-1;i>=0;i--)
    {
        for (j=7;j>=0;j--)
        {
            byte = (b[i] >> j) & 1;
            printf("%u", byte);
        }
    }
    puts("");
}

int main()
{
	uint8_t a;
	a =       42; printBits(sizeof(a), &a); // decimal
	a =     0x2a; printBits(sizeof(a), &a); // hexadecimal
	a =      052; printBits(sizeof(a), &a); // octal
	a = 0b101010; printBits(sizeof(a), &a); // binary


	_Bool e = 0;
	uintptr_t po;


	printf("SIZES:\n");
	printf("\tchar:          %zu bytes (%zu bits)\n", sizeof(char), sizeof(char)*8);
	printf("\tunsigned char: %zu bytes (%zu bits)\n", sizeof(unsigned char), sizeof(unsigned char)*8);
	printf("\tsigned char:   %zu bytes (%zu bits)\n", sizeof(signed char), sizeof(signed char)*8);

	printf("\n");
	printf("\tshort:         %zu bytes (%zu bits)\n", sizeof(short), sizeof(short)*8);
	printf("\tunsigned short:%zu bytes (%zu bits)\n", sizeof(unsigned short), sizeof(unsigned short)*8);
	printf("\tint:           %zu bytes (%zu bits)\n", sizeof(int), sizeof(int)*8);
	printf("\tunsigned int:  %zu bytes (%zu bits)\n", sizeof(unsigned int), sizeof(unsigned int)*8);
	printf("\tlong:          %zu bytes (%zu bits)\n", sizeof(long), sizeof(long)*8);
	printf("\tunsigned long: %zu bytes (%zu bits)\n", sizeof(unsigned long), sizeof(unsigned long)*8);

	printf("\n");
	printf("\tfloat:         %zu bytes (%zu bits)\n", sizeof(float), sizeof(float)*8);
	printf("\tdouble:        %zu bytes (%zu bits)\n", sizeof(double), sizeof(double)*8);
	printf("\tlong double:   %zu bytes (%zu bits)\n", sizeof(long double), sizeof(long double)*8);

	printf("\n");
	printf("\tpointer:       %zu bytes (%zu bits)\n", sizeof(void *), sizeof(void *)*8);
	printf("\tcustom struct: %zu bytes (%zu bits)\n", sizeof(Color), sizeof(Color)*8);
	printf("\tvoid:          %zu bytes (%zu bits)\n", sizeof(void), sizeof(void)*8);
}