#include "student_func.h"

__global__
void rgba_to_greyscale(const uchar4* const rgbaImage,
                       unsigned char* const greyImage,
                       int numRows, int numCols)
{
  int row = threadIdx.x;
  int col = blockIdx.x;
  int index = numCols * row + col;

  greyImage[index] = 0.299f * (float)rgbaImage[index].x + 0.587f * (float)rgbaImage[index].y + 0.114f * (float)rgbaImage[index].z;
}

void your_rgba_to_greyscale(const uchar4 * const h_rgbaImage, uchar4 * const d_rgbaImage,
                            unsigned char* const d_greyImage, size_t numRows, size_t numCols)
{
  const dim3 blockSize(numRows, 1, 1);  //TODO
  const dim3 gridSize(numCols, 1, 1);  //TODO
  rgba_to_greyscale<<<gridSize, blockSize>>>(d_rgbaImage, d_greyImage, numRows, numCols);
  
  cudaDeviceSynchronize(); checkCudaErrors(cudaGetLastError());
}
  