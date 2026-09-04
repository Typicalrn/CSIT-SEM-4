#include<stdio.h>
#include<stdlib.h>

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

    printf("\nSeek Sequence:\n%d", head);
    for(i = 0; i < n; ++i){
        total_seek += abs(requests[i] - head);
        head = requests[i];
        printf(" -> %d", head);
    }

    printf("\n\nTotal Seek Time = %d", total_seek);
    printf("\nAverage Seek Time = %.2f", (float)total_seek / n);

    return 0;
}
