// Реализация на упрощенном С
#include <stdio.h>

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
	int i = 0;

cycle_start:
	if (i == n) goto cycle_end;
		int t = seed[3];
		int s = seed[0];

		seed[3] = seed[2];
		seed[2] = seed[1];
		seed[1] = s;

		int tmp = t << 11;
		t ^= tmp;

		tmp = t >> 8;
		t ^= tmp;

		int s_tmp = s >> 19;
		t ^= s;
		t ^= s_tmp;
		seed[0] = t 
		printf("%d ", seed[0]);
		i+=1;
	}
goto start_cycle;
cycle_end:
	return 0;
}