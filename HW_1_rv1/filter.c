#include <stdio.h>
#include <stdlib.h>

void sort_window(int *arr)
{
    for (int i = 0; i < 9; ++i)
    {
        for (int j = i + 1; j < 9; ++j)
        {
            if (arr[j] < arr[i])
            {
                int tmp = arr[j];
                arr[j] = arr[i];
                arr[i] = tmp;
            }
        }
    }
}

void print_img(int **arr, int col, int row)
{
    for (int i = 0; i < col; ++i)
    {
        for (int j = 0; j < row; ++j)
        {
            printf("%5d ", arr[i][j]);
        }
        puts("");
    }
}

int main()
{
    int data1[7][7] = {
        {105, 203, 173, 204, 177, 172, 12},
        {15, 250, 199, 199, 190, 210, 115},
        {183, 0, 35, 166, 164, 92, 137},
        {11, 155, 44, 49, 153, 255, 177},
        {228, 122, 150, 216, 74, 191, 219},
        {36, 163, 0, 70, 255, 163, 231},
        {233, 55, 195, 177, 190, 241, 145}};

    int datai[15][10] = {
        {208, 37, 181, 125, 192, 90, 20, 154, 28, 35},
        {231, 108, 9, 114, 66, 51, 14, 68, 246, 222},
        {33, 234, 71, 165, 130, 65, 136, 167, 2, 148},
        {233, 203, 12, 181, 179, 158, 199, 176, 198, 141},
        {162, 245, 25, 193, 228, 121, 239, 191, 209, 37},
        {25, 168, 210, 71, 245, 90, 34, 115, 222, 218},
        {72, 10, 178, 174, 140, 212, 146, 22, 22, 159},
        {140, 217, 81, 168, 36, 150, 120, 59, 102, 90},
        {245, 239, 243, 42, 39, 141, 4, 233, 67, 131},
        {247, 174, 9, 31, 66, 234, 86, 39, 205, 103},
        {41, 194, 112, 128, 215, 73, 42, 211, 111, 20},
        {248, 190, 98, 245, 65, 194, 203, 138, 233, 62},
        {245, 101, 196, 87, 208, 193, 80, 255, 47, 32},
        {124, 168, 203, 150, 63, 98, 135, 20, 68, 47},
        {205, 44, 48, 58, 237, 145, 43, 113, 38, 62}};

    int *data1_o[5];
    int *datai_o[13];

    int data1_col = 7, data1_row = 7;
    int datai_col = 15, datai_row = 10;

    int tmp_window[9] = {0};

    for (int i = 0; i < data1_col - 2; i++)
        data1_o[i] = (int *)calloc(data1_row - 2, sizeof(int));

    for (int i = 0; i < datai_col - 2; i++)
        datai_o[i] = (int *)calloc(datai_row - 2, sizeof(int));

    // get a window of 3x3 pixels

    for (int i = 0; i < data1_col - 2; ++i)
    {
        for (int j = 0; j < data1_row - 2; ++j)
        {
            tmp_window[0] = data1[i][j];
            tmp_window[1] = data1[i][j + 1];
            tmp_window[2] = data1[i][j + 2];
            tmp_window[3] = data1[i + 1][j];
            tmp_window[4] = data1[i + 1][j + 1];
            tmp_window[5] = data1[i + 1][j + 2];
            tmp_window[6] = data1[i + 2][j];
            tmp_window[7] = data1[i + 2][j + 1];
            tmp_window[8] = data1[i + 2][j + 2];

            sort_window(tmp_window);

            data1_o[i][j] = tmp_window[4];
        }
    }

    for (int i = 0; i < datai_col - 2; ++i)
    {
        for (int j = 0; j < datai_row - 2; ++j)
        {
            tmp_window[0] = datai[i][j];
            tmp_window[1] = datai[i][j + 1];
            tmp_window[2] = datai[i][j + 2];
            tmp_window[3] = datai[i + 1][j];
            tmp_window[4] = datai[i + 1][j + 1];
            tmp_window[5] = datai[i + 1][j + 2];
            tmp_window[6] = datai[i + 2][j];
            tmp_window[7] = datai[i + 2][j + 1];
            tmp_window[8] = datai[i + 2][j + 2];

            sort_window(tmp_window);

            datai_o[i][j] = tmp_window[4];
        }
    }

    print_img(data1_o, data1_col - 2, data1_row - 2);
    puts("");
    print_img(datai_o, datai_col - 2, datai_row - 2);

    for (int i = 0; i < data1_col - 2; i++)
        free(data1_o[i]);

    for (int i = 0; i < datai_col - 2; i++)
        free(datai_o[i]);

    return 0;
}