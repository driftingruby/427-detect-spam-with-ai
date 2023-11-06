import torch
from transformers import RobertaTokenizer, RobertaForSequenceClassification

if torch.cuda.is_available():
  print("USING CUDA")
  device = torch.device("cuda")
elif torch.backends.mps.is_available():
  print("USING Apple Metal")
  device = torch.device("mps")
else:
  print("USING CPU")
  device = torch.device("cpu")

model_path = "mshenoda/roberta-spam"
tokenizer = RobertaTokenizer.from_pretrained(model_path)
model = RobertaForSequenceClassification.from_pretrained(model_path, num_labels=2).to(device)

def detect(text):
  inputs = tokenizer(text, return_tensors="pt", padding="max_length", truncation=True, max_length=512)
  inputs = {k: v.to(device) for k,v in inputs.items()}

  with torch.no_grad():
    outputs = model(**inputs)

  return torch.argmax(outputs.logits, dim=1)
