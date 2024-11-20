// Реализация на упрощенном С
#include <stdio.h>


int main()
{
	int seed[4]; //88675123
	scanf("%u", &seed[0]);

	seed[1] = 123456789;
	seed[2] = 362436069;
	seed[3] = 521288629;

	unsigned n;
	scanf("%u", &n);
	int i = 0;

cycle_start:
	int t, s, tmp, s_tmp;
	if (i == n) goto cycle_end;
		t = seed[3];
		s = seed[0];

		seed[3] = seed[2];
		seed[2] = seed[1];
		seed[1] = s;

		tmp = t;
		tmp<<= 11;
		t ^= tmp;

		tmp = t;
		tmp=tmp >> 8;
		t ^= tmp;

		s_tmp = s;
		s_tmp >>= 19;
		s=s^s_tmp;
		t=t^s;
		seed[0] = t;
		printf("%u ", seed[0]);
		i+=1;
	
		goto cycle_start;
cycle_end:
	return 0;
}