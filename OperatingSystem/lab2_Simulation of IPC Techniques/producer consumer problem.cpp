#include <iostream>
#include <thread>
#include <queue>
#include <mutex>
#include <condition_variable>

const int MAX_BUFFER_SIZE = 5;
const int TOTAL_ITEMS = 10;

std::queue<int> buffer;
std::mutex mtx;
std::condition_variable cv_producer, cv_consumer;

int count = 0; // number of items in buffer
int producedCount = 0;
int consumedCount = 0;

int producer_item() {
    return producedCount + 1; // create a new item
}

void insert_item(int item) {
    buffer.push(item);
    std::cout << "Produced: " << item << std::endl;
    producedCount++;
}

int remove_item() {
    int item = buffer.front();
    buffer.pop();
    return item;
}

void consume_item(int item) {
    std::cout << "Consumed: " << item << std::endl;
    consumedCount++;
}

void producer() {
    while (producedCount < TOTAL_ITEMS) {
        std::unique_lock<std::mutex> lock(mtx);
        cv_producer.wait(lock, [] { return count < MAX_BUFFER_SIZE; });

        int item = producer_item();
        insert_item(item);
        count++;

        cv_consumer.notify_one(); // wake up consumer
    }
}

void consumer() {
    while (consumedCount < TOTAL_ITEMS) {
        std::unique_lock<std::mutex> lock(mtx);
        cv_consumer.wait(lock, [] { return count > 0; });

        int item = remove_item();
        count--;
        consume_item(item);

        cv_producer.notify_one(); // wake up producer
    }
}

int main() {
    std::thread prodThread(producer);
    std::thread consThread(consumer);

    prodThread.join();
    consThread.join();

    std::cout << "All items produced and consumed.\n";
    return 0;
}
