#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>   // <-- FIX ADDED

int main() {
    pid_t pid = fork();

    if (pid < 0) {
        printf("Fork failed\n");
        return 1;
    }

    if (pid == 0) {
        while (1) {
            printf("Child running\n");
            sleep(1);
        }
    } else {
        sleep(5);
        kill(pid, SIGTERM);
        wait(NULL);   // now works
        printf("Child terminated\n");
    }

    return 0;
}