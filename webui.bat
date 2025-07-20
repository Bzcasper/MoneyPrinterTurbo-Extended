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

rem set HF_ENDPOINT=https://hf-mirror.com
streamlit run .\webui\Main.py --browser.gatherUsageStats=False --server.enableCORS=True