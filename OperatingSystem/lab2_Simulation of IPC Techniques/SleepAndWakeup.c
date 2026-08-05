#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

// Shared state
int signalled = 0;

// Mutex + condition variable
pthread_mutex_t mtx = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cv = PTHREAD_COND_INITIALIZER;

// Simple logger
void log_msg(const char *who, const char *msg) {
    printf("[%s] %s\n", who, msg);
}

// Sleep function (wait for signal)
void* sleep_thread(void* arg) {
    log_msg("SLEEP", "Going to sleep...");

    pthread_mutex_lock(&mtx);

    while (!signalled) {
        pthread_cond_wait(&cv, &mtx);
    }

    pthread_mutex_unlock(&mtx);

    log_msg("SLEEP", "Woken up!");
    return NULL;
}

// Wakeup function (send signal)
void* wakeup_thread(void* arg) {
    sleep(1); // simulate delay

    pthread_mutex_lock(&mtx);

    signalled = 1;
    log_msg("WAKEUP", "Sending wake signal...");

    pthread_cond_signal(&cv);

    pthread_mutex_unlock(&mtx);

    return NULL;
}

int main() {
    pthread_t t1, t2;

    pthread_create(&t1, NULL, sleep_thread, NULL);
    pthread_create(&t2, NULL, wakeup_thread, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    pthread_mutex_destroy(&mtx);
    pthread_cond_destroy(&cv);

    return 0;
}