
# Install -- work
```
# Step 1: 依赖准备（仅提示，无法用 apt/yum 安装时要用已有的）
# sudo apt install build-essential libssl-dev zlib1g-dev libncurses5-dev \
#     libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev libdb5.3-dev \
#     libbz2-dev libexpat1-dev liblzma-dev tk-dev uuid-dev

# Step 2: 下载并解压源码
cd ~
wget https://www.python.org/ftp/python/3.9.18/Python-3.9.18.tgz
tar -xzf Python-3.9.18.tgz
cd Python-3.9.18

mkdir ~/.local_python3.9
# Step 3: 编译安装到本地 ~/.local_python3.9/python3.9
./configure --prefix=$HOME/.local_python3.9/python3.9 --enable-optimizations
make -j$(nproc)          # 或 macOS 用 make -j$(sysctl -n hw.ncpu)
make install

# Step 4: 添加到 PATH（临时生效）-- 不需要添加
export PATH=$HOME/.local_python3.9/python3.9/bin:$PATH
# 永久生效：加入 ~/.bashrc 或 ~/.zshrc： -- 不需要添加
# echo 'export PATH=$HOME/.local_python3.9/python3.9/bin:$PATH' >> ~/.bashrc

# Step 5: 验证
python3.9 --version

```

```
# python interppreter: /home/gushuota@GU.GU.SE/python3.9_torchtext/bin/python3.9
$HOME/.local_python3.9/python3.9/bin/python3.9 -m venv ~/python3.9_torchtext
# 清楚kernal 缓存：Python: Clear Workspace Interpreter Setting

source ~/python3.9_torchtext/bin/activate

echo "alias activate_torchtext='source ~/python3.9_torchtext/bin/activate'" >> ~/.bashrc
source ~/.bashrc

pip install torch==1.13.1+cu117 torchvision==0.14.1+cu117 torchtext==0.14.1 -f https://download.pytorch.org/whl/torch_stable.html
```

#### .numpy() 调用失败却显示 Numpy is not available
```
# 请先卸载并重装官方匹配版本的 NumPy 和 PyTorch
pip uninstall torch numpy -y
pip install numpy # 2.0.2
pip install torch==1.13.1+cu117 -f https://download.pytorch.org/whl/torch_stable.html

```

## Other packages -- torch 版本太旧，需要>2.0
```
git clone https://github.com/huggingface/transformers.git
cd transformers
pip install .
```

## Other packages --old, not work
```
pip uninstall transformers # 版本不兼容，改为源码安装
pip install transformers==4.27.4

# not work with skeanlearn
pip uninstall numpy
pip install numpy==1.24.4
```

# env FOR BERT
```
# python interppreter: /home/gushuota@GU.GU.SE/python3.9_transformers/bin/python3.9
$HOME/.local_python3.9/python3.9/bin/python3.9 -m venv ~/python3.9_transformers
# 清楚kernal 缓存：Python: Clear Workspace Interpreter Setting

source ~/python3.9_transformers/bin/activate

pip uninstall -y numpy
pip install numpy==1.26.4

pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cu117
pip install transformers==4.30.2

```

# Install --old, not work
```
mkdir -p $HOME/localpython
cd $HOME
wget https://www.python.org/ftp/python/3.11.9/Python-3.11.9.tgz
tar -xzf Python-3.11.9.tgz
cd Python-3.11.9

```


choose  python interppreter: /home/gushuota@GU.GU.SE/python3.9_torchtext/bin/python3.9


```
PyTorch version: 1.13.1+cu117
0.14.1
CUDA available: True
CUDA version: 11.7
GPU name: NVIDIA GeForce GTX 1080 Ti
```


# Old
For visualstudio code
Python: Select Interpreter to start Jupyter notebook

/home/gushuota@GU.GU.SE/.venv/bin/python3.12


To install `torchtext`, you can use `pip` — but it's important to match the **version of `torchtext`** with your installed **PyTorch version**.

---

## ✅ Basic Installation

If you're using the latest version of PyTorch:

```bash
pip install torchtext
```

This installs the latest compatible `torchtext` version from PyPI.

---

## 🔍 Recommended: Install with matching PyTorch version

You can install both PyTorch and torchtext together (recommended):

### Step 1: Go to the official PyTorch install helper:

👉 [https://pytorch.org/get-started/locally](https://pytorch.org/get-started/locally)

Choose:

* OS (Windows/Linux/macOS)
* Package: `pip`
* Compute Platform: `CPU` or `CUDA` (for GPU support)

Then it gives you a command like:

```bash
# Example (for CPU)
pip install torch torchvision torchaudio torchtext --index-url https://download.pytorch.org/whl/cpu
```

Or (for CUDA 11.8):

```bash
pip install torch torchvision torchaudio torchtext --index-url https://download.pytorch.org/whl/cu118
```

---

## 📌 Check if Installed

After installation, test it with:

```python
import torchtext
print(torchtext.__version__)
```

---

## ❗ Version Compatibility

Some versions of `torchtext` only work with specific versions of PyTorch.

| PyTorch | torchtext |
| ------- | --------- |
| 2.2     | 0.17      |
| 2.1     | 0.16      |
| 2.0     | 0.15      |
| 1.13    | 0.14      |

If you run into version mismatch errors, install a specific version:

```bash
pip install torchtext==0.16.0
```

---

Need help matching it to your PyTorch version? Just tell me what `torch.__version__` is.


```
import torch

# 查看 PyTorch 版本
print("PyTorch version:", torch.__version__)

# 查看是否支持 CUDA（即是否使用 GPU）
print("CUDA available:", torch.cuda.is_available())

# 查看 CUDA 的版本（如果支持）
if torch.cuda.is_available():
    print("CUDA version:", torch.version.cuda)
    print("GPU name:", torch.cuda.get_device_name(0))

```

```
PyTorch version: 2.5.1+cu121
CUDA available: True
CUDA version: 12.1
GPU name: NVIDIA GeForce GTX 1080 Ti

Python 3.12.3
```

```
pip install --upgrade pip

pip uninstall torch torchvision torchaudio torchtext -y

pip install torch==2.5.1+cu121 torchvision==0.20.1+cu121 torchaudio==2.5.1+cu121 --index-url https://download.pytorch.org/whl/cu121

# using --no-deps, not reinstall torch >= 1.8.0 torchtext==0.17.2 的 requirements.txt, not work
# pip install torchtext==0.17.2 --no-deps

```
```
# 卸载已有版本
pip uninstall torchtext

# 克隆源码
git clone --branch v0.17.2 https://github.com/pytorch/text.git
cd text

# 建议激活你的虚拟环境
# 编译并安装（确保 torch==2.5.1 已预装）
pip install .

# 如果找不到虚拟环境的 torch -- 源码安装不work
pip install cmake

/home/gushuota@GU.GU.SE/.venv/bin/python3.12 setup.py install

```

```
import torchtext
print(torchtext.__version__)

```
