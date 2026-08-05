// C++ implementation of the Linked
// File Allocation Method
#include <iostream>
#include <vector>
using namespace std;

// File Class
class File {
public:
    // Name of File
    string filename;
    // Size of file
    size_t size;

    // Partition no is which part of
    // file is present at a particular
    // block of memory
    int partition;
};

// Block Class
class Block {
    // If Block is occupied
    // by a file or not
    bool occupied = false;

    // File of the block
    File file;

    // Location of next partition in given memory
    // By default, it is set to -1
    // which indicates there is no next partition
    int next = -1;

public:
    // This will set file into current block
    // and set occupied flag
    void set_file(File file)
    {
        this->file = file;
        occupied = true;
    }

    // This will return filename of given block
    string get_file_name()
    {
        return file.filename;
    }
    // Return partition number of file
    int get_file_partition_no()
    {
        return file.partition;
    }

    // Return if the block is empty or not
    bool is_empty()
    {
        return !occupied;
    }

    // This will set the occupied flag as false
    // meaning that it will free the memory
    void set_empty()
    {
        occupied = false;
    }

    // This function will set location of next
    // partition in given memory
    void set_next(int next)
    {
        this->next = next;
    }

    // This function will return location
    // of next partition
    int get_next()
    {
        return next;
    }
};

// Function to return the number of
// empty Blocks from given memory
int get_empty_count(vector<Block> memory)
{
    int sum = 0;
    vector<Block>::iterator slot;

    // Count no. of empty blocks in given memory
    for (slot = memory.begin();
         slot != memory.end(); slot++)
        sum += (*slot).is_empty();

    // Return the empty count
    return sum;
}

// Function to generate random indexes
// from empty memory slots to test indexing
int generate_index(vector<Block> memory)
{
    int index = -1;

    // Check if memory is full
    if (!get_empty_count(memory) == 0) {
        // Here it will generate index until
        // the memory block at generated
        // index is found to be empty
        do {
            index = rand() % memory.size();
            index = abs(index);
        } while (!memory.at(index).is_empty());
    }
    return index;
}

// This function will return if the file
// exists in a given memory
bool file_exists(vector<Block> memory,
                 string name)
{
    vector<Block>::iterator slot;

    for (slot = memory.begin();
         slot != memory.end(); slot++)
        if (!(*slot).is_empty()
            && (*slot).get_file_name()
                   == name)
            return true;

    return false;
}

// This function will set the file in memory
void set_linked_memory(vector<Block>* memory,
                       vector<int>* index_page,
                       File file)
{
    int index = -1, prev = -1, i = 0;

    // Check if file exists already
    if (!file_exists((*memory), file.filename)) {

        // Check if memory is available
        // according to file size
        if (get_empty_count(*memory) >= file.size) {

            // Generate empty index
            index = generate_index(*memory);

            // Push 1st index to index page
            (*index_page).push_back(index);
            for (i = 0; i < file.size - 1; i++) {
                // Set partition
                file.partition = i;

                // Set file into memory
                (*memory).at(index).set_file(file);

                // Note down prev index before
                // generating next index
                prev = index;

                // Generate empty index
                index = generate_index(*memory);

                // Set the next location to generated
                // index in previous index
                (*memory).at(prev).set_next(index);
            }

            // Set last partition and file
            file.partition = file.size - 1;
            (*memory).at(index).set_file(file);

            cout << "File " << file.filename
                 << " has been successfully allocated"
                 << endl;
        }
        else
            cout << "Not enough available memory"
                 << endl;
    }
    else
        cout << "File already exists in given memory"
             << endl;
}

// Function will delete the file from
// memory specified by name
void delete_from_linked_memory(vector<Block>* memory,
                               vector<int>* index_page,
                               string file)
{
    int index, next, previous, main_index, i = 0;
    vector<int>::iterator slot;

    // Check if file exists
    if (file_exists((*memory), file)) {

        // Iterate through the index page
        // to find 1st partition
        for (slot = (*index_page).begin();
             slot != (*index_page).end();
             slot++) {

            // Check if file stored at index has
            // the same name we wish to delete
            if ((*memory)
                    .at(*slot)
                    .get_file_name()
                == file) {
                // Main index is w.r.t memory location
                main_index = (*slot);

                // index is w.r.t index page
                // entry location
                index = i;
                break;
            }
            i++;
        }

        // 1st partition
        i = main_index;

        // Check while next location comes as -1
        while (i != -1
               && (*memory)
                          .at(i)
                          .get_file_name()
                      == file) {

            // set the Block free
            (*memory).at(i).set_empty();

            // Note the location into previous
            previous = i;

            // get the next location
            i = (*memory).at(i).get_next();

            // set -1 as next location into
            // previous location
            (*memory).at(previous).set_next(-1);
        }

        // Erase the entry of file from index
        // page as well
        (*index_page)
            .erase((*index_page)
                       .begin()
                   + index);
        cout << "File " << file
             << " has been successfully deleted"
             << endl;
    }
    else {
        cout << "File does not exist in given memory"
             << endl;
    }
}

// Function to display main index page
void show_linked_index(vector<Block> memory,
                       vector<int> index)
{
    int max = 9, i, count;

    // Iterator
    vector<int>::iterator slot;

    // File Name
    string fname;

    // Iterate through all index pages
    for (slot = index.begin();
         slot != index.end(); slot++) {

        if (memory
                .at(*slot)
                .get_file_name()
                .length()
            > max) {
            max = memory
                      .at(*slot)
                      .get_file_name()
                      .length();
            cout << "+" << string(max + 2, '-')
                 << "+---------------+---------"
                 << "----+------------------+";
            cout << "\n|"
                 << string(max / 2 + max % 2 - 4,
                           ' ')
                 << "File Name"
                 << string(max / 2 - 3, ' ');
            cout << "| Start Address | End Address"
                 << " | Size of the file |\n+"
                 << string(max + 2, '-');
            cout << "+---------------+--------"
                 << "-----+------------------+"
                 << endl;
        }
    }

    // Iterate through index
    for (slot = index.begin();
         slot != index.end();
         slot++) {

        i = (*slot);
        fname = memory
                    .at(i)
                    .get_file_name();
        count = 1;
        while (memory.at(i).get_next() != -1
               && memory
                          .at(i)
                          .get_file_name()
                      == fname) {
            i = memory.at(i).get_next();
            count++;
        }

        cout << "|" << string(max / 2 + max % 2
                                  - memory
                                            .at(*slot)
                                            .get_file_name()
                                            .length()
                                        / 2
                                  - memory
                                            .at(*slot)
                                            .get_file_name()
                                            .length()
                                        % 2
                                  + 1,
                              ' ')
             << memory
                    .at(*slot)
                    .get_file_name()
             << string(max / 2 - memory.at(*slot).get_file_name().length() / 2 + 1,
                       ' ')
             << "|"
             << string(8
                           - to_string(*slot)
                                     .length()
                                 / 2
                           - to_string(*slot)
                                     .length()
                                 % 2,
                       ' ')
             << (*slot)
             << string(7
                           - to_string(*slot)
                                     .length()
                                 / 2,
                       ' ')
             << "|"
             << string(7
                           - to_string(i)
                                     .length()
                                 / 2
                           - to_string(i)
                                     .length()
                                 % 2,
                       ' ')
             << i
             << string(6
                           - to_string(i)
                                     .length()
                                 / 2,
                       ' ')
             << "|"
             << string(9
                           - to_string(count)
                                     .length()
                                 / 2
                           - to_string(count)
                                     .length()
                                 % 2,
                       ' ')
             << count
             << string(9
                           - to_string(count)
                                     .length()
                                 / 2,
                       ' ')
             << "|" << endl;
    }

    cout << "+" << string(max + 2, '-')
         << "+---------------+----------"
         << "---+------------------+"
         << endl;
}

// Function to check all the partitions of file
// w.r.t filename specified
void show_linked_indexes(vector<Block> memory, vector<int> index_page,
                         string filename)
{
    int index;
    vector<int>::iterator slot;

    // If file exists
    if (file_exists(memory, filename)) {
        cout << "File Name = " << filename;
        cout << "\n+------------------+----------"
             << "--------+------------------+";
        cout << "\n| Current Location |Next part"
             << " Location| Partition Number |";
        cout << "\n+------------------+----------"
             << "--------+------------------+\n";

        // Iterate through all index
        for (slot = index_page.begin();
             slot != index_page.end(); slot++) {
            if (memory
                    .at(*slot)
                    .get_file_name()
                == filename) {
                index = (*slot);
                break;
            }
        }

        // Loop till index is not -1
        while (index != -1) {
            cout << "|"
                 << string(9
                               - to_string(index)
                                         .length()
                                     / 2
                               - to_string(index)
                                         .length()
                                     % 2,
                           ' ')
                 << index
                 << string(9
                               - to_string(index)
                                         .length()
                                     / 2,
                           ' ')
                 << "|"
                 << string(9
                               - to_string(memory
                                               .at(index)
                                               .get_next())
                                         .length()
                                     / 2
                               - to_string(memory
                                               .at(index)
                                               .get_next())
                                         .length()
                                     % 2,
                           ' ')
                 << memory
                        .at(index)
                        .get_next()
                 << string(9
                               - to_string(memory
                                               .at(index)
                                               .get_next())
                                         .length()
                                     / 2,
                           ' ')
                 << "|"
                 << string(9
                               - to_string(memory
                                               .at(index)
                                               .get_file_partition_no())
                                         .length()
                                     / 2
                               - to_string(memory
                                               .at(index)
                                               .get_file_partition_no())
                                         .length()
                                     % 2,
                           ' ')
                 << memory
                        .at(index)
                        .get_file_partition_no()
                 << string(9
                               - to_string(memory
                                               .at(index)
                                               .get_file_partition_no())
                                         .length()
                                     / 2,
                           ' ')
                 << "|" << endl;
            index = memory
                        .at(index)
                        .get_next();
        }

        cout << "+------------------+---------"
             << "---------+------------------+"
             << endl;
    }
    else {
        cout << "Given file does not exist"
             << " in given memory"
             << endl;
    }
}

// Driver Code
int main()
{

    // Declare memory of size 16 Blocks
    vector<Block> memory(16);

    // Declare index page
    vector<int> index_page;
    File temp;
    cout << "Remaining memory :- "
         << get_empty_count(memory) << endl;

    // Set the data
    temp.filename = "home.txt";
    temp.size = 5;
    set_linked_memory(&memory,
                      &index_page,
                      temp);

    temp.filename = "Report.docx";
    temp.size = 6;
    set_linked_memory(&memory,
                      &index_page,
                      temp);

    temp.filename = "new_img.png";
    temp.size = 3;
    set_linked_memory(&memory,
                      &index_page,
                      temp);

    temp.filename = "test.cpp";
    temp.size = 2;
    set_linked_memory(&memory,
                      &index_page,
                      temp);

    cout << "Files have been successfully set"
         << endl;
    cout << "Remaining memory :- "
         << get_empty_count(memory) << endl;

    // Print all the linked index
    show_linked_index(memory, index_page);
    cout << "Now we will check index"
         << " of each partition of ";
    cout << "Report.docx and test.cpp"
         << " before deleting them"
         << endl;

    // Print all the linked index
    show_linked_indexes(memory, index_page,
                        "Report.docx");

    // Print all the linked index
    show_linked_indexes(memory, index_page,
                        "test.cpp");

    // Now delete Report.docx and test.cpp
    delete_from_linked_memory(&memory,
                              &index_page,
                              "Report.docx");
    delete_from_linked_memory(&memory,
                              &index_page,
                              "test.cpp");
    cout << "Remaining memory :- "
         << get_empty_count(memory) << endl;

    // Print all the linked index
    show_linked_index(memory, index_page);

    // Creating hello.jpeg file now
    // and setting it to memory
    temp.filename = "hello.jpeg";
    temp.size = 8;

    // Set Linked memory
    set_linked_memory(&memory,
                      &index_page,
                      temp);
    cout << "Check index page :- "
         << endl;

    // Print all the linked index
    show_linked_index(memory, index_page);

    // Now we will see index for each partition
    // of hello.jpeg
    cout << "Remaining memory :- "
         << get_empty_count(memory) << endl;
    cout << "We will check each partition for"
         << " hello.jpeg ";
    cout << "to see if deleted locations are"
         << " utilized or not"
         << endl;

    // Print all the linked index
    show_linked_indexes(memory,
                        index_page,
                        "hello.jpeg");
    memory.clear();
    memory.shrink_to_fit();
    index_page.clear();
    index_page.shrink_to_fit();

    return 0;
}
