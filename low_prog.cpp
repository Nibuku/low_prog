// Вариант 5
// Реализовать генератор псевдослучайных чисел xorshift128. 
// Используя введенное пользователем число в качестве начальной точки, вывести 100 сгенерированных чисел.

#include <stdio.h>
//#include <stdint.h>

int array[100];

int main()
{
	int seed[4]; //88675123
	scanf("%d", &seed[0]);
	seed[1] = 123456789;
	seed[2] = 362436069;
	seed[3] = 521288629;

	unsigned n;
	scanf("%u", &n);

	for (int i = 0; i < n; ++i) {
		int t = seed[3];
		int s = seed[0];

		seed[3] = seed[2];
		seed[2] = seed[1];
		seed[1] = s;

		t ^= t << 11;
		t ^= t >> 8;
		seed[0] = t ^ s ^ (s >> 19);
		printf("%d ", seed[0]);
	}
	return 0;
}
