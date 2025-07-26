@echo off
set CURRENT_DIR=%CD%
echo ***** Current directory: %CURRENT_DIR% *****
set PYTHONPATH=%CURRENT_DIR%

rem Set up CUDA/cuDNN environment for Windows
echo Setting up CUDA environment...

rem Add cuDNN library path (Windows equivalent)
if defined CONDA_PREFIX (
    set "CUDNN_PATH=%CONDA_PREFIX%\Lib\site-packages\nvidia\cudnn\bin"
    if exist "%CUDNN_PATH%" (
        set "PATH=%CUDNN_PATH%;%PATH%"
        echo Added cuDNN library path: %CUDNN_PATH%
    ) else (
        echo Warning: cuDNN library path not found: %CUDNN_PATH%
    )
) else (
    echo Warning: CONDA_PREFIX not set, skipping cuDNN path setup
)

rem Set optimal CUDA environment variables
set PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:32
set CUDNN_LOGINFO_DBG=0
set PYTHONWARNINGS=ignore::UserWarning:streamlit

rem Chatterbox TTS Configuration
rem Lower cfg_weight = slower speech (default: 0.2 for slow speech)
if not defined CHATTERBOX_CFG_WEIGHT set CHATTERBOX_CFG_WEIGHT=0.2
rem Chatterbox chunking threshold (default: 800 chars)
if not defined CHATTERBOX_CHUNK_THRESHOLD set CHATTERBOX_CHUNK_THRESHOLD=800

echo Chatterbox TTS: cfg_weight=%CHATTERBOX_CFG_WEIGHT%, chunk_threshold=%CHATTERBOX_CHUNK_THRESHOLD%

rem set HF_ENDPOINT=https://hf-mirror.com
streamlit run .\webui\Main.py --browser.gatherUsageStats=False --server.enableCORS=True