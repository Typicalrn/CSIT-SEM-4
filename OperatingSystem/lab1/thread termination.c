#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void* myThreadFunc(void* arg) {
    printf("Thread1 is running...\n");
    sleep(2);
    printf("Thread1 finished.\n");
    return NULL;
}

int main() {
    pthread_t thread1;
    pthread_create(&thread1, NULL, myThreadFunc, NULL);

    // Detach the thread so that its resources will be automatically cleaned up
    pthread_detach(thread1);

    // Main thread continues without waiting for the detached thread
    printf("Main thread continues...\n");

    // Sleep to allow detached thread to finish
    sleep(3);
    return 0;
}
