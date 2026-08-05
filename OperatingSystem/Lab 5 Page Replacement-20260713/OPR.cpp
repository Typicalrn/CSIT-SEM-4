#include<stdio.h>
int findOptimal(int frames[], int pages[], int no_of_frames, int no_of_pages, int index){
    int i, j, farthest = -1, pos = -1, k, found;
    for(i = 0; i < no_of_frames; ++i){
        found = 0;
        for(j = index; j < no_of_pages; ++j){
            if(frames[i] == pages[j]){
                found = 1;
                if(j > farthest){
                    farthest = j;
                    pos = i;
                }
                break;
            }
        }
        if(found == 0){       /* page never used again -> evict it immediately */
            return i;
        }
    }
    if(pos == -1){
        pos = 0;
    }
    return pos;
}
int main()
{
    int no_of_frames, no_of_pages, frames[10], pages[30], flag1, flag2, i, j, pos, faults = 0;
    printf("Enter number of frames: ");
    scanf("%d", &no_of_frames);
    printf("Enter number of pages: ");
    scanf("%d", &no_of_pages);
    printf("Enter reference string: ");
    for(i = 0; i < no_of_pages; ++i){
        scanf("%d", &pages[i]);
    }
    for(i = 0; i < no_of_frames; ++i){
        frames[i] = -1;
    }
    for(i = 0; i < no_of_pages; ++i){
        flag1 = flag2 = 0;
        for(j = 0; j < no_of_frames; ++j){
            if(frames[j] == pages[i]){
                flag1 = flag2 = 1;
                break;
            }
        }
        if(flag1 == 0){
            for(j = 0; j < no_of_frames; ++j){
                if(frames[j] == -1){
                    faults++;
                    frames[j] = pages[i];
                    flag2 = 1;
                    break;
                }
            }
        }
        if(flag2 == 0){
            pos = findOptimal(frames, pages, no_of_frames, no_of_pages, i + 1);
            faults++;
            frames[pos] = pages[i];
        }
        printf("\n");
        for(j = 0; j < no_of_frames; ++j){
            printf("%d\t", frames[j]);
        }
    }
    printf("\n\nTotal Page Faults = %d", faults);
    return 0;
}
