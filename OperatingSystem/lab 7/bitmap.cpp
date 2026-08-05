#include<stdio.h>
#define MAX_BLOCKS 50
int bitmap[MAX_BLOCKS];
int total_blocks;
void displayBitmap(){
    int i;
    printf("\nBitmap Status:\n");
    for(i = 0; i < total_blocks; ++i){
        printf("%d ", bitmap[i]);
    }
    printf("\n");
}
void allocateBlocks(int n){
    int i, count = 0, start = -1, allocated = 0;
    /* find first n contiguous free blocks */
    for(i = 0; i < total_blocks; ++i){
        if(bitmap[i] == 0){
            if(count == 0) start = i;
            count++;
            if(count == n){
                for(int j = start; j < start + n; ++j)
                    bitmap[j] = 1;
                printf("Allocated blocks %d to %d\n", start, start + n - 1);
                allocated = 1;
                break;
            }
        } else {
            count = 0;
        }
    }
    if(!allocated){
        printf("Allocation failed: not enough contiguous free space\n");
    }
}
void freeBlocks(int start, int n){
    int i;
    if(start < 0 || start + n > total_blocks){
        printf("Invalid block range\n");
        return;
    }
    for(i = start; i < start + n; ++i){
        bitmap[i] = 0;
    }
    printf("Freed blocks %d to %d\n", start, start + n - 1);
}

int main(){
    int choice, n, start;

    printf("Enter total number of disk blocks: ");
    scanf("%d", &total_blocks);

    for(int i = 0; i < total_blocks; ++i){
        bitmap[i] = 0;   /* 0 = free */
    }
    do{
        printf("\n--- Bitmap Free Space Management ---\n");
        printf("1. Allocate blocks\n");
        printf("2. Free blocks\n");
        printf("3. Display bitmap\n");
        printf("4. Exit\n");
        printf("Enter choice: ");
        scanf("%d", &choice);

        switch(choice){
            case 1:
                printf("Enter number of blocks to allocate: ");
                scanf("%d", &n);
                allocateBlocks(n);
                break;
            case 2:
                printf("Enter starting block and number of blocks to free: ");
                scanf("%d %d", &start, &n);
                freeBlocks(start, n);
                break;
            case 3:
                displayBitmap();
                break;
            case 4:
                printf("Exiting...\n");
                break;
            default:
                printf("Invalid choice\n");
        }
    } while(choice != 4);
    return 0;
}
