This assignment is a part of the preparation for the seminar on 3 April.

Please have a look here for how to prepare for the seminar.

In this seminar we will look at the key issues related to using logic for representing natural language semantics: 
how we translate natural language to different kinds of **logic representations**, ensure compositionality of linguistic expressions, how we can use these representations to **evaluate** what sentences **mean**, **deal with ambiguity** of natural language and finally how we can **draw inference** with semantic representations. 


In this seminar we will look at the following paper (or rather a chapter):

Chapter 10: Analyzing the meaning of sentences of S. Bird, E. Klein, and E. Loper. Natural language processing with Python. O’Reilly, 2009. (You may leave out section 5 Discourse semantics).


Optional but helpful background:

M. Stone. Semantics and computation.Links to an external site. In M. Aloni and P. Dekker, editors, The Cambridge Handbook of Formal Semantics, Cambridge Handbooks in Language and Linguistics, chapter 25, pages 775–800. Cambridge University Press, Cambridge, UK, July 2016.

The chapter gives an overview of key questions related to implementing **logic-based models** and provides examples of implementations in Python and **feature-based unification grammars**. If you are new to this topic, you might find the chapter quite dense. However, do not despair! The purpose of the seminar is to familiarise yourself with these and but also to **critically discuss** what **features** of natural language meaning we represent this way, what are **useful applications** of this approach and its **limitations**. In the programming assignment (which follows) we will practically implement some extensions of the models and grammars presented here. 

Below are some points that you may want to consider when reading these papers:

* 1.What are **challenges** of **translating natural language to logic** (in general)?
* 2.Logics are formal languages each with specific properties: what aspects of natural language semantics are **treated well** with logic and what aspects are **not captured**?
* 3.How is **underspecification** of quantifier scope implemented in Cooper storage?
* 4.How about other forms of underspecification in natural language, e.g. lexical ambiguity?
* 5.Why do we need lambda calculus?
* 6.How can we use **model builders and theorem provers** (computational tools) to check **validity of arguments**?
* 7.Do humans also reason logically - do they make the same inferences as theorem provers and model builders?
* 8.In what NLP applications we would use this approach?

machine translation: Computational semantics such as formal language, compositional semantics 等能否从语法逻辑和内容解决和验证翻译是否正确？能否消除歧义
question answering and dialogue systems：Computational semantics能否避免生成式模型导致的可能不正确的回答？能否进行正确的推理？

The assignment is marked on a 7 level scale where 4 is sufficient to complete the assignment; 5 is good solid work; 6 is excellent work, covers most of the assignment; and 7: creative work that goes beyond the assignment.


Models like GPT-4 are prone to generate sound fluent but incorrect answers because they lack explicit semantic reasoning, can computational semantics, lamda calculate help solve this proble?
