// Simplified C++ implementation of Contiguous File Allocation (First-Fit)
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

struct File {
    string name;
    int size;
};

struct Block {
    bool occupied = false;
    string filename;
};

vector<Block> memory(16);
vector<pair<string, int>> allocatedFiles; // filename, start index

int emptyCount() {
    int count = 0;
    for (auto &b : memory) count += !b.occupied;
    return count;
}

bool fileExists(const string &name) {
    for (auto &b : memory)
        if (b.occupied && b.filename == name) return true;
    return false;
}

void allocate(File file) {
    if (fileExists(file.name)) {
        cout << "File already exists\n";
        return;
    }

    int start = -1, count = 0;
    for (int i = 0; i < (int)memory.size(); i++) {
        if (!memory[i].occupied) {
            if (count == 0) start = i;
            count++;
            if (count == file.size) break;
        } else {
            count = 0;
        }
    }

    if (count < file.size) {
        cout << "Not enough contiguous space for " << file.name << "\n";
        return;
    }

    for (int i = start; i < start + file.size; i++) {
        memory[i].occupied = true;
        memory[i].filename = file.name;
    }
    allocatedFiles.push_back({file.name, start});
    cout << "File " << file.name << " allocated at blocks " << start
         << " to " << start + file.size - 1 << "\n";
}

void deallocate(const string &name) {
    if (!fileExists(name)) {
        cout << "File does not exist\n";
        return;
    }
    for (auto &b : memory)
        if (b.filename == name) {
            b.occupied = false;
            b.filename = "";
        }
    allocatedFiles.erase(remove_if(allocatedFiles.begin(), allocatedFiles.end(),
                          [&](const pair<string, int> &p) { return p.first == name; }),
                          allocatedFiles.end());
    cout << "File " << name << " deleted\n";
}

void showTable() {
    cout << "\nFile\t\tStart\tEnd\n";
    for (auto &f : allocatedFiles) {
        int start = f.second, end = start;
        while (end < (int)memory.size() && memory[end].filename == f.first) end++;
        cout << f.first << "\t\t" << start << "\t" << end - 1 << "\n";
    }
    cout << "Free blocks: " << emptyCount() << "\n\n";
}

int main() {
    allocate({"home.txt", 5});
    allocate({"Report.docx", 6});
    allocate({"new_img.png", 3});
    allocate({"test.cpp", 2});
    showTable();

    deallocate("Report.docx");
    deallocate("test.cpp");
    showTable();

    allocate({"hello.jpeg", 8}); // fails: fragmented free space
    showTable();

    return 0;
}
