''' 
import torch

# 查看 PyTorch 版本
print("PyTorch version:", torch.__version__)

# 查看是否支持 CUDA（即是否使用 GPU）
print("CUDA available:", torch.cuda.is_available())

# 查看 CUDA 的版本（如果支持）
if torch.cuda.is_available():
    print("CUDA version:", torch.version.cuda)
    print("GPU name:", torch.cuda.get_device_name(0))

'''

# from transformers import BertModel, BertTokenizer
# # Test load
# model = BertModel.from_pretrained('bert-base-uncased')
# tokenizer = BertTokenizer.from_pretrained('bert-base-uncased')
# print("BERT and tokenizer loaded successfully.")

from transformers import BertForSequenceClassification, BertTokenizer
import torch
import torch.nn as nn

model = BertForSequenceClassification.from_pretrained(
    "bert-base-uncased",
    num_labels=2  # This must match the number of senses
)
tokenizer = BertTokenizer.from_pretrained('bert-base-uncased')
print("BERT and tokenizer loaded successfully.")