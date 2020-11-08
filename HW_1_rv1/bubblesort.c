#include <stdio.h>

int main()
{
    int arr[] = {-1, 3, -5, 7, -9, 2, -4, 6, -8, 10};
    int n = 10;
    for (int i = 0; i < n; ++i)
    {
        for (int j = i + 1; j < n; ++j)
        {
            if (arr[j] < arr[i])
            {
                int tmp = arr[j];
                arr[j] = arr[i];
                arr[i] = tmp;
            }
        }
    }

    for (int i = 0; i < n; ++i)
    {
        printf("%d ", arr[i]);
    }
    puts("");

    return 0;
}