#include<stdio.h>
#include<stdlib.h>

struct Node{
    int start;
    int length;
    struct Node *next;
};

struct Node *head = NULL;

void createFreeList(int total_blocks){
    /* Initially, the whole disk is one big free block */
    head = (struct Node*)malloc(sizeof(struct Node));
    head->start = 0;
    head->length = total_blocks;
    head->next = NULL;
}

void displayFreeList(){
    struct Node *temp = head;
    printf("\nFree Space List:\n");
    if(temp == NULL){
        printf("No free space available\n");
        return;
    }
    while(temp != NULL){
        printf("Start: %d, Length: %d -> ", temp->start, temp->length);
        temp = temp->next;
    }
    printf("NULL\n");
}

void allocateBlocks(int n){
    struct Node *temp = head, *prev = NULL;
    while(temp != NULL){
        if(temp->length >= n){
            printf("Allocated blocks %d to %d\n", temp->start, temp->start + n - 1);
            if(temp->length == n){
                /* exact fit: remove this node */
                if(prev == NULL)
                    head = temp->next;
                else
                    prev->next = temp->next;
                free(temp);
            } else {
                /* partial fit: shrink the node from the front */
                temp->start += n;
                temp->length -= n;
            }
            return;
        }
        prev = temp;
        temp = temp->next;
    }
    printf("Allocation failed: not enough contiguous free space\n");
}

void freeBlocks(int start, int n){
    struct Node *newNode = (struct Node*)malloc(sizeof(struct Node));
    struct Node *temp = head, *prev = NULL;
    newNode->start = start;
    newNode->length = n;
    newNode->next = NULL;

    /* insert in sorted order by start address */
    while(temp != NULL && temp->start < start){
        prev = temp;
        temp = temp->next;
    }

    if(prev == NULL)
        head = newNode;
    else
        prev->next = newNode;
    newNode->next = temp;

    /* merge with next node if adjacent */
    if(newNode->next != NULL && newNode->start + newNode->length == newNode->next->start){
        struct Node *nextNode = newNode->next;
        newNode->length += nextNode->length;
        newNode->next = nextNode->next;
        free(nextNode);
    }

    /* merge with previous node if adjacent */
    if(prev != NULL && prev->start + prev->length == newNode->start){
        prev->length += newNode->length;
        prev->next = newNode->next;
        free(newNode);
    }

    printf("Freed blocks %d to %d\n", start, start + n - 1);
}

int main(){
    int choice, n, start, total_blocks;

    printf("Enter total number of disk blocks: ");
    scanf("%d", &total_blocks);

    createFreeList(total_blocks);

    do{
        printf("\n--- Linked List Free Space Management ---\n");
        printf("1. Allocate blocks\n");
        printf("2. Free blocks\n");
        printf("3. Display free list\n");
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
                displayFreeList();
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
