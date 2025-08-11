#!/bin/bash
# MoneyPrinterTurbo CUDA Environment Setup
# This script sets up the necessary CUDA/cuDNN library paths for compatibility

# Add cuDNN library path so system can find libcudnn_ops_infer.so.8
# This fixes the "libcudnn_ops_infer.so.8: cannot open shared object file" error
if [[ -n "$CONDA_PREFIX" ]]; then
    CUDNN_PATH="$CONDA_PREFIX/lib/python3.11/site-packages/nvidia/cudnn/lib"
    if [[ -d "$CUDNN_PATH" ]]; then
        export LD_LIBRARY_PATH="$CUDNN_PATH:$LD_LIBRARY_PATH"
        echo "✅ Added cuDNN library path (conda): $CUDNN_PATH"
    else
        echo "⚠️  cuDNN library path not found under CONDA_PREFIX: $CUDNN_PATH"
    fi
else
    # Try Python-based discovery (works for venv/pip installs of nvidia-cudnn-cu12)
    PY_DISCOVERED_CUDNN_PATH="$(python - <<'PY'
import os
try:
    import nvidia.cudnn as m
    p = os.path.join(os.path.dirname(m.__file__), 'lib')
    if os.path.isdir(p):
        print(p)
except Exception:
    pass
PY
)"
    if [[ -n "$PY_DISCOVERED_CUDNN_PATH" && -d "$PY_DISCOVERED_CUDNN_PATH" ]]; then
        export LD_LIBRARY_PATH="$PY_DISCOVERED_CUDNN_PATH:$LD_LIBRARY_PATH"
        echo "✅ Added cuDNN library path (auto-detected): $PY_DISCOVERED_CUDNN_PATH"
    else
        # Try VIRTUAL_ENV conventional location as a fallback
        if [[ -n "$VIRTUAL_ENV" ]]; then
            CUDNN_PATH_VENV="$VIRTUAL_ENV/lib/python*/site-packages/nvidia/cudnn/lib"
            # Expand possible glob
            CUDNN_PATH_EXPANDED=( $CUDNN_PATH_VENV )
            if [[ -d "${CUDNN_PATH_EXPANDED[0]}" ]]; then
                export LD_LIBRARY_PATH="${CUDNN_PATH_EXPANDED[0]}:$LD_LIBRARY_PATH"
                echo "✅ Added cuDNN library path (venv): ${CUDNN_PATH_EXPANDED[0]}"
            else
                echo "⚠️  cuDNN library path not found under VIRTUAL_ENV"
            fi
        else
            echo "⚠️  Could not auto-detect cuDNN path (no CONDA_PREFIX, no VIRTUAL_ENV, and Python check failed)"
        fi
    fi
fi

# Set optimal CUDA environment variables
export PYTORCH_CUDA_ALLOC_CONF="max_split_size_mb:32"
export CUDNN_LOGINFO_DBG="0"  # Suppress cuDNN debug info

# Suppress warnings
export PYTHONWARNINGS="ignore::UserWarning:streamlit"

# Chatterbox TTS Configuration
# Lower cfg_weight = slower speech (default: 0.2 for slow speech)
# You can set CHATTERBOX_CFG_WEIGHT=0.1 for very slow speech or 0.3 for normal speed
export CHATTERBOX_CFG_WEIGHT="${CHATTERBOX_CFG_WEIGHT:-0.2}"

# Chatterbox chunking threshold (default: 800 chars)
# Higher values = less chunking = more consistent pacing
export CHATTERBOX_CHUNK_THRESHOLD="${CHATTERBOX_CHUNK_THRESHOLD:-800}"

echo "🚀 CUDA environment configured for MoneyPrinterTurbo"
echo "🎤 Chatterbox TTS: cfg_weight=$CHATTERBOX_CFG_WEIGHT, chunk_threshold=$CHATTERBOX_CHUNK_THRESHOLD" 