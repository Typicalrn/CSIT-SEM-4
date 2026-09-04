#include<stdio.h>

int main()
{
    int i, j, sum = 0, n;
    int d[21];
    int disk;      // current head position
    int temp, max;
    int dloc = -1; // index of head position in sorted array

    printf("enter number of location\t");
    scanf("%d", &n);

    printf("enter position of head\t");
    scanf("%d", &disk);

    printf("enter elements of disk queue\n");
    for (i = 0; i < n; i++)
        scanf("%d", &d[i]);

    d[n] = disk;
    n = n + 1;

    // sorting disk locations (ascending)
    for (i = 0; i < n; i++)
    {
        for (j = i; j < n; j++)
        {
            if (d[i] > d[j])
            {
                temp = d[i];
                d[i] = d[j];
                d[j] = temp;
            }
        }
    }

    max = d[n - 1];   // FIX: was d[n] (out of bounds)

    for (i = 0; i < n; i++)   // find position of head in sorted array
    {
        if (disk == d[i])
        {
            dloc = i;
            break;
        }
    }

    for (i = dloc; i >= 0; i--)
        printf("%d -->", d[i]);

    printf("0 -->");

    for (i = dloc + 1; i < n; i++)
        printf("%d-->", d[i]);

    sum = disk + max;
    printf("\nmovement of total cylinders %d", sum);

    return 0;
}