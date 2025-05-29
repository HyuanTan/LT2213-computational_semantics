#!/bin/bash

# 使用本地编译的 Python 创建虚拟环境
PY_BASE="$HOME/.local_python3.9/python3.9/bin/python3.9"
ENV_DIR="$HOME/python3.9_bert_transformers"

echo "[1] Creating virtual environment at $ENV_DIR using $PY_BASE ..."
$PY_BASE -m venv $ENV_DIR

echo "[2] Activating virtual environment..."
source $ENV_DIR/bin/activate

echo "[3] Upgrading pip..."
pip install --upgrade pip

echo "[4] Installing compatible numpy..."
pip install numpy==1.26.4

echo "[5] Installing PyTorch 2.0.1 + torchvision + torchaudio (CUDA 11.7)..."
pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 \
  --index-url https://download.pytorch.org/whl/cu117

echo "[6] Installing transformers==4.30.2..."
pip install transformers==4.30.2

echo "[7] Installing other useful packages (optional)..."
# pip install pandas tqdm ipykernel
pip install pandas tqdm ipykernel scikit-learn==1.3.2

echo "[8] Registering Jupyter kernel..."
$ENV_DIR/bin/python -m ipykernel install --user --name=python3.9_bert_transformers --display-name "Python 3.9 (Transformers)"

echo "✅ Setup complete! You can now select 'Python 3.9 (Transformers)' kernel in VSCode."
