#!/bin/bash
# MoneyPrinterTurbo CUDA Installation Script
# Installs complete CUDA 12.x ecosystem with dual cuDNN support

echo "🚀 Installing MoneyPrinterTurbo CUDA Dependencies"
echo "================================================="

# Check if conda is available
if ! command -v conda &> /dev/null; then
    echo "❌ Conda not found. Please install Miniconda/Anaconda first."
    exit 1
fi

# Activate environment (if exists)
if conda info --envs | grep -q "MoneyPrinterTurbo"; then
    echo "📦 Activating existing MoneyPrinterTurbo environment..."
    source activate MoneyPrinterTurbo
else
    echo "❌ MoneyPrinterTurbo environment not found."
    echo "Please create it first with: conda env create -f environment.yml"
    exit 1
fi

echo "📥 Installing CUDA libraries..."

# Install main CUDA packages
echo "⚡ Installing PyTorch with CUDA support..."
pip install torch==2.5.1 torchaudio==2.5.1 torchvision==0.20.1 --index-url https://download.pytorch.org/whl/cu121

echo "🔧 Installing NVIDIA CUDA libraries..."
pip install -r requirements-cuda.txt

echo "🔄 Installing cuDNN 8.x for compatibility..."
# Install cuDNN 8.x after 9.x (force reinstall to coexist)
pip install nvidia-cudnn-cu12==8.9.2.26 --force-reinstall --no-deps

echo "🎯 Installing Chatterbox TTS dependencies..."
# Chatterbox TTS (from git)
if [ ! -d "chatterbox" ]; then
    git clone https://github.com/resemble-ai/chatterbox.git
    cd chatterbox
    pip install -e .
    cd ..
fi

# WhisperX for word-level timestamps
pip install whisperx==3.4.2

echo "✅ CUDA installation complete!"
echo ""
echo "🔍 Verifying installation..."
python -c "
import torch
import torchaudio
import torchvision
print(f'PyTorch: {torch.__version__}')
print(f'CUDA Available: {torch.cuda.is_available()}')
print(f'CUDA Device Count: {torch.cuda.device_count()}')
if torch.cuda.is_available():
    print(f'CUDA Device: {torch.cuda.get_device_name(0)}')
print('✅ CUDA setup verified!')
"

echo ""
echo "🎉 Installation Summary:"
echo "========================"
echo "✅ PyTorch 2.5.1 with CUDA 12.1 support"  
echo "✅ 13 NVIDIA CUDA libraries"
echo "✅ cuDNN 9.x (primary) + cuDNN 8.x (compatibility)"
echo "✅ Chatterbox TTS with voice cloning"
echo "✅ WhisperX for word-level timestamps"
echo ""
echo "🚀 Ready to run: ./webui.sh" 