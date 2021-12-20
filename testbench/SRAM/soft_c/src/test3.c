
#define BUF_SIZE 10

int ans[10] = {12, 16, 17, 23, 25, 34, 49, 61, 85, 95};


void QuickSort(int *arr, int low, int high) {
    if (low < high) {
        int i = low;
        int j = high;
        int k = arr[low];
        while (i < j) {
            while (i < j && arr[j] >= k)     // 从右向左找第一个小于k的数
            {
                j--;
            }

            if (i < j) {
                arr[i++] = arr[j];
            }

            while (i < j && arr[i] < k)      // 从左向右找第一个大于等于k的数
            {
                i++;
            }

            if (i < j) {
                arr[j--] = arr[i];
            }
        }

        arr[i] = k;

        // 递归调用
        QuickSort(arr, low, i - 1);     // 排序k左边
        QuickSort(arr, i + 1, high);    // 排序k右边
    }
}


int main() {
    int flag=1;
    int array[BUF_SIZE] = {12, 85, 25, 16, 34, 23, 49, 95, 17, 61};
    int maxlen = BUF_SIZE;
    QuickSort(array, 0, maxlen - 1);  // 快速排序

    for (int i = 0; i < BUF_SIZE; i++) {
        if (ans[i] != array[i]) {
            flag = 0;
            break;
        }
    }
    print_result(flag);
    return 0;
}
