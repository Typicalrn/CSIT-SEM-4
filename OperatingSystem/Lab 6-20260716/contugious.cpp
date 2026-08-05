// C++ implementation of the Contiguous
// File Allocation which follow First-Fit
// algorithm
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

    // Partition no. is which part of
    // file is present at a particular
    // block of memory
    int partition;
};
class Block {
    // If Block is occupied
    // by a file or not
    bool occupied = false;

    // File of the block
    File file;

public:
    // This function will set file into
    // current block and set occupied flag
    void set_file(File file)
    {
        this->file = file;
        occupied = true;
    }

    // This function will return
    // filename of given block
    string get_file_name()
    {
        return file.filename;
    }

    // This function will return
    // partition number of file
    int get_file_partition_no()
    {
        return file.partition;
    }

    // This function will return
    // if the block is empty or not
    bool is_empty()
    {
        return !occupied;
    }

    // This function will set the occupied
    // flag as false meaning that it will
    // free the given block
    void set_empty()
    {
        occupied = false;
    }
};

// Function to return the number of
// empty Blocks from given memory
int get_empty_count(vector<Block> memory)
{
    int sum = 0;
    vector<Block>::iterator slot;

    // Count no. of empty blocks in
    // given memory
    for (slot = memory.begin();
         slot != memory.end(); slot++) {
        sum += (*slot).is_empty();
    }

    return sum;
}

// Function will return if the file
// exists in a given memory
bool file_exists(vector<Block> memory,
                 string name)
{
    vector<Block>::iterator slot;

    for (slot = memory.begin();
         slot != memory.end(); slot++) {
        if (!(*slot).is_empty()
            && (*slot).get_file_name() == name) {
            return true;
        }
    }
    return false;
}

// Function will set the file in the memory
// this will follow first fit allocation
void set_contiguous_memory(vector<Block>* memory,
                           vector<int>* index,
                           File file)
{
    bool avail = false;
    int i = 0, count = 0, main_index = 0;
    vector<Block>::iterator slot;

    // Check if the file already exists
    if (file_exists((*memory),
                    file.filename))
        cout << "File already exists"
             << endl;

    else {

        // Iterate through full memory
        for (slot = (*memory).begin();
             slot != (*memory).end(); slot++) {

            // Check if there are
            // contiguous Blocks available
            if ((*slot).is_empty()) {
                count++;

                // This if condition will note
                // the 1st index for each
                // Block empty
                if (count == 1)
                    main_index = i;

                // Check if contiguous
                // Blocks are available,
                // it will set our flag
                // avail as true and break
                if (count == (int)file.size) {
                    avail = true;
                    break;
                }
            }

            // Else if there is even a
            // single non-empty block
            // in between we will set
            // count as 0
            else {
                count = 0;
            }
            i++;
        }

        // If our flag is set,
        // this condition will set
        // our file
        if (avail) {

            // Here starting index of
            // our given file will be
            // pushed in index page
            (*index).push_back(main_index);

            // Utilize count variable
            // again for setting file
            // partition
            count = 0;
            for (int i = main_index;
                 i < main_index + (int)file.size;
                 i++) {
                file.partition = count;
                (*memory).at(i).set_file(file);
                count++;
            }
            cout << "File " << file.filename
                 << " has been successfully"
                 << " allocated"
                 << endl;
        }
        else {
            cout << "The size of the file is"
                 << " greater than"
                 << endl;
            cout << "the greatest slot available"
                 << " in contiguous memory"
                 << endl;
            cout << "Hence, File "
                 << file.filename
                 << " cannot be allocated"
                 << endl;
        }
    }
}

// Function to Delete file from memory
void delete_contiguous_mem(vector<Block>* memory,
                           vector<int>* index_page,
                           string file)
{
    vector<int>::iterator slot;
    int index = 0, i = 0, main_index = 0;

    // Check if the file exist or not
    if (!file_exists((*memory), file))
        cout << "File does not exist" << endl;
    else {

        // Iterate all the indexes
        for (slot = (*index_page).begin();
             slot != (*index_page).end(); slot++) {

            // If specified file is found,
            // this condition will
            // set the value of index no.
            // in index and
            // main_index will have starting
            // location of
            // file in memory
            if ((*memory).at(*slot).get_file_name()
                == file) {
                index = i;
                main_index = (*slot);
                break;
            }
            i++;
        }

        // Iterate through the main index until
        // filename is similar to specified
        // filename and status of Block is
        // not empty
        i = main_index;

        while (i < (int)(*memory).size()
               && (*memory).at(i).get_file_name()
                      == file
               && !(*memory).at(i).is_empty()) {
            // Set the Block as empty
            (*memory).at(i).set_empty();
            i++;
        }

        // Erase entry of file from index page
        (*index_page).erase((*index_page).begin() + index);
        cout << "File " << file
             << " has been successfully deleted"
             << endl;
    }
}

// Function to display main index page
void show_contiguous_index(vector<Block> memory,
                           vector<int> index_page)
{
    size_t max = 9;
    int i, j;

    // File Name
    string fname;

    // Iterate through all index pages
    for (i = 0; i < (int)index_page.size();
         i++) {

        if (memory.at(index_page.at(i))
                .get_file_name()
                .length()
            > max) {
            // Get the length of file
            max = memory.at(index_page
                                .at(i))
                      .get_file_name()
                      .length();

            cout << "+" << string(max + 2, '-')
                 << "+---------------+----"
                 << "---------+-----------"
                 << "-------+\n|"
                 << string(max / 2
                               + max % 2 - 4,
                           ' ')
                 << "File Name"
                 << string(max / 2 - 3, ' ')
                 << "| Start Address | "
                 << " End Address | Size"
                 << " of the file |\n+"
                 << string(max + 2, '-')
                 << "+---------------+-------"
                 << "------+------------------+"
                 << endl;
        }
    }

    // Iterate index_pages
    for (i = 0; i < (int)index_page.size();
         i++) {
        cout << "|"
             << string(max / 2 + max % 2
                           - memory
                                     .at(index_page
                                             .at(i))
                                     .get_file_name()
                                     .length()
                                 / 2
                           - memory
                                     .at(index_page
                                             .at(i))
                                     .get_file_name()
                                     .length()
                                 % 2
                           + 1,
                       ' ')
             << memory.at(index_page.at(i))
                    .get_file_name()
             << string(max / 2
                           - memory
                                     .at(index_page
                                             .at(i))
                                     .get_file_name()
                                     .length()
                                 / 2
                           + 1,
                       ' ')
             << "|"
             << string(8
                           - to_string(index_page
                                           .at(i))
                                     .length()
                                 / 2
                           - to_string(index_page
                                           .at(i))
                                     .length()
                                 % 2,
                       ' ')
             << index_page.at(i)
             << string(7
                           - to_string(index_page
                                           .at(i))
                                     .length()
                                 / 2,
                       ' ')
             << "|";
        j = index_page
                .at(i);
        fname = memory
                    .at(j)
                    .get_file_name();

        // Till j is less than memory size
        while (j < (int)memory.size()
               && !memory
                       .at(j)
                       .is_empty()
               && memory
                          .at(j)
                          .get_file_name()
                      == fname) {
            j++;
        }
        j -= 1;

        // Print the index pages details
        cout << string(7
                           - to_string(j)
                                     .length()
                                 / 2
                           - to_string(j)
                                     .length()
                                 % 2,
                       ' ')
             << j
             << string(6
                           - to_string(j)
                                     .length()
                                 / 2,
                       ' ')
             << "|"
             << string(9
                           - to_string(j
                                       - index_page
                                             .at(i)
                                       + 1)
                                     .length()
                                 / 2
                           - to_string(j
                                       - index_page
                                             .at(i)
                                       + 1)
                                     .length()
                                 % 2,
                       ' ')
             << j - index_page.at(i) + 1
             << string(9
                           - to_string(j
                                       - index_page
                                             .at(i)
                                       + 1)
                                     .length()
                                 / 2,
                       ' ')
             << "|"
             << endl;
    }
    cout << "+" << string(max + 2, '-')
         << "+---------------+------"
         << "-------+------------------+"
         << endl;
}

// Function to display index of each
// partition of specified file
void show_contiguous_indexes(vector<Block> memory,
                             vector<int> index_page,
                             string filename)
{
    int index = 0, i;

    // Iterator
    vector<int>::iterator slot;

    // If file exist then display file
    // index and partition
    if (file_exists(memory, filename)) {
        cout << "File Name = " << filename
             << "\n+------------------+----"
             << "--------------+";

        cout << "\n| Current Location |"
             << " Partition Number |";

        cout << "\n+------------------+-"
             << " -----------------+\n";

        // Iterate through all the index
        for (slot = index_page.begin();
             slot != index_page.end(); slot++) {
            if (memory.at(*slot).get_file_name()
                == filename) {
                index = (*slot);
                break;
            }
        }

        // Loop till memory size is greater than
        // index and file is allocated
        // in them
        while (index < (int)memory.size()
               && memory
                          .at(index)
                          .get_file_name()
                      == filename
               && !memory
                       .at(index)
                       .is_empty()) {
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
                 << "|"
                 << endl;
            index++;
        }
        cout << "+------------------+"
             << "------------------+"
             << endl;
    }
    else
        cout << "File does not exist "
             << "in given memory"
             << endl;
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
         << get_empty_count(memory)
         << endl;

    // Set the data
    temp.filename = "home.txt";
    temp.size = 5;
    set_contiguous_memory(&memory,
                          &index_page,
                          temp);

    temp.filename = "Report.docx";
    temp.size = 6;
    set_contiguous_memory(&memory,
                          &index_page,
                          temp);

    temp.filename = "new_img.png";
    temp.size = 3;
    set_contiguous_memory(&memory,
                          &index_page,
                          temp);

    temp.filename = "test.cpp";
    temp.size = 2;
    set_contiguous_memory(&memory,
                          &index_page,
                          temp);

    cout << "Remaining memory :- "
         << get_empty_count(memory)
         << endl;

    // Function call to show all the
    // memory allocation
    show_contiguous_index(memory,
                          index_page);

    cout << "Now we will check each partition of";
    cout << " Report.docx and test.cpp before"
         << endl;

    cout << "deleting them to see"
         << " which locations ";

    cout << "are going to be set free"
         << " as our slots"
         << endl;

    // Function call to show all the
    // memory allocation
    show_contiguous_indexes(memory,
                            index_page,
                            "Report.docx");

    // Function call to show all the
    // memory allocation
    show_contiguous_indexes(memory,
                            index_page,
                            "test.cpp");

    // Now delete Report.docx & test.cpp

    delete_contiguous_mem(&memory,
                          &index_page,
                          "Report.docx");

    delete_contiguous_mem(&memory,
                          &index_page,
                          "test.cpp");

    cout << "Remaining memory :- "
         << get_empty_count(memory)
         << endl;
    // Function call to show all the
    // memory allocation
    show_contiguous_index(memory,
                          index_page);

    // Creating hello.jpeg file now
    // and setting it to memory
    temp.filename = "hello.jpeg";
    temp.size = 8;
    set_contiguous_memory(&memory,
                          &index_page,
                          temp);

    cout << "Check index page: " << endl;

    // Function call to show all the
    // memory allocation
    show_contiguous_index(memory,
                          index_page);

    return 0;
}
