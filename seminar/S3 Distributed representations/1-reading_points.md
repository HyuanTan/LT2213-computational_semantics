# Learning to Compose Spatial Relations with Grounded Neural Language Models

---

## 1️⃣ Can compositionality be learned from data?  
**组合性可以通过数据学习吗？**

✅ **Yes, and this paper proves it. 是的，这篇论文已经证明了这一点。**  
- The experiments show that even when some **compositional phrases (AND, OR, NOT)** are missing from the training data,  
  **the model can still generalize** and correctly predict spatial templates for unseen combinations.  
- 实验表明，即使训练数据中缺失了一些组合短语（AND、OR、NOT），模型依然可以泛化并正确预测**未见过组合的空间模板**。

**实验证据 Evidence**：  
Spearman’s ρ 高达 0.7~0.9，即模型的预测与真实空间模板的排名高度一致。

---

## 2️⃣ Why do we ground our language model in perceptual informations/locations?  
**为什么要将语言模型与感知信息/空间位置绑定？**

✅ **Because meaning is grounded in perception. 因为语言意义依赖于感知。**  
- Spatial descriptions like **"above"**, **"left of"** only make sense in relation to physical space.  
- 空间描述（如 "above"、"left of"）只有在物理空间中才有意义。  
- Grounding links language to the **real world**, not just to other words.  
- “地面性（grounding）”把语言与**真实世界**连接，而不仅仅是词与词的关联。

**论文做法 In the paper**：  
每个描述短语与一个**7×7网格的空间模板**相关联，模板反映该描述适用于哪些空间位置。

---

## 3️⃣ To what degree are distributional composed representations interpretable?  
**分布式组合表示的可解释性有多强？**

✅ **Partially interpretable, but not fully transparent. 部分可解释，但不完全透明。**  
- The predicted spatial templates (输出的空间模板) can be directly compared with human data using **Spearman’s correlation**.  
- 预测的空间模板可以通过 Spearman 相关系数与人类数据直接对比。  
- However, the **internal hidden states (隐藏状态)** of the LSTM are high-dimensional and remain a "black box."  
- 然而，LSTM 的**隐藏状态**是高维的，仍然是一个“黑箱”。

---

## 4️⃣ Are the representations that we have learned the same as those we would expect from compositional rules?  
**学到的表示与我们期望的组合规则一致吗？**

✅ **Mostly, especially for simple combinations. 大多数情况下是一致的，尤其是简单组合。**  
- For AND combinations → 模型学到了类似**空间模板的交集**。  
- For OR combinations → 类似**空间模板的并集**。  
- For NOT → 类似**模板的补集**。  
- The model approximated the **logical compositional functions** proposed in previous studies.  
- 模型近似学习了以往研究提出的**逻辑组合函数**。

**但注意 But**：  
复杂或矛盾的组合（如 "left of and right of"）表现不稳定。

---

## 5️⃣ Neural networks are also compositional models in the sense that they are composed of units and each of these units defines some representations. Do you agree?  
**神经网络本身也是组合模型吗？你同意吗？**

✅ **Yes, in structure, but with differences from formal semantics. 是的，从结构上看是，但与形式语义存在差异。**  
- Neural networks combine **word embeddings + location encodings** at each time step.  
- 神经网络在每个时间步**组合词嵌入和位置编码**。  
- The LSTM’s hidden state **h_t** is itself a **composition** of previous words and locations.  
- LSTM 的隐藏状态 h_t 本身就是前面词和位置的**组合结果**。  
- However, unlike formal semantics, these combinations are **continuous and learned**, not **symbolic and predefined**.  
- 但不同于形式语义，这些组合是**连续值并通过学习获得的**，而不是**符号化且预定义的**。

---

## 6️⃣ To what degree can we say that a neural network has learned compositional functions like those in formal semantics?  
**我们可以在多大程度上说神经网络学会了类似形式语义的组合函数？**

✅ **To a significant degree, but the mechanism differs. 在相当大的程度上学会了，但机制不同。**  
- The model successfully approximated the **AND, OR, NOT** operations over spatial meanings.  
- 模型成功地逼近了空间意义上的**与（AND）、或（OR）、非（NOT）**操作。  
- **Functionally**, the behavior is similar to formal semantic rules.  
- **功能上**，表现类似形式语义规则。  
- But the **internal computation** relies on **distributed representations** and learned weights, not explicit logical rules.  
- 但**内部计算**依赖于**分布式表示和学习到的权重**，而不是显式的逻辑规则。

---

## ✅ 总结 Summary Table

| 问题 Question | 答案 Answer |
|---|---|
| 组合性能否通过数据学习？Can compositionality be learned? | Yes, experiments show strong generalization. 是，实验显示强泛化能力。 |
| 为什么需要 grounding？Why ground the model? | Language meaning depends on perception. 语言意义依赖于感知。 |
| 分布式表示的可解释性？Interpretability? | Partially interpretable, via spatial templates. 通过空间模板部分可解释。 |
| 表示与组合规则一致吗？Consistency with compositional rules? | Mostly consistent, especially for simple combinations. 大多数一致。 |
| 神经网络是否具备组合性？Is the neural network compositional? | Structurally yes, but different from symbolic models. 结构上是，但方式不同。 |
| 是否学会了形式语义的组合函数？Learned compositional functions? | Functionally similar, but mechanisms differ. 功能类似，机制不同。 |

---


# 详细分析总结这篇论文《Learning to Compose Spatial Relations with Grounded Neural Language Models》的方法和结论

---

## 方法总结

### 1️⃣ 研究目标  
- **核心问题**：语言具有**组合性**（compositionality），即人类可以根据单词意义和其组合关系理解新的句子。  
- **研究方向**：研究**基于感知（perceptual）信息的神经语言模型**（Grounded Neural Language Models, GNLMs）如何学习和表达**空间关系**的组合语义。

### 2️⃣ 数据集设计  
- **基础数据**：使用 Logan & Sadler (1996) 提供的**空间模板**，每个模板表示目标物体相对标志物体的位置接受度（acceptability scores），7×7 网格。
- **组合描述**：  
  - 单词组合方式：AND（交集）、OR（并集）、NOT（取反）。  
  - 举例：“above and right of”、“not below”等。
- **数据生成**：根据模板，将接受度归一化为概率，合成大量**语言描述-位置对**作为训练数据。  
- **干扰词设计**（Experiment 2）：引入无空间意义的词（如 the, ball, box, it）来测试模型是否能识别哪些词具有空间语义。

### 3️⃣ 神经网络模型  
- **架构**：  
  - **LSTM-RNN** 语言模型，结合位置编码。  
  - 每个词的嵌入与位置编码（one-hot）拼接，作为 LSTM 的输入。  
  - 输出预测下一个单词的概率（softmax）。
- **训练**：  
  - 使用交叉熵损失（cross-entropy），Adam 优化器。  
  - 训练直到验证损失和训练损失趋于一致。

### 4️⃣ 实验设计  
- **Experiment 1**：只含空间意义的词，测试模型能否从已见的组合中学会未见组合的空间语义。  
- **Experiment 2**：加入干扰词，测试模型区分具备/不具备空间语义的词能力。  
- **Experiment 3**：探索学习曲线与组合性学习效果的关系。

### 5️⃣ 评估指标  
- **Spearman 等级相关系数 (ρ)**：比较模型生成的空间模板与真实模板的排名一致性。

---

## 结论总结

### ✅ 主要发现
1. **学习新组合能力强**  
   - 即使训练集中缺失一部分组合描述，模型依然能成功预测未见组合的空间模板（Experiment 1）。
   - 在组合缺失 50% 的情况下，AND 和 OR 组合的 ρ 依然分别达到约 0.71 和 0.56。

2. **单词语义可迁移**  
   - 即使单独单词没有出现在训练集中，模型依然可以通过学习组合句子掌握该词的空间意义（单词的“组合迁移”能力）。

3. **对干扰词鲁棒**  
   - 加入“无空间意义”的词（Experiment 2）后，模型仍能有效识别哪些词对空间语义有贡献，整体表现与 Experiment 1 相近。

4. **学习过程表现良好**  
   - ρ 随着训练迭代增加，表现出清晰的上升趋势（Experiment 3），说明学习的“语义地面性（groundedness）”随训练深入而增强。

### ✅ 关键结论
- **神经网络可以学习和泛化空间语义的组合性**，即使面对新的组合或者缺失单词的情况。  
- 证明了**深度学习模型可以有效实现组合性语义学习**，并且能够区分语言中哪些成分具有“地面性”（与感知相关），哪些不具有。  
- 这为未来进一步**将神经语言模型应用于视觉场景描述、机器人空间语言理解等任务**提供了理论和方法支持。

# 进一步详细介绍论文中各个实验的具体方法

这篇论文总共做了**三个主要实验**，每个实验都有细致的设计思路。下面我按顺序逐一解释：

---

# 📚 实验方法详细介绍

## 🧪 Experiment 1 — 组合短语的学习（无干扰词）
### 【目的】
- 测试：**模型能否学习和预测新的组合空间描述？**
- 特点：数据集中**所有词都有明确的空间意义**，没有无关干扰词。

### 【数据准备】
- **描述类型**：
  - 单词：如 "left"、"above"。
  - 组合短语：
    - **AND组合**（交集）："above and right of"
    - **OR组合**（并集）："either left of or near to"
    - **NOT组合**（取反）："not below"

- **组合数据生成**：
  - 通过公式将不同单词的空间模板合成（例如AND是模板逐点相乘）。

- **Hold-out设计**：
  - 刻意从训练集中**移除一部分组合**，比如移除50%的AND短语和OR短语，看模型能否推断这些未见过的组合。

### 【训练方法】
- **输入**：句子（如 "above and right of"）+ 位置（一个编码的点）。
- **输出**：下一个单词的预测概率。
- **模型**：LSTM-RNN，输入是词嵌入+位置编码的拼接。

- **训练细节**：
  - 批次大小：8
  - 总迭代：64 epochs
  - 损失函数：交叉熵
  - 优化器：Adam
  - 验证集占10%

### 【评估方法】
- 对每个测试句子：
  - 从模型预测出它对应的位置概率分布（spatial template）。
  - 与原先模板做**Spearman等级相关性**比较（越接近1越好）。

---
  
## 🧪 Experiment 2 — 加入干扰词后的学习（复杂描述）
### 【目的】
- 测试：**加入无空间意义的词后，模型是否还能识别和推理空间关系？**

### 【数据准备】
- 在 Experiment 1 的基础上，**引入新的文本规则**，制造冗余元素，比如：
  - "the ball is above the box"
  - "it is not right of the object"

- **新增词汇**：the, ball, box, it, object, is（这些词本身没有空间意义）

- **新句子生成规则**（5条）：
  - 直接 spatial phrase ("left of")
  - "it is spatial phrase"
  - "it is spatial phrase the box"
  - "the ball is spatial phrase the box"
  - "the object is spatial phrase the box"

- **Hold-out设计**：
  - 同样移除一部分组合，测试泛化能力。

### 【训练方法】
- **输入**：更长、包含无关词的句子 + 位置编码。
- **训练细节**：
  - 批次大小：256
  - 总迭代：最多1024 epochs（或提前停止）
  - 其他同上。

### 【评估方法】
- 同样用**Spearman等级相关性**评估模板的预测质量。
- 特别注意模型是否能忽略“干扰词”仅关注有意义的成分。

---
  
## 🧪 Experiment 3 — 分析学习过程中的语义地面性变化（学习曲线）
### 【目的】
- 测试：**随着训练进行，模型对空间组合语义的掌握速度如何？**

### 【方法】
- 选用 Experiment 1 的设置，保留 80% 的数据训练，20%数据作为hold-out。
- 在训练过程中，每训练若干步，记录：
  - 交叉熵损失（log-loss）
  - 预测的空间模板与真实模板的 Spearman相关系数

- 画出：
  - **训练loss** vs **epoch**
  - **验证loss** vs **epoch**
  - **平均Spearman ρ** vs **epoch**

### 【特点】
- 观察到：**即使loss下降变慢，空间地面性（ρ）还在持续提高**。
- 说明学习空间组合意义比简单拟合loss更复杂，需要更长时间积累。

---

# ✏️ 小结表格（快速回顾）

| 实验 | 核心问题 | 特点 | 关键评估 |
|:---|:---|:---|:---|
| Experiment 1 | 能否推断未见组合？ | 无干扰词，清洁组合 | Spearman ρ |
| Experiment 2 | 能否忽略干扰词？ | 加入the, ball等无意义词 | Spearman ρ |
| Experiment 3 | 学习进程如何？ | 分析训练中地面性变化 | ρ变化曲线 vs loss |

---

# 语言模型的输入机制和位置编码的处理逻辑

---

## 🧠 训练和测试的输入方式

### ✅ **训练过程**
是**逐步（step by step）**输入的，但 **在实现时通常 batch 并行（一次输入整个序列）**。  
也就是说：
1. 训练时，整个句子的**所有词+位置编码**一次性送入模型。  
2. 但**内部的LSTM运算是按时间步展开**，一个词一个词依次处理（比如 t=1 输入第一个词，t=2 输入第二个词……）。

所以：
- **用户视角**（输入数据）：一次性提供整个句子所有词的词嵌入+位置编码。
- **模型视角**（LSTM 计算）：时间步展开，一个词接一个词按顺序处理。

**为什么这样设计？**  
- 框架（Keras、TensorFlow）为了效率，允许你**并行输入完整句子**，但循环结构（RNN/LSTM）还是按顺序依次处理每个时间步。

---

### ✅ **测试（预测）过程**
和训练类似：
- 一次性输入整个句子的词嵌入+位置编码。
- LSTM 内部按时间步展开，逐步输出。

（注意：虽然可以“逐词输入”，但为了效率，通常**测试也用批量输入**）

---

## 🧠 and、or、not 这种没有空间含义的词，位置编码怎么办？

很好的观察！  
论文的做法是：

### ✅ 每个词的输入 = 词嵌入 + 位置编码（拼接）

- **无论这个词是否有空间意义，位置编码一样附加**。
- 比如：
  - "above"（有空间意义）+ 位置编码（one-hot）。
  - "and"（无空间意义）+ 同样的那个位置编码（虽然位置对它不影响）。

### ✅ **为什么这么做？**
- LSTM 的**目标是学会区分**：哪些词对预测有用（grounded），哪些只是语法连接（不grounded）。
- 所以：
  - **and 的词嵌入**会学到：不需要依赖位置。
  - **above 的词嵌入**会学到：跟位置高度相关。

这个差异完全靠训练过程中模型自己学会。  
（实际结果证明模型成功做到了 —— 这也是论文的关键贡献）

---

## 📝 举个具体例子

句子：  
**"the ball is above and right of the box"**

位置：`(4, 6)` → 编码为 one-hot。

| 时间步 | 当前词 | 词嵌入 | 位置编码 | 拼接后输入 |
|---|---|---|---|---|
| 1 | the | e_the | 位置编码 | e_the + 位置编码 |
| 2 | ball | e_ball | 位置编码 | e_ball + 位置编码 |
| 3 | is | e_is | 位置编码 | e_is + 位置编码 |
| 4 | above | e_above | 位置编码 | e_above + 位置编码 |
| 5 | and | e_and | 位置编码 | e_and + 位置编码 |
| 6 | right | e_right | 位置编码 | e_right + 位置编码 |
| 7 | of | e_of | 位置编码 | e_of + 位置编码 |
| 8 | the | e_the | 位置编码 | e_the + 位置编码 |
| 9 | box | e_box | 位置编码 | e_box + 位置编码 |

**注意**：
- 所有词**统一拼接相同的位置编码**，无论词本身是否和位置有关。
- 模型自己通过训练，学习哪些词对位置有贡献，哪些只是语言结构部分。

---

## 🔎 结论

| 问题 | 答案 |
|---|---|
| 训练/测试输入是逐步还是整体？ | 数据整体输入，LSTM按时间步逐步处理。 |
| 每个词是否都拼接位置编码？ | 是，即使是 "and"、"the" 也拼接相同的位置编码。 |
| 无空间意义的词如何处理位置编码？ | 拼接，但模型会学到它们与位置无关。 |

---



在这篇论文的模型里，**RNN+LSTM的最终输出是：**  
✅ **每个时间步预测的“下一个词”的概率分布**。  
（具体地，是一个softmax输出，是对词表中所有词的概率估计。）

---

# 🔥 详细解释

## 1️⃣ 每一个时间步的输出是什么？
在时间步 t：
- LSTM接收输入（当前词嵌入 + 位置编码，拼接成一个大向量）。
- 经过LSTM单元处理后，产生一个**隐藏状态向量** `h_t`。
- `h_t` 通过一个**全连接层（dense layer）**和**softmax激活函数**，输出：
  - 一个**向量**，长度等于词汇表大小（比如有100个词，向量就是100维）。
  - 每一维表示**当前输入后最可能出现的下一个词的概率**。

例如，当前输入是 "above"，位置是 `(4,6)`，那么输出可能是：
```
P(and) = 0.75  
P(right) = 0.15  
P(below) = 0.05  
其他词的概率 = 很小
```

即：**模型预测下一个词是 "and" 的概率最大**（符合"above and ..."这种自然搭配）。

---

## 2️⃣ 整个序列（整句话）结束后的输出是什么？

- 把**所有时间步的预测结果连起来**，你就得到了：
  - 句子生成过程中**每个词的预测轨迹**。
  
**但在本文的应用中，真正关心的是：**

➡ **用所有时间步的softmax输出来计算整个句子在特定位置下出现的概率。**

公式如下（论文 Equation (1)）：

\[
Pr(w_{1:T}|c) = \prod_{t=1}^T Pr(w_t|w_{1:t-1}, c)
\]

也就是说：
- 整个句子的概率 = 所有时间步预测概率的连乘。

**最后根据这串概率，在每一个空间位置上生成一个“空间模板”（Spatial Template）**。

这个空间模板是用来：
- 表达：“在某个具体位置，这句话出现的可能性有多高？”
- 后续与人类实验得出的模板比较（Spearman相关性评估）。

---

# 🖐 举个完整例子

假设你要描述的位置是 `(4,6)`。

输入句子：  
**"\<s> above and right of \</s>"**

时间步走向：

| 时间步 t | 当前输入 | LSTM输出 | softmax预测（下一个词概率） |
|:---|:---|:---|:---|
| 1 | `<s>` | h1 | 预测 "above" |
| 2 | above | h2 | 预测 "and" |
| 3 | and | h3 | 预测 "right" |
| 4 | right | h4 | 预测 "of" |
| 5 | of | h5 | 预测 `</s>` |

最终：
- 得到5个时间步的 softmax 输出。
- 把每步对应预测词的概率乘起来。
- 得到整个句子在位置 `(4,6)` 的**条件概率 Pr(sentence | location)**。

---

# ✅ 总结一下

| 内容 | 解释 |
|:---|:---|
| 每个时间步的输出 | 对**下一个词**的softmax概率分布。 |
| 整个句子的输出 | 连乘所有时间步的目标词预测概率，得到 Pr(句子 | 位置)。 |
| 最终用于什么 | 在每个位置上生成一个“空间模板”，然后用来评估学习效果。 |

---

**RNN+LSTM在这个模型里的最终输出**是有两种含义的（看你问的是哪一层面的“输出”）：

---

## 🧠 第一层含义：**时间步的输出**（预测下一个单词）

在**每个时间步** `t`，LSTM 的**最终输出** `ŷ_t` 是：  
➡ **词汇表中所有词的概率分布**，表示“下一个词是什么”的预测。

公式（论文第3节的公式12）：

```plaintext
ŷ_t = softmax(W * h_t + b)
```

- `h_t`：时间步 t 的隐藏状态（LSTM 处理当前词和之前上下文的结果）。
- `W` 和 `b`：输出层的权重和偏置。
- `softmax`：把输出转换为概率分布。

**例子**（假设词汇表是 {"above", "left", "right", "and", "</s>"}）：

```plaintext
时间步3 输入："and"
h_3 经过 W 和 b → softmax → 输出：
P(above) = 0.02
P(left) = 0.05
P(right) = 0.9
P(and) = 0.01
P(</s>) = 0.02
```

模型“认为”下一个词是 "right"，概率最高（0.9）。

**注意**：  
- 这种逐步预测（step-wise prediction）继续直到输出 `</s>`（句子结束符）。  
- 这是典型的 **语言建模任务**（下一个词预测）。

---

## 🧠 第二层含义：**整句的输出**（概率 → 空间模板）

虽然 LSTM 每步输出下一个词的概率，但**整个句子的输出**也定义了一个非常重要的东西：

➡ **给定位置，整个句子的概率 Pr(w₁:T | c)**  
➡ 再进一步：**对所有位置的概率分布 → 空间模板**

公式（论文公式15 & 16）：

```plaintext
Pr(w₁:T | c) = Π (每步的 ŷ_t 对应的词的概率)
```

也就是说：
- 把时间步 t=1 到 t=T 的所有预测概率相乘，得到**整个句子在该位置的总概率**。

再对**地图上所有49个位置**（7×7 网格）做这个运算，得到：

```plaintext
T̂w₁:T = {Pr(w₁:T | c)}  （每个 c 是一个位置）
```

这个 `T̂w₁:T` 就是**空间模板**，表示句子 w₁:T 对各个位置的适应性。

---

## 📝 小结：最终的输出是什么？

| 层次 | 输出 | 含义 |
|---|---|---|
| 单个时间步 t | 下一个词的概率分布（ŷ_t） | 哪个词最可能是下一个词 |
| 整个句子 | Pr(w₁:T | c) | 这个句子描述位置 c 的概率 |
| 所有位置 | T̂w₁:T = {Pr(w₁:T | c)} | 句子的空间模板（对所有位置的适应性分布） |

---

## 🔎 举个完整例子

句子："above and right of"  
位置：`(4,6)` → 编码 c₁

假设时间步的预测概率如下：

| 时间步 | 当前词 | 目标下一个词 | 预测概率 |
|---|---|---|---|
| 1 | <s> | above | 0.9 |
| 2 | above | and | 0.85 |
| 3 | and | right | 0.88 |
| 4 | right | of | 0.92 |
| 5 | of | </s> | 0.95 |

**整个句子在位置 c₁ 的概率**：

```plaintext
Pr(w₁:T | c₁) = 0.9 × 0.85 × 0.88 × 0.92 × 0.95 ≈ 0.58
```

对 49 个位置做同样的计算 → 得到**空间模板向量（49维）**。

---

## ✅ 总结

**最终的输出有两层**：

1️⃣ **逐时间步输出**：预测下一个词的概率（用于句子生成）。  
2️⃣ **整句输出**：对每个位置的整体概率，用来形成**空间模板**（评估组合语言和空间感知的关系）。

---

 

**具体解释一下：如何对49个位置都做相同的计算**。

---

## 🔍 为什么要对49个位置都算？

- 一句话（比如 "above and right of"）**不是只描述一个位置**，而是**可能对很多位置都成立**，程度不同。  
- 所以，模型要在**7×7 = 49**个可能的位置上，分别计算**Pr(句子 | 位置)**，得到一个完整的**空间模板**。

这个空间模板告诉我们：  
> 在每个位置，这个句子的描述适用的可能性有多大。

---

## 🔧 具体怎么操作（49个位置逐一计算）

假设你要生成 "above and right of" 的空间模板。

| 步骤 | 操作 |
|---|---|
| 1 | 遍历49个位置：`c1, c2, ..., c49` |
| 2 | 对每个位置 `ci`： |
| 3 | **把位置编码（one-hot）设置为 ci** |
| 4 | 构造输入：**句子词嵌入 + ci的位置编码**（所有时间步都用同一个位置编码 ci） |
| 5 | 把这个输入送进 LSTM，时间步展开，预测每个词的概率： `Pr(w1|c), Pr(w2|w1,c), ...` |
| 6 | 把每步对应的概率相乘，得到 `Pr(句子|ci)` |
| 7 | 存储 `Pr(句子|ci)`，继续下一个位置 |

**最终**：  
得到 `Pr(句子|c1) ~ Pr(句子|c49)`，组成一个49维向量（空间模板）。

---

## 📝 举个例子

假设句子：  
**"above and right of"**

位置 c1 = 网格左上角 (1,1)  
位置 c2 = (1,2)  
...  
位置 c49 = 网格右下角 (7,7)

对于 c1：

- 所有时间步输入：  
  - 当前词嵌入 + c1的位置编码。
- LSTM 预测下一词的概率：
  - Pr(above|\<s>,c1)、Pr(and|above,c1)、Pr(right|and,c1)、Pr(of|right,c1)
- 概率相乘，得到 Pr(句子|c1)。

对 c2 到 c49 依次做相同操作，得：
```
T_hat["above and right of"] = [Pr(句子|c1), Pr(句子|c2), ..., Pr(句子|c49)]
```

这个 `T_hat` 向量就是**模型生成的空间模板**。



## 可以类比：

这个过程**类似图像卷积**：
- 句子是一个“滤波器”，
- 把“滤波器”滑过49个位置，计算每个位置的响应。

最终，得到的空间模板就像“热力图”，突出句子描述最适合的区域。

---

## ✅ 小结

| 目标 | 方法 |
|---|---|
| 计算句子在49个位置的可能性 | 对每个位置 ci，把该位置编码拼接进句子所有时间步的输入，运行 LSTM，连乘各步概率，得到 Pr(句子|ci)。 |
| 最终得到 | 一个49维的空间模板，表示句子描述在每个位置的适用程度。 |

