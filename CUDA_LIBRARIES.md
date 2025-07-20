# MoneyPrinterTurbo CUDA Libraries Reference

This document lists all CUDA/cuDNN libraries included in the project and their purposes.

## 📦 Installation Files

- `environment.yml` - Complete conda environment with all CUDA libraries
- `requirements-cuda.txt` - Pip-installable CUDA libraries  
- `install_cuda.sh` - Automated CUDA installation script
- `setup_cuda_env.sh` - Runtime CUDA environment setup

## 🔧 CUDA Libraries Installed (Total: 17 packages)

### PyTorch Ecosystem (5 packages)
- `torch==2.5.1` - PyTorch deep learning framework with CUDA 12.1
- `torchaudio==2.5.1` - Audio processing for PyTorch
- `torchvision==0.20.1` - Computer vision for PyTorch  
- `pytorch-lightning==2.5.2` - High-level PyTorch training framework
- `pytorch-metric-learning==2.8.1` - Metric learning utilities

### CUDA Core Libraries (3 packages)
- `cuda-nvrtc=12.9.41` - NVIDIA Runtime Compiler (conda)
- `cuda-version=12.9` - CUDA version information (conda)
- `nvidia-cuda-runtime-cu12==12.4.127` - CUDA runtime (pip)

### cuDNN Libraries (4 packages)
- `cudnn=9.10.0.56` - cuDNN 9.x development libraries (conda)
- `libcudnn=9.10.0.56` - cuDNN 9.x runtime libraries (conda)  
- `libcudnn-dev=9.10.0.56` - cuDNN 9.x development headers (conda)
- `nvidia-cudnn-cu12==8.9.2.26` - cuDNN 8.x compatibility (pip)

### NVIDIA CUDA Libraries (12 packages)
- `nvidia-cublas-cu12==12.4.5.8` - CUDA Basic Linear Algebra Subprograms
- `nvidia-cuda-cupti-cu12==12.4.127` - CUDA Profiling Tools Interface
- `nvidia-cuda-nvrtc-cu12==12.4.127` - CUDA Runtime Compilation
- `nvidia-cufft-cu12==11.2.1.3` - CUDA Fast Fourier Transform
- `nvidia-curand-cu12==10.3.5.147` - CUDA Random Number Generation
- `nvidia-cusolver-cu12==11.6.1.9` - CUDA Linear Algebra Solvers
- `nvidia-cusparse-cu12==12.3.1.170` - CUDA Sparse Matrix Operations
- `nvidia-cusparselt-cu12==0.6.2` - CUDA Sparse Matrix (Low-precision)
- `nvidia-nccl-cu12==2.21.5` - NVIDIA Collective Communications Library
- `nvidia-nvjitlink-cu12==12.4.127` - NVIDIA JIT Linker
- `nvidia-nvtx-cu12==12.4.127` - NVIDIA Tools Extension

## 🎯 Why We Need Dual cuDNN (8.x + 9.x)

**Problem**: Some packages require cuDNN 8.x while others need cuDNN 9.x
- **cuDNN 9.x**: Latest version, used by PyTorch 2.5.1
- **cuDNN 8.x**: Required by some TTS libraries (fixes `libcudnn_ops_infer.so.8` error)

**Solution**: Install both versions
1. Primary: cuDNN 9.x via conda (`cudnn=9.10.0.56`)
2. Compatibility: cuDNN 8.x via pip (`nvidia-cudnn-cu12==8.9.2.26`)

## 🚀 Installation Methods

### Method 1: Conda (Recommended)
```bash
conda env create -f environment.yml  # Installs everything
```

### Method 2: Automated Script
```bash
./install_cuda.sh  # Step-by-step installation
```

### Method 3: Manual Pip
```bash
pip install -r requirements-cuda.txt
pip install nvidia-cudnn-cu12==8.9.2.26 --force-reinstall --no-deps
```

## 🔍 Verification

Check CUDA installation:
```bash
python -c "
import torch
print(f'PyTorch: {torch.__version__}')  
print(f'CUDA Available: {torch.cuda.is_available()}')
print(f'CUDA Version: {torch.version.cuda}')
if torch.cuda.is_available():
    print(f'GPU: {torch.cuda.get_device_name(0)}')
"
```

## 🛠️ Runtime Environment

**Automatic Setup** (via startup scripts):
- `./webui.sh` - Loads CUDA environment for web interface
- `./api.sh` - Loads CUDA environment for API server
- `./setup_cuda_env.sh` - Manual CUDA environment loading

**Environment Variables Set**:
- `LD_LIBRARY_PATH` - Includes cuDNN 8.x library path
- `PYTORCH_CUDA_ALLOC_CONF` - Optimized memory allocation  
- `CUDNN_LOGINFO_DBG=0` - Suppresses cuDNN debug output

## 💡 Troubleshooting

**Common Issues**:
- Missing `libcudnn_ops_infer.so.8` → Fixed by dual cuDNN setup
- PyTorch/torchvision version conflicts → Fixed by pinning versions
- CUDA out of memory → Handled by memory allocation config 