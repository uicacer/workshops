/*
 * CUDA Math Hello World - Beginner Version with Extensive Comments
 * 
 * This program demonstrates the basics of GPU programming with CUDA.
 * It launches 8 threads on the GPU, each computing the square of its thread ID.
 */

#include <stdio.h>  // For printf() function

/*
 * GPU FUNCTION (called a "kernel")
 * The __global__ keyword tells CUDA this function runs ON THE GPU, not the CPU.
 * This function will be executed by multiple GPU threads simultaneously.
 */
__global__ void compute(int *data) {
    // Get this thread's unique ID number (0, 1, 2, 3, 4, 5, 6, or 7)
    // threadIdx.x is a built-in CUDA variable that tells each thread its ID
    int idx = threadIdx.x;
    
    // Each thread computes the square of its ID and stores it in the array
    // Thread 0 computes 0^2 = 0, thread 1 computes 1^2 = 1, etc.
    data[idx] = idx * idx;  
    
    // Print from the GPU! This shows which thread did what computation
    // Note: GPU printf might appear out of order since threads run in parallel
    printf("GPU thread %d computed %d^2 = %d\n", idx, idx, data[idx]);
}

/*
 * MAIN FUNCTION - runs on the CPU
 * This coordinates the GPU work and manages memory
 */
int main() {
    printf("Starting GPU math computation...\n");
    
    // STEP 1: Allocate memory ON THE GPU
    // We need space for 8 integers (one per GPU thread)
    int *d_data;  // 'd_' prefix means "device" (GPU) memory
    
    // cudaMalloc is like malloc(), but it allocates memory on the GPU
    // 8 * sizeof(int) = space for 8 integers
    cudaMalloc(&d_data, 8 * sizeof(int));
    
    // STEP 2: Launch the GPU kernel
    // The <<<1, 8>>> syntax means:
    //   - 1 block of threads
    //   - 8 threads per block  
    //   - So total: 1 × 8 = 8 threads running in parallel
    // Each of these 8 threads will execute the compute() function simultaneously
    compute<<<1, 8>>>(d_data);
    
    // STEP 3: Wait for all GPU threads to finish
    // cudaDeviceSynchronize() makes the CPU wait until the GPU is completely done
    // Without this, the CPU might continue before the GPU finishes
    cudaDeviceSynchronize();
    
    // STEP 4: Clean up GPU memory
    // cudaFree is like free(), but for GPU memory
    // Always free what you allocate!
    cudaFree(d_data);
    
    printf("GPU computation completed!\n");
    return 0;
}
