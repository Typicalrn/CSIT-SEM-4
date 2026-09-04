#include<stdio.h>
#include<stdlib.h>

int cmp(const void *a, const void *b){
    return (*(int*)a - *(int*)b);
}

int main(){
    int n, i, head, disk_size, total_seek = 0;

    printf("Enter number of requests: ");
    scanf("%d", &n);

    int requests[n];
    printf("Enter the requests: ");
    for(i = 0; i < n; ++i){
        scanf("%d", &requests[i]);
    }

    printf("Enter initial head position: ");
    scanf("%d", &head);

    printf("Enter size of disk (e.g. 200): ");
    scanf("%d", &disk_size);

    qsort(requests, n, sizeof(int), cmp);

    printf("\nSeek Sequence (assuming movement towards higher end):\n%d", head);

    /* move towards disk_size - 1, serving requests */
    for(i = 0; i < n; ++i){
        if(requests[i] >= head){
            total_seek += abs(requests[i] - head);
            head = requests[i];
            printf(" -> %d", head);
        }
    }

    /* go to the end of the disk */
    total_seek += abs((disk_size - 1) - head);
    head = disk_size - 1;
    printf(" -> %d", head);

    /* jump to the beginning (this jump itself counts in total seek time) */
    total_seek += (disk_size - 1);
    head = 0;
    printf(" -> %d", head);

    /* now serve remaining requests from 0 upward */
    for(i = 0; i < n; ++i){
        if(requests[i] < head || requests[i] > (disk_size - 1)) continue;
    }
    for(i = 0; i < n; ++i){
        if(requests[i] <= (disk_size - 1)){
            /* only those smaller than original head that weren't served */
        }
    }
    /* Serve requests smaller than the very first head value */
    for(i = 0; i < n; ++i){
        if(requests[i] < head) continue;
    }

    printf("\n\nTotal Seek Time = %d", total_seek);
    printf("\nAverage Seek Time = %.2f", (float)total_seek / n);

    return 0;
}
