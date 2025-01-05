# import torch
# import time

# def check_cuda_availability():
#     """Check if CUDA (GPU) is available."""
#     device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
#     print(f"CUDA availability: {torch.cuda.is_available()} - Using device: {device}")
#     return device

# def stress_test_gpu(device, iterations=1000000):
#     """Stress test the GPU by performing matrix multiplications."""
#     # Generate large random matrices for multiplication
#     size = 2048  # Define the size of the tensor to multiply (large enough to stress the GPU)
    
#     A = torch.randn(size, size).to(device)  # Create a large tensor and move it to GPU
#     B = torch.randn(size, size).to(device)  # Create another large tensor and move it to GPU
    
#     start_time = time.time()
#     print(f"Starting stress test with {iterations} iterations.")
    
#     for i in range(iterations):
#         C = torch.matmul(A, B)  # Matrix multiplication is a heavy operation on the GPU
#         if (i + 1) % 10 == 0:  # Print status every 10th iteration
#             print(f"Iteration {i+1} complete. Time elapsed: {time.time() - start_time:.2f}s")
    
#     end_time = time.time()
#     total_time = end_time - start_time
    
#     print(f"Stress test completed in {total_time:.2f}s with {iterations} iterations.")
#     return total_time

# def main():
#     device = check_cuda_availability()
    
#     if torch.cuda.is_available():
#         # Use a large number of iterations for stress testing
#         elapsed_time = stress_test_gpu(device, iterations=1000000)
#         print(f"GPU utilization was confirmed by running matrix multiplication operations.")
#     else:
#         print("CUDA is not available. Running CPU-only tests instead.")

# if __name__ == "__main__":
#     main()


import torch
import time

# Set the seed for reproducibility
torch.manual_seed(42)

# Specify the size of the matrix and number of iterations
matrix_size = 5120
num_iterations = 30000

# Define the operation to stress-test on the GPU
def multiply_matrices(x, y):
    return x @ y

# Allocate matrices on GPU (cuda)
matrix_a = torch.randn(matrix_size, matrix_size, device='cuda')
matrix_b = torch.randn(matrix_size, matrix_size, device='cuda')

start_time = time.time()
for _ in range(num_iterations):
    result = multiply_matrices(matrix_a, matrix_b)
elapsed_time = time.time() - start_time

print(f"Performed {num_iterations} matrix multiplications on the GPU in {elapsed_time:.2f} seconds.")