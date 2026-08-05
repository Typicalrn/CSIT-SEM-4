#include <iostream>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <queue>
#include <chrono>

const int CHAIRS = 3; // Waiting room capacity
std::queue<int> waitingRoom;

std::mutex mtx;
std::condition_variable barberReady;
std::condition_variable customerReady;

bool barberSleeping = true;

void barber() {
    while (true) {
        std::unique_lock<std::mutex> lock(mtx);

        // Barber waits if there are no customers
        customerReady.wait(lock, [] { return !waitingRoom.empty(); });

        int customerId = waitingRoom.front();
        waitingRoom.pop();
        std::cout << "Barber is cutting hair of Customer " << customerId << "\n";

        lock.unlock();
        std::this_thread::sleep_for(std::chrono::seconds(2)); // Cutting hair

        lock.lock();
        std::cout << "Barber finished haircut of Customer " << customerId << "\n";
        barberSleeping = waitingRoom.empty(); // Go back to sleep if no one is waiting
        lock.unlock();
    }
}

void customer(int id) {
    std::unique_lock<std::mutex> lock(mtx);
    if (waitingRoom.size() >= CHAIRS) {
        std::cout << "Customer " << id << " left � no empty chairs.\n";
        return;
    }

    waitingRoom.push(id);
    std::cout << "Customer " << id << " is waiting.\n";

    if (barberSleeping) {
        barberSleeping = false;
        customerReady.notify_one(); // Wake up the barber
    }
}

int main() {
    std::thread barberThread(barber);

    int customerId = 1;
    while (customerId <= 5) {
        std::this_thread::sleep_for(std::chrono::milliseconds(500)); // new customer arrives
        std::thread(customer, customerId++).detach(); // spawn and detach customer
    }

    barberThread.join();
    return 0;
}
