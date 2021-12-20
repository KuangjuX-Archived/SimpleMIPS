#include "soc_io.h"

int is_leap_year(int n) {
	return (n % 4 == 0 && n % 100 != 0) || (n % 400 == 0);
}

int ans[] = {0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0};

#define NR_DATA (sizeof(ans) / sizeof(ans[0]))

int main() {
	init();
	int flag = 0;
	int i;
	for(i = 0; i < NR_DATA; i ++) {
		if(is_leap_year(i + 1890) != ans[i]){
			flag = 1 ;
			break;
		}
	}

	if(i != NR_DATA)	flag = 1;

	print_result(flag == 0);
	while(1);

	return 0;
}
