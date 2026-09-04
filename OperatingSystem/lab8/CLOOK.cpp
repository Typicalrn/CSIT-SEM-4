#include<stdio.h>
#include<stdlib.h>

int cmp(const void *a, const void *b){
    return (*(int*)a - *(int*)b);
}

int main(){
    int n, i, head, total_seek = 0;

    printf("Enter number of requests: ");
    scanf("%d", &n);

    int requests[n];
    printf("Enter the requests: ");
    for(i = 0; i < n; ++i){
        scanf("%d", &requests[i]);
    }

    printf("Enter initial head position: ");
    scanf("%d", &head);

    qsort(requests, n, sizeof(int), cmp);

    printf("\nSeek Sequence (moving towards higher end):\n%d", head);

    int split = 0;
    for(i = 0; i < n; ++i){
        if(requests[i] >= head){
            split = i;
            break;
        }
        split = n;   /* all requests are smaller than head */
    }

    /* Step 1: serve requests >= head, moving up */
    for(i = split; i < n; ++i){
        total_seek += abs(requests[i] - head);
        head = requests[i];
        printf(" -> %d", head);
    }

    /* Step 2: jump directly to the smallest pending request (no wasted travel to disk end) */
    if(split > 0){
        total_seek += abs(requests[0] - head);
        head = requests[0];
        printf(" -> %d", head);

        /* Step 3: serve the rest moving up */
        for(i = 1; i < split; ++i){
            total_seek += abs(requests[i] - head);
            head = requests[i];
            printf(" -> %d", head);
        }
    }

    printf("\n\nTotal Seek Time = %d", total_seek);
    printf("\nAverage Seek Time = %.2f", (float)total_seek / n);

    return 0;
}
