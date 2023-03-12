#include <stdlib.h>
#include <stdio.h>

#define NCOLUMNS 5
#define NROWS 3


int *tensor2D(size_t rows, size_t cols)
{
	int *tensor = malloc(rows * cols * sizeof(int));
	if (tensor==NULL) fprintf(stderr, "malloc failed\n");

	return tensor;
}

int *tensor3D(size_t dim1, size_t dim2, size_t dim3)
{
	int *tensor = malloc(dim1 * dim2 * dim3 * sizeof(int));
	if (tensor==NULL) fprintf(stderr, "malloc failed\n");

	return tensor;
}

int main()
{
	int (*a)[NCOLUMNS]        = malloc(NROWS * sizeof(*a));
	int (*b)[NROWS][NCOLUMNS] = malloc(sizeof(*b));
	int (*c)[NROWS][NCOLUMNS] = tensor2D(NROWS, NCOLUMNS);

	printf("Array location: %p\n", &a);
	printf("Array location: %p\n", a);
	printf("Array first element: %p\n", a[0]);
	printf("Array first element: %p\n", *a);

	int count = 0;
	for (int i = 0; i < NROWS; ++i)
	{
		for (int j = 0; j < NCOLUMNS; ++j)
		{
			a[i][j] = count;
			count++;
			printf("%d,", a[i][j]);
		}
		printf("\n");
	}

	for (int i = 0; i < NROWS*NCOLUMNS; ++i)
	{
		int *p = a; // pointer cast
		printf("%d,", *(p+i));
	}

	return 0;
}