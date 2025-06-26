# Do Vision and Language Models Share Concepts? A Vector Space Alignment Study
[VLCA](https://github.com/jiaangli/VLCA)
```
git clone git@github.com:jiaangli/VLCA.git
cd VLCA
git submodule update --init MUSE

```

```
cd ~
wget https://www.python.org/ftp/python/3.11.8/Python-3.11.8.tgz
tar -xzf Python-3.11.8.tgz
cd Python-3.11.8
./configure --prefix=$HOME/python-3.11
# ./configure --prefix=$HOME/python-3.11 --enable-optimizations
make -j$(nproc)
make install


# 使用刚刚安装的 python3.11 创建虚拟环境
~/python-3.11/bin/python3.11 -m venv ~/vlca-env

# 激活虚拟环境
source ~/vlca-env/bin/activate

pip install --upgrade pip
pip install -r requirements.txt

# export PATH="$HOME/python-3.11/bin:$PATH"
# alias activate_vlca='source ~/vlca-env/bin/activate'

```
安装requirements.txt中的依赖时有较多版本无法找到

# Conda 安装虚拟环境
```
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh


bash Miniforge3-Linux-x86_64.sh
# 按照提示安装到 ~/miniforge3

source ~/miniforge3/bin/activate

conda create -n vlca python=3.11
conda activate vlca
pip install -r requirements.txt

```

有些packages pip 安装找不到适合的版本或者安装报错，改为使用conda安装
```
conda install -c conda-forge fasttext
conda install -c conda-forge faiss
```

```
#                                                     
# To activate this environment, use
#
#     $ conda activate vlca
#
# To deactivate an active environment, use
#
#     $ conda deactivate
```


# 测试
python main.py +model=gpt2 +dataset=cldi muse.exp_type=BASE


# Vision Models
在论文《Do Vision and Language Models Share Concepts? A Vector Space Alignment Study》中，作者系统比较了三种主要的视觉模型架构：**ResNet**、**SegFormer** 和 **MAE**，用于提取图像的表示向量，并分析这些表示与语言模型空间的对齐程度。以下是对每种视觉模型架构的逐一介绍：

---

### 1. **ResNet（Residual Network）**

* **架构来源**：He et al. (2016)
* **模型结构**：

  * 基于卷积神经网络（CNN）；
  * 引入残差连接（residual blocks）以缓解深层神经网络的梯度消失问题。
* **用途**：主要用于图像分类任务；
* **训练数据**：预训练于 ImageNet-1K 数据集；
* **表示提取方式**：使用\*\*平均池化层（average pooling layer）\*\*输出的向量作为整张图像的表示。
* **优势**：

  * 模型训练目标直接促进对对象类别的识别；
  * 在实验中表现最优，对语言模型的对齐精度最高；
  * 分类目标带来一定“类结构”偏向，有利于构造结构化表征。

---

### 2. **SegFormer**

* **架构来源**：Xie et al. (2021)
* **模型结构**：

  * 基于 Transformer 编码器；
  * 后接轻量级的前馈解码器；
* **用途**：

  * 预训练阶段执行对象分类；
  * 微调用于场景解析（scene parsing）与语义分割（semantic segmentation）；
* **训练数据**：

  * 预训练于 ImageNet-1K；
  * 微调于 ADE20K 场景分割数据集；
* **表示提取方式**：

  * 从**最后一层隐藏状态中提取 patch 表示**，然后对所有 patch 表示取平均作为图像的整体向量；
* **假设优势**：

  * 分割任务涉及图像区域间关系建模，与语言模型离散词汇的建模方式类似；
  * 具备一定语义上下文推理能力，因而有望更好对齐语言空间。

---

### 3. **MAE（Masked AutoEncoder）**

* **架构来源**：He et al. (2022)
* **模型结构**：

  * 基于 Vision Transformer（ViT）；
  * 采用编码器-解码器结构；
  * 编码器仅接收部分可见图像 patch，解码器重建整张图像。
* **训练方式**：

  * **完全无监督**，任务为遮挡图像的自编码重建（类似于语言模型中的MLM）；
* **训练数据**：预训练于 ImageNet-1K；
* **表示提取方式**：

  * 使用\*\*倒数第二层（penultimate layer）\*\*的隐藏状态作为特征；
  * 多个 patch 表示取平均后得出整张图像的向量；
* **实验观察**：

  * 尽管没有监督信号，MAE 也能学到可对齐语言空间的结构；
  * 提供了强有力的证据，表明视觉表示源于真实世界结构，而非训练标签。

---

### 总结比较

| 模型        | 架构类型        | 任务类型    | 表示提取方式           | 对齐性能（P\@100） | 特点与优劣          |
| --------- | ----------- | ------- | ---------------- | ------------ | -------------- |
| ResNet    | CNN + 残差连接  | 图像分类    | 平均池化层输出向量        | 最佳           | 强监督任务，有语义偏向    |
| SegFormer | Transformer | 场景解析与分割 | 最后一层 patch 表示平均  | 次优           | 融合上下文信息，类比词汇建模 |
| MAE       | ViT + 自编码器  | 图像自监督重建 | 倒数第二层 patch 表示平均 | 稍弱           | 无监督，结构学习能力强    |

# Language Models
在论文《Do Vision and Language Models Share Concepts? A Vector Space Alignment Study》中，作者评估了四大类主流\*\*预训练语言模型（LMs）\*\*的向量空间结构，并分析它们与视觉模型表示之间的几何相似性。以下是对每个语言模型的结构、训练方式和实验中使用细节的逐一介绍：

---

### 1. **BERT（Bidirectional Encoder Representations from Transformers）**

* **来源**：Devlin et al. (2019)
* **模型类型**：双向 Transformer 编码器（Encoder-only）
* **训练目标**：

  * **Masked Language Modeling (MLM)**：遮盖部分 token，预测被遮盖的词；
  * **Next Sentence Prediction (NSP)**（原始版本中使用）；
* **使用模型**：

  * BERTBase 和 BERTLarge；
  * 还包括 4 个由 BERTLarge 蒸馏而来的小尺寸模型（如 DistilBERT）；
* **训练语料**：

  * BookCorpus 和英文 Wikipedia；
* **在论文中的表示方式**：

  * 通过提取概念词在句子中的所有 token 表示并取平均（避免孤立词输入的不稳定性）；
* **特点**：

  * 对上下文建模能力强；
  * 模型表示的多义性（polysemy）敏感；
  * 在实验中表现稳定，但规模越大性能越优。

---

### 2. **GPT-2（Generative Pre-trained Transformer 2）**

* **来源**：Radford et al. (2019)
* **模型类型**：自回归解码器（Decoder-only Transformer）
* **训练目标**：

  * 语言建模（Language Modeling）：预测下一个词；
* **使用模型**：

  * 三种规模（如 GPT-2 Small, Medium, XL）；
* **训练语料**：

  * WebText 数据集；
* **在论文中的表示方式**：

  * 将概念词嵌入进完整句子，取出该词的**最后一个 token 表示**；
* **特点**：

  * 生成能力强；
  * 表达更倾向单向上下文；
  * 模型规模越大，与视觉空间的对齐性能也越好。

---

### 3. **OPT（Open Pretrained Transformer）**

* **来源**：Zhang et al. (2022)
* **模型类型**：GPT 风格自回归模型（Decoder-only Transformer）
* **训练目标**：

  * 自回归语言建模；
* **使用模型**：

  * 三种尺寸模型（如 OPT-1.3B、OPT-6.7B、OPT-30B）；
  * 实验中 OPT-30B 是表现最优的 LM；
* **训练语料**：

  * Five-dataset union，包括 Books, CCNews, Wikipedia 等；
* **在论文中的表示方式**：

  * 同 GPT-2：取出输入句子中目标词最后 token 的表示；
* **特点**：

  * **实验中对齐精度最佳**（如与 ResNet152 映射时 P\@100 达 64.1%）；
  * 展现出最清晰的规模-性能提升趋势；
  * 是论文中主力分析的对象。

---

### 4. **LLaMA-2（Large Language Model Meta AI 2）**

* **来源**：Touvron et al. (2023)
* **模型类型**：自回归 Transformer 解码器（Decoder-only）
* **训练目标**：

  * 标准语言建模；
* **使用模型**：

  * LLaMA-2-13B 是论文中测试的版本；
* **训练语料**：

  * 总共使用超过 **2 万亿个 token** 训练；
* **表示方式**：

  * 同 GPT 风格模型：取最后 token 的向量表示；
* **特点**：

  * 性能稳定，整体对齐精度略低于 OPT；
  * 在处理复杂词形变化和低频词上表现优秀；
  * 在 P\@100 上通常略逊于 OPT，但优于 GPT-2 和 BERT。

---

### 总结比较表

| 模型      | 类型           | 架构            | 表示方式          | 最佳对齐模型组合             | 对齐性能趋势       |
| ------- | ------------ | ------------- | ------------- | -------------------- | ------------ |
| BERT    | Encoder-only | 双向Transformer | 概念词多token平均表示 | 与 ResNet、MAE 等       | 随模型大小稳定上升    |
| GPT-2   | Decoder-only | 单向Transformer | 取概念词最后token表示 | 与 MAE、ResNet 等       | 随模型增大略有提升    |
| OPT     | Decoder-only | GPT 风格        | 同 GPT-2       | 与 ResNet152 最佳       | P\@100 达 64% |
| LLaMA-2 | Decoder-only | 高效GPT风格       | 同 GPT-2       | 与 ResNet、SegFormer 等 | 性能次于 OPT，但稳定 |

