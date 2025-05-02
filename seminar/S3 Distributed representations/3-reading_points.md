好的，我们来详细分析这篇具有里程碑意义的论文：

**《Distributed Representations of Words and Phrases and their Compositionality》**  
作者：Tomas Mikolov 等（Google）  
——也就是著名的**word2vec Skip-gram 模型的改进版本**的提出文章。

---

## 一、方法（核心技术贡献）

### 1. **Skip-gram 模型**
核心思想：  
给定一个词，预测它的上下文（即周围的词）。  
训练目标：最大化目标词与上下文词的联合概率。

数学目标函数：
\[
\frac{1}{T} \sum_{t=1}^{T} \sum_{-c \leq j \leq c, j \neq 0} \log p(w_{t+j}|w_t)
\]

#### 技术优点：
- 比早期的神经网络语言模型快（没有复杂的全连接矩阵乘）。
- 可以训练超大语料（一天内能处理1000亿单词）。

#### 有趣的性质：
向量算术可以反映语言规律：  
\[
\text{vec}("Madrid") - \text{vec}("Spain") + \text{vec}("France") \approx \text{vec}("Paris")
\]

---

### 2. **训练加速与改进**
论文提出三种重要改进：

#### （1）**层次Softmax（Hierarchical Softmax）**  
- 使用霍夫曼树（Huffman tree）来加速softmax运算。
- 计算复杂度从 \(O(W)\) 降到 \(O(\log W)\)。

#### （2）**负采样（Negative Sampling）**  
- 每次更新不对所有词做softmax，而只挑若干“负样本”与正样本做对比。
- 极大地降低计算量，尤其适合大词表。
- 比标准的**Noise Contrastive Estimation (NCE)** 更简洁高效。

#### （3）**高频词的子采样（Subsampling）**  
- 高频词（如 “the”, “of”）信息量低，训练时以一定概率忽略它们。
- 提升稀有词表示质量，同时加速训练。

子采样公式：
\[
P(w_i) = 1 - \sqrt{\frac{t}{f(w_i)}}
\]
\(t\) 通常设置为 \(10^{-5}\)。

---

### 3. **短语学习（Phrase Learning）**
针对**组合性（compositionality）问题**，即：
> 某些短语（如 "Air Canada"）的意义 ≠ 单词“Air”和“Canada”含义的简单组合。

方法：
- 通过统计找到常一起出现的单词对（bigram），如“New York”。
- 用特定的评分公式（score）筛选出优质短语，把它们当做单一token处理。
- 训练短语的Skip-gram向量。

#### 短语向量优势：
能够表示复杂实体，如：
\[
\text{vec}("Germany") + \text{vec}("capital") \approx \text{vec}("Berlin")
\]

---

## 二、实证结果

### 1. **词类比（Analogy）任务**
通过向量算术解决类比问题（如："Germany":"Berlin" :: "France":"?" → "Paris"）。

结果：
- 负采样性能优于层次softmax和NCE。
- 子采样显著提升速度和准确率。

### 2. **短语类比任务**
为短语设计了类似的类比测试，覆盖新闻媒体、体育队、公司高管等类别。

最佳模型（训练33亿单词、1000维向量）：
- 类比准确率达到 **72%**。

---

## 三、结论

**主要贡献总结：**

1. **提出改进版 Skip-gram 模型**  
   —— 快速训练高质量词和短语的向量表示。

2. **负采样（Negative Sampling）算法**  
   —— 简单高效，特别适合处理大语料库。

3. **高频词子采样**  
   —— 加速训练，提升稀有词的表示效果。

4. **短语表示学习**  
   —— 实现更复杂的语言组合性。

5. **发现词向量的可加性（Additive Compositionality）**  
   —— 简单的向量相加能得到合理的组合意义。

6. **比以往模型在规模和表现上有数量级的改进**。

---

## 四、对NLP的意义

这篇论文是 **现代词嵌入（word embedding）技术** 的里程碑：
- 奠定了**word2vec**工具的理论基础。
- 启发了**后续的句子、段落、文档表示学习**（如Doc2Vec、FastText）。
- 向后来的**BERT、GPT**等模型过渡打下了“分布式表示”的核心概念。

---

# Details about Hierarchical Softmax,Negative Sampling,Subsampling; How Phrase Learning get and work?

---

## 1️⃣ **Hierarchical Softmax (层次Softmax)**

**目标：**  
加速 Skip-gram 的 softmax 输出层。

**为什么需要它？**  
标准 softmax 的复杂度是 **O(V)**（词汇表大小 V），非常慢，因为要对所有单词的概率归一化。

**Hierarchical Softmax 做了什么？**  
- 把词汇表组织成一棵 **二叉树**（通常是 Huffman 树）。
- 每个词是叶子节点，路径上的每个节点有一个二分类任务：走左还是右。
- 预测一个词，不是计算所有词的概率，而是沿着树的路径，依次做决策。

**优势：**
- 每次预测的计算复杂度 **O(log₂ V)**。
- 高频词在 Huffman 树中路径更短 → 训练速度更快。

**数学公式：**
\[
p(w|w_I) = \prod_{j=1}^{L(w)-1} \sigma\left( \text{sign} \cdot v'_{n(w, j)}^\top v_{w_I} \right)
\]
- **L(w)**：目标词的路径长度。
- **v** 和 **v'**：输入词和树节点的向量。
- **sign**：表示路径选择（左或右）。

---

## 2️⃣ **Negative Sampling (负采样)**

**目标：**  
进一步减少计算量，尤其是在大词汇表时。

**原理：**  
不用做完整 softmax，而是：
- 对一个正样本（真实上下文词对），最大化它的相似度。
- 随机采样 K 个负样本（噪声词），最小化它们的相似度。

**训练目标（目标函数）：**
\[
\log \sigma( v'_{w_O}^\top v_{w_I} ) + \sum_{i=1}^k \mathbb{E}_{w_i \sim P_n(w)} \left[ \log \sigma( -v'_{w_i}^\top v_{w_I} ) \right]
\]

**其中：**
- 正样本：\( v'_{w_O}^\top v_{w_I} \)
- 负样本：采样自 Pn(w)，常用 **unigram^(3/4)** 的分布。

**优点：**
- 不需要计算整个词汇表的 softmax。
- 对大数据集尤其有效。
- 超参数 k（负样本个数）通常选择 5~20。

---

## 3️⃣ **Subsampling of Frequent Words (高频词下采样)**

**问题：**  
高频词（比如 "the", "of", "a"）出现太多，占据训练资源，但携带的信息少。

**做法：**  
对高频词以概率 P(w) 随机丢弃，P(w) 随词频减少。

**丢弃概率：**
\[
P(w) = 1 - \sqrt{ \frac{t}{f(w)} }
\]
- **f(w)**：词频。
- **t**：通常设定为 \(10^{-5}\)。

**好处：**
- 加快训练（快2~10倍）。
- 减少噪音，提高稀有词的表示效果。

---

## 4️⃣ **Phrase Learning（短语学习）**

**目标：**  
解决 **组合性限制**（Compositionality Problem）。  
→ 某些短语的含义 **≠ 单词含义简单相加**（比如“New York Times” ≠ "New"+"York"+"Times"）。

### 🔎 **步骤：**

**Step 1：识别短语**
- 找频繁同时出现、且独立时不太常见的单词对（bigrams）。
- 评分公式：
\[
\text{score}(w_i, w_j) = \frac{count(w_i w_j) - \delta}{count(w_i) \cdot count(w_j)}
\]
- **δ**：防止低频组合误判。
- 阈值：得分高的 bigram 被认为是短语。

**Step 2：替换为单一 token**
- 例： "New York" → "New_York"
- 训练时视作单独词。

**Step 3：训练短语向量**
- 用 Skip-gram 的方式，把短语 token 当普通单词一样训练。

### 🔥 **Phrase Vectors 的强大之处：**
- 能更好捕捉固定搭配的语义。
- 可以进行 **短语类比推理**，例如：
\[
\text{vec}("Montreal Canadiens") - \text{vec}("Montreal") + \text{vec}("Toronto") \approx \text{vec}("Toronto Maple Leafs")
\]

**实验结果：**
- 训练集从 10 亿词扩展到 33 亿词时，短语类比准确率提升到 72%。

---

## ✅ 小结

| 方法 | 作用 | 优势 |
|----|----|----|
| Hierarchical Softmax | 加速 softmax 计算 | 复杂度降到 O(log V) |
| Negative Sampling | 减少训练负担 | 简单高效，支持大数据 |
| Subsampling | 减少高频词噪声 | 加速并提升稀有词表示 |
| Phrase Learning | 识别并训练短语 | 捕捉复杂语义，提高类比性能 |

---

# Negative Sampling , Subsampling of Frequent Words 具体是在那一步进行


我来给你详细梳理一下 **Negative Sampling** 和 **Subsampling of Frequent Words** 分别在哪个阶段发生。

---

## 🧩 Skip-gram 的训练流程简述

整体流程如下：

1. **遍历语料**（文本）。
2. 对于每个中心词 \( w_t \)，取窗口大小 \( c \)，找到上下文词 \( w_{t+j} \)。
3. 为每对中心词-上下文词 \( (w_t, w_{t+j}) \) 构建训练样本。
4. **（此处）对高频词应用 Subsampling → 可能丢弃该训练样本。**
5. **（此处）对正样本 (w_t, w_{t+j}) 进行 Negative Sampling → 增加 K 个负样本。**
6. 通过反向传播训练 word vectors（输入向量 vw 和输出向量 v'w）。

---

## 🔍 **Subsampling of Frequent Words**：**样本选择阶段**（Step 4）

**在哪一步？**
- **在训练样本构建阶段**。
- 当确定了一个中心词 \(w_t\) 和上下文词 \(w_{t+j}\) 后，**判断这两个词是否应该被“丢弃”。**
- 高频词（如 the, a, of）有一定概率直接从训练中剔除。

**目的是**：
- 防止高频词过度主导训练。
- 加速整体训练，提升低频词的学习效果。

**在代码或实现中**：
```python
if random() < P(w):   # P(w) 是 subsampling 概率
    continue  # 跳过这个词，不训练
```

---

## 🔍 **Negative Sampling**：**训练目标构建阶段**（Step 5）

**在哪一步？**
- **当确定了一个正样本 (中心词, 上下文词)** 之后。
- 为这个正样本从噪声分布 \( P_n(w) \) 中采样 K 个负样本（负词）。
- 训练目标是：**最大化正样本的相似度，最小化负样本的相似度**。

**在代码或实现中**（伪代码）：
```python
for positive_pair in training_pairs:
    update(positive_pair)  # 正样本更新
    for _ in range(K):
        negative_sample = draw_from_noise_distribution()
        update_negative(negative_sample)  # 负样本更新
```

**注意**：
- **Negative Sampling 是替代 softmax 的**。
- 如果用 Negative Sampling，softmax 和 Hierarchical Softmax 都不再计算。

---

## 📊 总结：两者位置对比

| 阶段 | 操作 | Subsampling | Negative Sampling |
|----|----|----|----|
| 训练样本构建 | 选择保留哪些词对 | ✅ | ❌ |
| 正样本生成 | 选定中心词-上下文词 | ✅（已 subsample） | ❌ |
| 负样本生成 | 采样噪声词 | ❌ | ✅ |
| 反向传播 | 更新向量 | ✅（只更新保留下的样本） | ✅ |

---

## 🔎 可视化（简图）

```plaintext
语料 → 词对 (中心词, 上下文词)
         ↓
    Subsampling → 保留 or 丢弃
         ↓
    生成正样本
         ↓
    Negative Sampling → 加负样本
         ↓
    训练（更新向量）
```

---

# Subsampling  中 高频词 是作为中心词还是上下文出现
好问题！

**答案：两者都会被考虑**。  
→ **Subsampling 对中心词和上下文词都适用**。

---

### 🔍 为什么？

Skip-gram 的训练样本是 **(中心词, 上下文词)** 对。  
比如一个句子：  
`[the] [quick] [brown] [fox] [jumps]`  
假设窗口 c=2，可能生成的训练对：

| 中心词 | 上下文词 |
|---|---|
| quick | the |
| quick | brown |
| brown | quick |
| brown | fox |
| fox | brown |
| fox | jumps |

**注意**："the" 是高频词，"quick" 和 "brown" 是中低频词。

**在构建样本时**：
- 每个词都会有可能成为**中心词**。
- 每个词也可能作为**上下文词**。

---

### 🔧 Subsampling 的实际操作：

对于构建出来的每个训练对 \( (w_t, w_{t+j}) \)：
- **首先**检查 \( w_t \)（中心词）是否被丢弃。
- **然后**检查 \( w_{t+j} \)（上下文词）是否被丢弃。
- **只要任意一个被丢弃，这个训练样本就完全不保留**。

**换句话说：**
\[
\text{如果中心词或上下文词满足 subsampling 的丢弃概率 → 丢弃整个样本。}
\]

---

### 🔎 为什么对中心词也 subsample？

有些人以为只 subsample 上下文词，这是误解。**论文明确指出两个方向都采样**。  
- 高频词作为中心词的训练价值也很低（比如："the" → 预测上下文不提供有效信息）。
- 高频词的上下文预测出来也没什么学习意义（"the" co-occurs with almost everything）。

**所以，中心词和上下文词都会应用同一个丢弃概率 P(w)。**

---

### 📚 论文原文的证据

论文第 2.3 节写道：
> “**Each word wi in the training set is discarded with probability...**”  
> → 意思是**训练数据中“每个单词”**（不管它是中心词还是上下文词）都会被 subsampling 检查。

没有限制说“只丢上下文”或者“只丢中心词”。

---

## ✅ 小结

| 单词角色 | 是否应用 Subsampling |
|----|----|
| 中心词 | ✅ 是 |
| 上下文词 | ✅ 是 |

简而言之：**训练数据中的每个单词，无论在样本对中扮演什么角色，都会被检查是否 subsample。**

---


# Negative Sampling

---

## 🧠 **Negative Sampling 的核心目标**：

> 让**正确的中心词-上下文词对（正样本）**的向量更相似；  
> 让**随机拼凑的不相关词对（负样本）**的向量更不相似。

而不是像传统 softmax 那样去计算完整概率分布（非常耗费计算资源）。

---

## 🔎 **数学公式回顾**

对于一个训练样本（中心词 \( w_I \)，上下文词 \( w_O \)），目标函数是：

\[
\log \sigma(v'_{w_O}^\top v_{w_I}) + \sum_{i=1}^k \mathbb{E}_{w_i \sim P_n(w)} [ \log \sigma(-v'_{w_i}^\top v_{w_I}) ]
\]

- **第1项**：最大化**正样本** \( (w_I, w_O) \) 的相似度。
- **第2项**：最小化 K 个**负样本** \( (w_I, w_i) \) 的相似度。

\(\sigma\) 是 Sigmoid 函数（0~1）。

---

## 👓 **具体例子说明**

假设训练句子是：  
`the quick brown fox jumps`

窗口大小 \( c = 2 \)。

### Step 1️⃣：选一个中心词  
比如 **中心词**： `quick`

### Step 2️⃣：确定上下文词（正样本）  
上下文窗口里，可能的上下文词有： `the` 和 `brown`。

构建 **正样本**：
- 正样本1：(`quick`, `the`)
- 正样本2：(`quick`, `brown`)

假设我们现在处理的是 (`quick`, `brown`)。

---

## ✅ 正样本的目标

**希望 quick 和 brown 的向量很接近。**

数学上：
\[
\log \sigma(v'_{brown}^\top v_{quick})
\]

越大越好 → **\( v'_{brown} \) 和 \( v_{quick} \) 的点积（相似度）要变大**。

通过训练，**调整两个词的向量**，让它们的相似度（点积）变高。

---

## ❌ 负样本的选择

假设负样本数 \( k = 2 \)。  
从词表随机选两个词（一般根据词频 Pn(w) 进行有偏抽样）。

比如负样本是：`banana` 和 `politics`。

负样本对：
- (`quick`, `banana`)
- (`quick`, `politics`)

---

## ❌ 负样本的目标

**希望 quick 和 banana、politics 的向量很不相似。**

数学上：
\[
\sum_{i=1}^k \log \sigma(-v'_{w_i}^\top v_{quick})
\]

- \( w_i \) 是 `banana` 和 `politics`。
- 负号表示要让相似度变小。

**目标：使 \( v'_{banana}^\top v_{quick} \) 和 \( v'_{politics}^\top v_{quick} \) 变负或接近0。**

---

## 📝 **为什么用 Sigmoid？**

Sigmoid 函数：
\[
\sigma(x) = \frac{1}{1 + e^{-x}}
\]

- 当点积 **大** → \(\sigma(x)\) 接近 1 → 高相似度。
- 当点积 **小或负** → \(\sigma(x)\) 接近 0 → 低相似度。

**正样本：**
\[
\log \sigma(\text{正样本的相似度}) → 最大化 → 让 \(\sigma \approx 1\)
\]

**负样本：**
\[
\log \sigma(-\text{负样本的相似度}) → 最大化 → 让 \(\sigma(-相似度) \approx 1\) → 相似度变小或负。
\]

---

## 🎯 **训练过程简述**

对于每个训练对：
1. 计算正样本相似度 → 想办法提升。
2. 随机抽 K 个负样本，计算相似度 → 想办法降低。
3. 更新相关词的向量参数（反向传播）。

**注意：**
- 每次更新**只涉及中心词、上下文词、K 个负样本** → 计算效率极高。
- 不需要计算整个词汇表的 softmax（大大节省计算）。

---

## 📝 小结

| 类型 | 目标 | 作用 |
|----|----|----|
| 正样本 | 最大化 \( \sigma(v' \cdot v) \) | 让相关词向量靠近 |
| 负样本 | 最大化 \( \sigma(-v' \cdot v) \) | 让无关词向量远离 |

Negative Sampling 本质上是在告诉模型：
> “quick”和“brown”应该亲密，  
> “quick”和“banana”/“politics”应该疏远。

---

## 🔥 **额外说明：为什么叫 Negative Sampling？**
- **Sampling**：是因为负样本是**从词表中采样**的。
- **Negative**：是因为采样的词对是“不该相关”的。

---