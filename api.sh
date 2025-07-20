#!/bin/bash

# MoneyPrinterTurbo API Server Startup Script

echo "🚀 Starting MoneyPrinterTurbo API Server"

# Set up CUDA/cuDNN environment
source "$(dirname "$0")/setup_cuda_env.sh"

# Start the API server
python main.py 