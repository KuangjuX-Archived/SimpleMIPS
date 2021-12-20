#include "soc_io.h"

#define N 5
int arr[5][9] = {1, 8, 6, 2, 5, 4, 8, 87, 7, 2, 5, 6, 2, 5, 8, 5, 3, 7, 1, 8, 6, 9, 67, 4, 9, 3, 7, 1, 8, 13, 2, 5, 4,
                 12, 3, 96, 1, 8, 9, 2, 4, 4, 8, 7, 7};
int ans[] = {49, 36, 49, 78, 49};

#define MAXSIZE 300
int stack[MAXSIZE] = {0};

int maxArea(int *height, int heightSize) {
    int ret = 0;
    int left = 0;
    int right = heightSize - 1;
    int temp = 0;
    while (left < right) {
        if (height[left] < height[right]) {
            temp = height[left] * (right - left);
            left++;
        } else {
            temp = height[right] * (right - left);
            right--;
        }
        ret = ret > temp ? ret : temp;
    }

    return ret;
}

int main() {
    int flag = 1;
    for (int i = 0; i < N; i++) {
        if (ans[i] != maxArea(arr[i], 9)) {
            flag = 0;
            break;
        }
    }
    print_result(flag);
}