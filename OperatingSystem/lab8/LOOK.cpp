#include<stdio.h>
#include<stdlib.h>

int cmp(const void *a, const void *b){
    return (*(int*)a - *(int*)b);
}

int main(){
    int n, i, head, total_seek = 0, direction;

    printf("Enter number of requests: ");
    scanf("%d", &n);

    int requests[n];
    printf("Enter the requests: ");
    for(i = 0; i < n; ++i){
        scanf("%d", &requests[i]);
    }

    printf("Enter initial head position: ");
    scanf("%d", &head);

    printf("Enter direction (1 = towards higher end, 0 = towards lower end): ");
    scanf("%d", &direction);

    qsort(requests, n, sizeof(int), cmp);

    printf("\nSeek Sequence:\n%d", head);

    if(direction == 1){
        for(i = 0; i < n; ++i){
            if(requests[i] >= head){
                total_seek += abs(requests[i] - head);
                head = requests[i];
                printf(" -> %d", head);
            }
        }
        for(i = n - 1; i >= 0; --i){
            if(requests[i] < head){
                total_seek += abs(head - requests[i]);
                head = requests[i];
                printf(" -> %d", head);
            }
        }
    } else {
        for(i = n - 1; i >= 0; --i){
            if(requests[i] <= head){
                total_seek += abs(head - requests[i]);
                head = requests[i];
                printf(" -> %d", head);
            }
        }
        for(i = 0; i < n; ++i){
            if(requests[i] > head){
                total_seek += abs(requests[i] - head);
                head = requests[i];
                printf(" -> %d", head);
            }
        }
    }

    printf("\n\nTotal Seek Time = %d", total_seek);
    printf("\nAverage Seek Time = %.2f", (float)total_seek / n);

    return 0;
}
