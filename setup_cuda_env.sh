#!/bin/bash
# MoneyPrinterTurbo CUDA Environment Setup
# This script sets up the necessary CUDA/cuDNN library paths for compatibility

# Add cuDNN library path so system can find libcudnn_ops_infer.so.8
# This fixes the "libcudnn_ops_infer.so.8: cannot open shared object file" error
if [[ -n "$CONDA_PREFIX" ]]; then
    CUDNN_PATH="$CONDA_PREFIX/lib/python3.11/site-packages/nvidia/cudnn/lib"
    if [[ -d "$CUDNN_PATH" ]]; then
        export LD_LIBRARY_PATH="$CUDNN_PATH:$LD_LIBRARY_PATH"
        echo "✅ Added cuDNN library path: $CUDNN_PATH"
    else
        echo "⚠️  cuDNN library path not found: $CUDNN_PATH"
    fi
else
    echo "⚠️  CONDA_PREFIX not set, skipping cuDNN path setup"
fi

# Set optimal CUDA environment variables
export PYTORCH_CUDA_ALLOC_CONF="max_split_size_mb:32"
export CUDNN_LOGINFO_DBG="0"  # Suppress cuDNN debug info

# Suppress warnings
export PYTHONWARNINGS="ignore::UserWarning:streamlit"

echo "🚀 CUDA environment configured for MoneyPrinterTurbo" 