#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void* my_function(void* arg) {
    printf("Thread is running!\n");
    return NULL;
}

int main() {
    pthread_t thread_id;
    int result;

    // Create the thread and capture the return value
    result = pthread_create(&thread_id, NULL, my_function, NULL);

    // Check if the thread was created successfully
    if (result == 0) {
        printf("Thread created successfully.\n");
    } else {
        // Use strerror to print the human-readable error message
        fprintf(stderr, "Error: Thread creation failed: %s\n", strerror(result));
        return 1;
    }

    // Wait for the thread to finish
    pthread_join(thread_id, NULL);
    return 0;
}
