# MoneyPrinterTurbo - Enhanced Fork

This is an enhanced version of [MoneyPrinterTurbo](https://github.com/harry0703/MoneyPrinterTurbo) with significant improvements to subtitle highlighting and TTS capabilities. Full credit goes to the original author and contributors.

## Example Videos

See the enhanced features in action:

**Full-Length Video Example**  
[![MoneyPrinterTurbo Example Video](https://img.youtube.com/vi/yXc07ROgj80/maxresdefault.jpg)](https://www.youtube.com/watch?v=yXc07ROgj80)

**YouTube Shorts Example**  
[![MoneyPrinterTurbo Shorts Example](https://img.youtube.com/vi/JBAuXpVHt40/maxresdefault.jpg)](https://www.youtube.com/shorts/JBAuXpVHt40)

## What's Different in This Fork

### Enhanced Subtitle System
- **Word-by-word highlighting**: Each word lights up exactly when spoken, making videos more engaging
- **Real-time synchronization**: Perfect timing with TTS word boundaries
- **Multi-line support**: Works with wrapped text and complex subtitle layouts
- **Customizable colors**: Configure highlight colors through the web interface

### Better Video-Text Matching
- **Semantic search**: Analyzes script content to find relevant video clips instead of random selection
- **Text similarity**: Matches video content to script meaning for better relevance
- **Thumbnail analysis**: Optional video thumbnail similarity for sources like Pexels (can be combined with text analysis)

### Open-Source TTS with Voice Cloning
This fork includes **Chatterbox TTS** - a completely free alternative to Azure TTS that runs locally on your machine.

**Key advantages:**
- **No API costs**: Completely free to use, no rate limits
- **Voice cloning**: Clone any voice using 10-60 seconds of reference audio
- **Better word timing**: Uses WhisperX for more accurate word-level timestamps than Azure TTS
- **Local processing**: No internet required after initial setup
- **GPU support**: Faster processing on compatible hardware, falls back to CPU automatically

**How it works:**
1. Add reference audio files to the `reference_audio/` folder
2. Select "Chatterbox TTS" in the web interface
3. Choose your cloned voice or use the default voice
4. Generate videos with your custom voice

## Installation

**Quick Start (Recommended):**
```bash
# 1. Clone and setup
git clone https://github.com/harry0703/MoneyPrinterTurbo.git
cd MoneyPrinterTurbo
conda env create -f environment.yml
conda activate MoneyPrinterTurbo

# 2. Install Chatterbox TTS (voice cloning)
git clone https://github.com/resemble-ai/chatterbox.git
cd chatterbox && pip install -e . && cd ..

# 3. Run the application
./webui.sh
```

**🚀 Usage:**
```bash
# Web Interface (Recommended)
./webui.sh                    # Linux/MacOS with CUDA setup
webui.bat                     # Windows with CUDA setup

# API Server
./api.sh                      # Linux/MacOS API server with CUDA
python main.py                # Direct API (missing CUDA environment)

# Manual Environment Setup (if needed)
source ./setup_cuda_env.sh    # Load CUDA libraries manually
```

The web interface opens at `http://localhost:8501`

**Alternative Installation Methods:**

**Method 1: Complete Conda Environment (Recommended)**
```bash
conda env create -f environment.yml
conda activate MoneyPrinterTurbo
./webui.sh
```

**Method 2: Manual CUDA Installation**
```bash
# Create basic environment
conda create -n MoneyPrinterTurbo python=3.11
conda activate MoneyPrinterTurbo

# Install all CUDA libraries
./install_cuda.sh
```

**Method 3: Pip-only Installation (Advanced)**
```bash
pip install -r requirements.txt
pip install -r requirements-cuda.txt
pip install nvidia-cudnn-cu12==8.9.2.26 --force-reinstall --no-deps
```

## CUDA/GPU Support

This project includes **complete CUDA 12.x support** with extensive GPU acceleration:

**🔧 CUDA Libraries Included (17 packages):**
- **PyTorch Ecosystem**: `torch`, `torchaudio`, `torchvision`, `pytorch-lightning`
- **CUDA Core**: `cuda-nvrtc`, `cuda-version`, `nvidia-cuda-runtime-cu12`
- **cuDNN**: Dual installation - cuDNN 9.x (primary) + cuDNN 8.x (compatibility)
- **NVIDIA Libraries**: `cublas`, `cufft`, `curand`, `cusolver`, `cusparse`, `nccl`, `nvtx`
- **GPU Acceleration**: Automatic GPU detection with CPU fallback

**📦 Installation Options:**
1. **Automatic**: Use `conda env create -f environment.yml` (includes everything)
2. **Manual**: Run `./install_cuda.sh` for step-by-step installation
3. **Custom**: Use `requirements-cuda.txt` for pip-only setup
- Chatterbox TTS with GPU acceleration
- WhisperX with CUDA support for faster transcription
- Automatic environment setup via `setup_cuda_env.sh`
- Cross-platform CUDA library path management

## Features

## Chatterbox TTS Setup

**Note**: Chatterbox TTS requires git-based installation (see Installation section above).

### Basic Usage
1. Go to "Audio Settings" in the web interface
2. Select "Chatterbox TTS (Open Source)" from the dropdown
3. Choose "Default Voice" for the built-in voice

### Voice Cloning
1. Create the reference audio folder: `mkdir reference_audio`
2. Add audio files (.wav, .mp3, .flac, .m4a) to this folder
3. Use 10-60 seconds of clear, single-speaker audio
4. File names become voice names (e.g., `narrator.wav` becomes "narrator" voice)
5. Restart the web interface to see new voices

**Example folder structure:**
```
reference_audio/
├── narrator.wav        # Professional narrator
├── british.mp3         # British accent
└── casual.flac         # Casual style
```

### Performance Options

**Default (CPU mode)** - Compatible with all systems:
```bash
./webui.sh
```

**GPU mode** - 3-5x faster on compatible systems:
```bash
export CHATTERBOX_DEVICE=cuda
./webui.sh
```

**Notes:**
- First run downloads ~1-2GB of models
- CPU mode is slower but works everywhere
- GPU mode requires compatible CUDA setup
- System automatically falls back to CPU if GPU fails

## TTS Comparison

| Feature | Azure TTS | SiliconFlow | Chatterbox TTS |
|---------|-----------|-------------|----------------|
| Cost | Paid API | Paid API | Free |
| Internet | Required | Required | Local only |
| Voice Cloning | No | No | Yes |
| Word Timing | Good | Basic | Superior |
| Rate Limits | Yes | Yes | None |

## Troubleshooting

**Chatterbox TTS issues:**
- **Garbled audio**: See `CHATTERBOX_TTS_GUIDE.md` for detailed solutions
- **CUDA errors**: The system automatically falls back to CPU mode
- **Force CPU mode**: `export CHATTERBOX_DEVICE=cpu`
- **Voice cloning problems**: Ensure audio is clear and single-speaker
- **New voices not appearing**: Restart the web interface
- **Long text issues**: Automatically handled with text preprocessing and chunking

**CUDA/cuDNN compatibility issues:**
- **Error**: `libcudnn_ops_infer.so.8: cannot open shared object file`
- **Cause**: Missing cuDNN 8.x libraries required by some packages
- **Solution**: Automatically handled by startup scripts (`setup_cuda_env.sh`)
- **Manual fix**: `pip install nvidia-cudnn-cu12==8.9.2.26`

**General issues:**
- Check that all dependencies are installed correctly
- Ensure your Python environment is activated
- For GPU issues, CPU mode provides a reliable fallback

**Advanced CUDA Setup:**
The project includes automatic CUDA environment configuration:
- `setup_cuda_env.sh` - Shared CUDA environment setup
- `webui.sh` - Web interface with CUDA support
- `api.sh` - API server with CUDA support  
- `webui.bat` - Windows version with CUDA support

If you encounter CUDA library issues, the startup scripts automatically:
1. Add cuDNN library paths to `LD_LIBRARY_PATH` (Linux) or `PATH` (Windows)
2. Set optimal CUDA memory allocation settings
3. Suppress unnecessary warnings

## Original Project

This enhanced fork maintains full compatibility with the original MoneyPrinterTurbo while adding these new features. Check out the [original repository](https://github.com/harry0703/MoneyPrinterTurbo) for the base project documentation and additional features.
