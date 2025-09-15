#include <mpi.h>
#include <iostream>
#include <string>

int main(int argc, char** argv) {
    // Initialize MPI
    MPI_Init(&argc, &argv);
    
    // Get process information
    int world_size;  // Total number of processes
    int world_rank;  // This process's rank (ID)
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    int name_len;
    
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);
    MPI_Get_processor_name(processor_name, &name_len);
    
    // Print hello message from each process (C++ style)
    std::cout << "Hello from process " << world_rank 
              << " of " << world_size 
              << " on node " << std::string(processor_name) << std::endl;
    
    // Process 0 (master) prints summary
    if (world_rank == 0) {
        std::cout << "\n=== MPI Job Summary ===" << std::endl;
        std::cout << "Total processes: " << world_size << std::endl;
        std::cout << "Running across multiple nodes" << std::endl;
        std::cout << "Each process printed its hello message" << std::endl;
    }
    
    // Synchronize all processes before finishing
    MPI_Barrier(MPI_COMM_WORLD);
    
    if (world_rank == 0) {
        std::cout << "All processes completed successfully!" << std::endl;
    }
    
    // Clean up MPI
    MPI_Finalize();
    return 0;
}
