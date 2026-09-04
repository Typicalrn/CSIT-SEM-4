#include<stdio.h>
#include<stdlib.h>

int main(){
    int n, i, j, head, total_seek = 0, min_dist, min_index;

    printf("Enter number of requests: ");
    scanf("%d", &n);

    int requests[n], visited[n];
    printf("Enter the requests: ");
    for(i = 0; i < n; ++i){
        scanf("%d", &requests[i]);
        visited[i] = 0;
    }

    printf("Enter initial head position: ");
    scanf("%d", &head);

    printf("\nSeek Sequence:\n%d", head);

    for(i = 0; i < n; ++i){
        min_dist = 999999;
        min_index = -1;
        for(j = 0; j < n; ++j){
            if(!visited[j] && abs(requests[j] - head) < min_dist){
                min_dist = abs(requests[j] - head);
                min_index = j;
            }
        }
        visited[min_index] = 1;
        total_seek += min_dist;
        head = requests[min_index];
        printf(" -> %d", head);
    }

    printf("\n\nTotal Seek Time = %d", total_seek);
    printf("\nAverage Seek Time = %.2f", (float)total_seek / n);

    return 0;
}
