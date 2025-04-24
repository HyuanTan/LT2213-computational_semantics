In this seminar we will examine distributional representations of lexical meaning as modelled by vector space models and how these representations can be linked to compositionality of lexical items in phrases which we identified as one of the key properties of natural language. What do we mean by distributional meaning? How do we build vector space models computationally from corpora? How we generalise such representations? How we can compose the semantic vectors to get representations of phrases?
在本次研讨会上，我们将探讨向量空间模型所构建的词汇意义的分布表征，以及这些表征如何与短语中词汇项的组合性相联系，而我们认为组合性是自然语言的关键属性之一。我们所说的分布意义是什么意思？我们如何从语料库中计算地构建向量空间模型？我们如何推广这些表征？我们如何组合语义向量来获得短语的表征？

We will look at the following paper (or rather a chapter):
我们将研究以下论文（或者更确切地说是章节）：

S. Clark. Vector space models of lexical meaning.Download Vector space models of lexical meaning.
S. Clark.词汇意义的向量空间模型。 In S. Lappin and C. Fox, editors, Handbook of Contemporary Semantics — second edition, chapter 16, pages 493–522. Wiley – Blackwell, 2015.
S. Lappin 和 C. Fox 编，《当代语义学手册》第二版，第 16 章，第 493-522 页。Wiley – Blackwell 出版社，2015 年。
Optional but helpful background and further reading:
可选但有用的背景和进一步阅读：

K. Erk. Vector space models of word meaning and phrase meaning: A survey.Links to an external site.
K. Erk.词义和短语义的向量空间模型：综述。 Language and Linguistics Compass, 6(10):635–653, 2012.
语言和语言学指南，6(10):635–653，2012。
P. D. Turney, P. Pantel, et al. From frequency to meaning: Vector space models of semantics.Links to an external site.
PD Turney、P. Pantel 等人。从频率到含义：语义的向量空间模型。 Journal of artificial intelligence research, 37(1):141–188, 2010.
《人工智能研究杂志》，37(1):141–188，2010 年。
J. Mitchell and M. Lapata. Vector-based models of semantic composition.Links to an external site.
J. Mitchell 和 M. Lapata.基于矢量的语义组合模型。 In Proceedings of ACL-08: HLT, pages 236–244, Columbus, Ohio, 2008.
在 ACL-08：HLT 论文集，第 236-244 页，俄亥俄州哥伦布市，2008 年。
J. Mitchell and M. Lapata. Composition in distributional models of semantics.Links to an external site.
J. Mitchell 和 M. Lapata.语义分布模型中的组合。  Cognitive Science, 34(8):1388–1429, 2010.
认知科学，34(8):1388–1429, 2010。
E. M. Bender and A. Koller. Climbing towards NLU: On meaning, form, and understanding in the age of data.Links to an external site.
EM Bender 和 A. Koller。迈向 NLU：论数据时代的意义、形式和理解。 In Proceedings of the 58th Annual Meeting of the Association for Computational Linguistics, pages 5185–5198, Online, July 2020. Association for Computational Linguistics.
在计算语言学协会第 58 届年会论文集，第 5185-5198 页，在线，2020 年 7 月。计算语言学协会。
S. Dobnik, R. Cooper, A. Ek, B. Noble, S. Larsson, N. Ilinykh, V. Maraev, and V. Somashekarappa. In search of meaning and its representations for computational linguistics.Links to an external site.
S. Dobnik、R. Cooper、A. Ek、B. Noble、S. Larsson、N. Ilinykh、V. Maraev 和 V. Somashekarappa。《寻找计算语言学的意义及其表征》。 In Proceedings of the 2022 CLASP Conference on (Dis)embodiment, pages 30–44, Gothenburg, Sweden, Sept. 2022. Association for Computational Linguistics.
在 2022 年 CLASP (Dis)embodiment 会议论文集，第 30-44 页，瑞典哥德堡，2022 年 9 月。计算语言学协会。
The Clark chapter has two parts. The first part discusses the basics of the vector spaces; how they are built, evaluated and in what tasks they can be used for. The second part discusses one approach of combining a formal semantic grammar (Combinatory category grammar, CCG) and vector representations. This part may be harder to follow if you are less familiar with logic and category theory. Read it from the perspective of understanding the general approach they are taking and prepare specific questions for things that are new to you for the class. You can think of CCG as lambda calculus. The proposal uses a dual system of composition: formal compositional rules over categories are matched with a distributional compositional rules that operate on distributional tensors/matrices.  
Clark 章节分为两部分。第一部分讨论了向量空间的基础知识；它们是如何构建、求值的，以及它们可以用于哪些任务。第二部分讨论了一种将形式语义语法（组合范畴语法，CCG）与向量表示相结合的方法。如果您对逻辑和范畴论不太熟悉，这部分内容可能比较难理解。请从理解他们所采用的一般方法的角度来阅读，并针对课堂上不熟悉的内容准备具体的练习题。您可以将 CCG 视为 lambda 演算。该提案使用了一种双重组合系统：基于范畴的形式组合规则与基于分布张量/矩阵的分布组合规则相匹配。

The optional papers: (i) Erk and Turney and Pantel give a general overview of vector spaces. Mitchel and Lapata test different compositional functions for vectors and compare them to human judgements. Bender and Koller discuss limitations of using distributional representations for natural language processing. In our paper we discuss different representations of meaning used in natural language processing.
可选论文：(i) Erk、Turney 和 Pantel 对向量空间进行了概述。Mitchel 和 Lapata 测试了不同的向量组合函数，并将其与人类判断进行比较。Bender 和 Koller 讨论了使用分布式表示进行自然语言处理的局限性。在我们的论文中，我们讨论了自然语言处理中使用的不同意义表示。

Below are some points that you may want to consider:
以下是您可能需要考虑的一些要点：

On vector space models:  关于向量空间模型：

What notion of meaning is represented by distributional representations?
分布表示代表了什么意义概念？
What semantic relations do they capture?
它们捕捉到了什么语义关系？
How do these relate to the semantic relations we intuitively recognise in natural language?
这些与我们在自然语言中直观识别的语义关系有何关系？
Are there relations that they do not capture?
是否存在他们没有捕捉到的关系？
Think of examples in natural language that can modelled well with distributional relations and examples that cannot be.
想想自然语言中可以很好地用分布关系建模的例子以及不能用分布关系建模的例子。
How does this notion of meaning different from that taken in model-theoretic semantics that we looked at earlier?
这种意义概念与我们之前研究过的模型论语义学中的意义概念有何不同？
Sense and reference?  意义和参考？
What are the main ... for representing meaning of natural language this way?
以这种方式表示自然语言的含义的主要...是什么？
benefits  好处
challenges  挑战
limitations (and dangers!)
局限性（和危险！）
What computational resources, tools and methods do we use to create these representations?
我们使用什么计算资源、工具和方法来创建这些表示？
For what tasks can we use these representations? For what tasks we cannot use them?
我们可以在哪些任务中使用这些表征？在哪些任务中我们不能使用它们？
What would be alternative representations?
替代表现形式是什么？
On compositionality:  关于组合性：

What are the reasons and benefits of combining formal representations with distributional ones?
将形式化表示与分布式表示相结合的原因和好处是什么？
What do you think are the biggest challenges of such hybrid models and representations?
您认为这种混合模型和表示形式面临的最大挑战是什么？
To what degree can we interpret distributional representations?
我们能在多大程度上解释分布表示？
How does this relate to how well a mapping between two types of representations can be achieved?
这与两种类型的表示之间的映射实现程度有何关系？
There are several different ways to write a formal grammar. How would this affect the mapping?
编写形式语法有几种不同的方法。这会如何影响映射？