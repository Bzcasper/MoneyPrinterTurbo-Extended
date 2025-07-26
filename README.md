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
1. [Optional] Add reference audio files to the `reference_audio/` folder
2. Select "Chatterbox TTS" in the web interface
3. Choose your cloned voice or use the default voice
4. Generate videos with your custom voice

## Installation

**Quick Start (Recommended):**

**Installation:**

```bash
# 1. Clone and setup
git clone https://github.com/harry0703/MoneyPrinterTurbo.git
cd MoneyPrinterTurbo
conda env create -f environment.yml
conda activate MoneyPrinterTurbo

# 2. Install Chatterbox TTS (voice cloning)
git clone https://github.com/resemble-ai/chatterbox.git
cd chatterbox && pip install -e . && cd ..

## For Cuda specific (if needed)
source ./setup_cuda_env.sh    
```

**Usage:**
```bash
# Web Interface (Recommended)
./webui.sh            
```

The web interface opens at `http://localhost:8501`


## Troubleshooting:[Optional]

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

This fork maintains full compatibility with the original MoneyPrinterTurbo while adding new features. Check out the [original repository](https://github.com/harry0703/MoneyPrinterTurbo) for the base project documentation and additional features.
