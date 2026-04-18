# Usage Guide

## Quick Examples

### 1. Basic Text Prediction

```python
from transformers import BertForSequenceClassification, BertTokenizer
import torch

# Load model
model = BertForSequenceClassification.from_pretrained('models/ihc_3way_bert')
tokenizer = BertTokenizer.from_pretrained('models/ihc_3way_bert')

# Prepare input
text = "This is a test message"
inputs = tokenizer(text, return_tensors='pt', truncation=True, max_length=128)

# Get prediction
with torch.no_grad():
    outputs = model(**inputs)
    predictions = torch.argmax(outputs.logits, dim=1)
    confidence = torch.softmax(outputs.logits, dim=1)[0].max().item()

labels = {0: 'Clean', 1: 'Implicit Hate', 2: 'Explicit Hate'}
print(f"Prediction: {labels[predictions.item()]} (Confidence: {confidence:.2%})")
```

### 2. Batch Processing

```python
texts = [
    "This is great!",
    "I hate this group",
    "These people are less human"
]

# Tokenize all at once
inputs = tokenizer(texts, return_tensors='pt', padding=True, 
                   truncation=True, max_length=128)

# Get predictions
with torch.no_grad():
    outputs = model(**inputs)
    predictions = torch.argmax(outputs.logits, dim=1)
    confidences = torch.softmax(outputs.logits, dim=1).max(dim=1)[0]

for text, pred, conf in zip(texts, predictions, confidences):
    print(f"{text:30} → {labels[pred.item()]:15} ({conf.item():.2%})")
```

### 3. Emoji Analysis

```python
# Get emoji information
text = "I love this! 😊❤️"
emoji_info = emoji_extract(text)

for emoji_data in emoji_info:
    emoji = emoji_data['emoji']
    info = emoji_data['info']
    print(f"{emoji}: {info['meaning']} (hate_score: {info['hate_score']})")

# Enrich text with emoji meanings
enriched = emoji_enrich_text(text)
print(f"Original: {text}")
print(f"Enriched: {enriched}")

# Get emoji features
features = emoji_compute_features(text)
print(f"Emoji features: {features}")
```

### 4. Model Explainability

```python
from lime.lime_text import LimeTextExplainer

# Create explainer
explainer = LimeTextExplainer(class_names=list(labels.values()))

# Get explanation
text = "These people should be eliminated"
explanation = explainer.explain_instance(
    text,
    lambda x: torch.softmax(model(**tokenizer(x, return_tensors='pt'))[:0].logits, dim=1).detach().numpy()
)

# Show top features
print("Top features contributing to prediction:")
for word, weight in explanation.as_list():
    print(f"  {word}: {weight:.4f}")
```

### 5. Using Gradio Interface

```python
import gradio as gr
from transformers import pipeline

# Simple interface
def predict(text):
    inputs = tokenizer(text, return_tensors='pt', truncation=True, max_length=128)
    with torch.no_grad():
        outputs = model(**inputs)
        pred = torch.argmax(outputs.logits, dim=1).item()
        conf = torch.softmax(outputs.logits, dim=1)[0].max().item()
    return f"{labels[pred]} ({conf:.2%})"

interface = gr.Interface(
    fn=predict,
    inputs="text",
    outputs="text",
    title="HateFusion - Hate Speech Detector",
    description="Detect hate speech and implicit hate in text"
)

interface.launch()
```

## Configuration

### Environment Variables

```bash
# Disable tokenizer parallelism warnings
export TOKENIZERS_PARALLELISM=false

# Use specific GPU
export CUDA_VISIBLE_DEVICES=0

# Memory optimization
export OMP_NUM_THREADS=1
```

### Model Selection

**For Speed**: Use DistilBERT
```python
model = BertForSequenceClassification.from_pretrained('models/ihc_3way_distilbert')
```

**For Accuracy**: Use BERT
```python
model = BertForSequenceClassification.from_pretrained('models/ihc_3way_bert')
```

**For Fine-grained Classification**: Use 7-way models
```python
model = BertForSequenceClassification.from_pretrained('models/ihc_7way_bert')
```

## Advanced Usage

### Custom Dataset Training

```python
from torch.utils.data import DataLoader, Dataset
from transformers import Trainer, TrainingArguments

# Prepare your data
class CustomDataset(Dataset):
    def __init__(self, texts, labels, tokenizer, max_length=128):
        self.encodings = tokenizer(texts, truncation=True, padding=True, 
                                   max_length=max_length, return_tensors='pt')
        self.labels = labels
    
    def __getitem__(self, idx):
        return {key: val[idx] for key, val in self.encodings.items(), 
                'labels': torch.tensor(self.labels[idx])}
    
    def __len__(self):
        return len(self.labels)

# Create dataset
dataset = CustomDataset(texts, labels, tokenizer)

# Training arguments
training_args = TrainingArguments(
    output_dir='./results',
    num_train_epochs=3,
    per_device_train_batch_size=16,
    per_device_eval_batch_size=16,
    warmup_steps=500,
    weight_decay=0.01,
    logging_dir='./logs',
)

# Train
trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=dataset,
)

trainer.train()
```

### Model Evaluation

```python
from sklearn.metrics import classification_report, confusion_matrix
import numpy as np

# Get predictions on test set
all_preds = []
all_labels = []

with torch.no_grad():
    for batch in test_dataloader:
        outputs = model(**batch)
        preds = torch.argmax(outputs.logits, dim=1)
        all_preds.extend(preds.cpu().numpy())
        all_labels.extend(batch['labels'].cpu().numpy())

# Generate report
print(classification_report(all_labels, all_preds, target_names=list(labels.values())))

# Confusion matrix
cm = confusion_matrix(all_labels, all_preds)
print("\nConfusion Matrix:")
print(cm)
```

### Ensemble Predictions

```python
models_to_ensemble = [
    'models/ihc_3way_bert',
    'models/ihc_3way_distilbert',
]

text = "Test message"
predictions = []

for model_path in models_to_ensemble:
    model = BertForSequenceClassification.from_pretrained(model_path)
    inputs = tokenizer(text, return_tensors='pt', truncation=True, max_length=128)
    with torch.no_grad():
        outputs = model(**inputs)
        pred = torch.argmax(outputs.logits, dim=1).item()
    predictions.append(pred)

# Majority voting
from collections import Counter
ensemble_pred = Counter(predictions).most_common(1)[0][0]
print(f"Ensemble prediction: {labels[ensemble_pred]}")
```

## Troubleshooting

### Predictions are not reliable

1. Check if you're using the correct model for your use case
2. Verify input preprocessing (tokenization, length)
3. Consider using ensemble methods
4. Check emoji enrichment is working correctly

### Model is too slow

1. Use DistilBERT instead of BERT
2. Reduce max_length from 128 to 64
3. Use GPU if available
4. Enable batch processing

### High memory usage

1. Reduce batch size
2. Use gradient checkpointing
3. Use CPU inference (slower but uses less memory)
4. Use quantization: `quantize_model(model)`

## Next Steps

- Check [MODELS.md](MODELS.md) for model details
- Read [DATASETS.md](DATASETS.md) for data information
- Review [ARCHITECTURE.md](ARCHITECTURE.md) for technical details
