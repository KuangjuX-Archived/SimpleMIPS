
#include "soc_io.h"

#define n 100

int ans[] = {1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0,
             0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1,
             0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0};

//欧拉筛
int main(void) {
    int flag = 1;
    int count = 0;
    int number[101];
    for (int i = 0; i < n + 1; i++) {
        number[i] = 1;
    }
    int prime[n + 1];
    for (int i = 2; i <= n; i++) {
        if (number[i] == 1) prime[count++] = i;
        for (int j = 0; j < count && prime[j] * i <= n; j++) {
            number[prime[j] * i] = 0;
            if (i % prime[j] == 0) break;
        }
    }
    for (int i = 0; i < n + 1; i++)
        if (number[i] != ans[i]) {
            flag = 0;
            break;
        }
    print_result(flag);
    return 0;
}
