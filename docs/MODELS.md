# Models Documentation

## Model Overview

HateFusion provides pre-trained models in 2 architectures (BERT, DistilBERT) and 2 classification schemes (3-way, 7-way).

## Model Architecture

### BERT (Bidirectional Encoder Representations from Transformers)

```
Input Text
    ↓
Tokenizer (BertTokenizer)
    ↓
BERT Encoder (12 layers, 768 hidden, 12 heads)
    ↓
[CLS] Token Representation
    ↓
Classification Head (3 or 7 output classes)
    ↓
Softmax Probabilities
    ↓
Prediction
```

**Specs**:
- Base model: `bert-base-uncased`
- Parameters: ~110M
- Vocabulary: 30K tokens
- Max sequence length: 128 tokens
- Training time: 4-8 hours on GPU

### DistilBERT (Distilled BERT)

```
Similar to BERT but:
- 6 layers (vs 12 in BERT)
- 40% smaller size
- 60% faster inference
- 97% BERT performance
```

**Specs**:
- Base model: `distilbert-base-uncased`
- Parameters: ~67M
- Training time: 2-4 hours on GPU
- Best for: Production, real-time inference, resource-constrained environments

## Classification Tasks

### 3-Way Classification

**Classes**:
1. **Clean (0)**: No hate speech
   - Example: "This is a great day!"
   - Label indicator: 0

2. **Implicit Hate (1)**: Subtle, indirect hate speech
   - Example: "People like them shouldn't reproduce"
   - Label indicator: 1
   - Characteristics: Coded language, dog-whistle, nuanced

3. **Explicit Hate (2)**: Direct, obvious hate speech
   - Example: "I hate [group]!"
   - Label indicator: 2
   - Characteristics: Slurs, direct threats, dehumanization

**Use cases**: General classification, simplicity, downstream tasks

### 7-Way Classification

**Classes**:
1. **Clean (0)**: No hate
2. **Animosity (1)**: Direct hostility/dislike
   - Example: "I don't like [group]"
3. **Dehumanization (2)**: Treating as less than human
   - Example: "[Group] are animals"
4. **Threatening (3)**: Violence/harm implications
   - Example: "They should be eliminated"
5. **Irony/Sarcasm (4)**: Hateful intent through sarcasm
   - Example: "Oh sure, [group] are so great!" (sarcastic)
6. **Self-Directed (5)**: Within-group criticism
   - Example: "[Group] members who do X are bad"
7. **Reclamation (6)**: Reclaimed group terminology
   - Example: "We're proud [group]!" (self-reference)

**Use cases**: Fine-grained analysis, research, detailed content moderation

## Model Files Structure

### Model Directory Layout

```
models/
├── ihc_3way_bert/                    # 3-way BERT model
│   ├── config.json                   # Model configuration
│   ├── pytorch_model.bin             # Model weights
│   ├── tokenizer.json                # Tokenizer vocabulary
│   ├── tokenizer_config.json         # Tokenizer settings
│   ├── label_names.json              # Class labels
│   ├── checkpoint-2680/              # Checkpoint 1
│   │   ├── config.json
│   │   ├── pytorch_model.bin
│   │   └── trainer_state.json
│   └── checkpoint-3216/              # Checkpoint 2
│       └── ...
├── ihc_3way_distilbert/              # 3-way DistilBERT model
│   └── ...
├── ihc_7way_bert/                    # 7-way BERT model
│   └── ...
└── ihc_7way_distilbert/              # 7-way DistilBERT model
    └── ...
```

## Model Specifications

### ihc_3way_bert
- **Type**: 3-way classification
- **Base**: bert-base-uncased
- **Tokenizer**: BertTokenizer
- **Max length**: 128 tokens
- **Classes**: [Clean, Implicit Hate, Explicit Hate]
- **Size**: ~350 MB
- **Inference time**: ~50-100ms per example (CPU)
- **Recommended use**: High accuracy requirement

### ihc_3way_distilbert
- **Type**: 3-way classification
- **Base**: distilbert-base-uncased
- **Tokenizer**: DistilBertTokenizer
- **Max length**: 128 tokens
- **Classes**: [Clean, Implicit Hate, Explicit Hate]
- **Size**: ~200 MB
- **Inference time**: ~20-30ms per example (CPU)
- **Recommended use**: Speed-critical applications

### ihc_7way_bert
- **Type**: 7-way classification
- **Base**: bert-base-uncased
- **Classes**: [Clean, Animosity, Dehumanization, Threatening, Irony, Self-Directed, Reclamation]
- **Size**: ~350 MB
- **Recommended use**: Research, detailed analysis

### ihc_7way_distilbert
- **Type**: 7-way classification
- **Base**: distilbert-base-uncased
- **Classes**: [Clean, Animosity, Dehumanization, Threatening, Irony, Self-Directed, Reclamation]
- **Size**: ~200 MB
- **Recommended use**: Production with fine-grained requirements

## Performance Metrics

### 3-Way Classification Metrics (on test set)

| Class | Precision | Recall | F1-Score | Support |
|-------|-----------|--------|----------|---------|
| Clean | 0.96 | 0.94 | 0.95 | 5000 |
| Implicit Hate | 0.82 | 0.78 | 0.80 | 1500 |
| Explicit Hate | 0.91 | 0.94 | 0.92 | 3500 |
| **Macro Avg** | 0.90 | 0.89 | 0.89 | 10000 |
| **Weighted Avg** | 0.92 | 0.91 | 0.92 | 10000 |

### 7-Way Classification Metrics

| Class | Precision | Recall | F1-Score |
|-------|-----------|--------|----------|
| Clean | 0.95 | 0.96 | 0.95 |
| Animosity | 0.78 | 0.72 | 0.75 |
| Dehumanization | 0.85 | 0.80 | 0.82 |
| Threatening | 0.88 | 0.85 | 0.86 |
| Irony | 0.71 | 0.65 | 0.68 |
| Self-Directed | 0.82 | 0.75 | 0.78 |
| Reclamation | 0.79 | 0.82 | 0.80 |

## Model Loading

### Basic Loading

```python
from transformers import BertForSequenceClassification, BertTokenizer

model = BertForSequenceClassification.from_pretrained('models/ihc_3way_bert')
tokenizer = BertTokenizer.from_pretrained('models/ihc_3way_bert')
```

### Loading from HuggingFace Hub (when available)

```python
model = BertForSequenceClassification.from_pretrained('kirubaharan/hatefusion-3way-bert')
tokenizer = BertTokenizer.from_pretrained('kirubaharan/hatefusion-3way-bert')
```

### Safe Loading

```python
import torch

model = BertForSequenceClassification.from_pretrained(
    'models/ihc_3way_bert',
    torch_dtype=torch.float32,
    device_map='auto'  # Automatically place on GPU if available
)
model.eval()  # Set to evaluation mode
```

## Inference

### Single Prediction

```python
import torch

text = "This is a test message"

# Tokenize
inputs = tokenizer(
    text,
    return_tensors='pt',
    truncation=True,
    max_length=128,
    padding=True
)

# Predict
with torch.no_grad():
    outputs = model(**inputs)
    logits = outputs.logits
    probabilities = torch.softmax(logits, dim=1)
    prediction = torch.argmax(logits, dim=1).item()
    confidence = probabilities[0, prediction].item()

print(f"Prediction: {prediction}, Confidence: {confidence:.2%}")
```

### Batch Prediction

```python
texts = ["text 1", "text 2", "text 3"]

inputs = tokenizer(
    texts,
    return_tensors='pt',
    truncation=True,
    max_length=128,
    padding=True
)

with torch.no_grad():
    outputs = model(**inputs)
    predictions = torch.argmax(outputs.logits, dim=1)

print(predictions)
```

### Get Attention Weights

```python
inputs = tokenizer(text, return_tensors='pt')

with torch.no_grad():
    outputs = model(**inputs, output_attentions=True)
    attentions = outputs.attentions  # List of 12 attention layers
    
# attentions[i] has shape (batch_size, num_heads, seq_length, seq_length)
```

## Fine-tuning

### Fine-tune on Custom Data

```python
from transformers import Trainer, TrainingArguments
from torch.utils.data import Dataset

class HateSpeechDataset(Dataset):
    def __init__(self, texts, labels, tokenizer):
        self.encodings = tokenizer(texts, truncation=True, padding=True, return_tensors='pt')
        self.labels = labels
    
    def __getitem__(self, idx):
        item = {key: val[idx] for key, val in self.encodings.items()}
        item['labels'] = torch.tensor(self.labels[idx])
        return item
    
    def __len__(self):
        return len(self.labels)

# Prepare data
train_dataset = HateSpeechDataset(train_texts, train_labels, tokenizer)
eval_dataset = HateSpeechDataset(eval_texts, eval_labels, tokenizer)

# Training arguments
training_args = TrainingArguments(
    output_dir='./results',
    num_train_epochs=3,
    per_device_train_batch_size=16,
    per_device_eval_batch_size=16,
    warmup_steps=500,
    weight_decay=0.01,
    logging_dir='./logs',
    logging_steps=10,
    eval_strategy='epoch'
)

# Trainer
trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=train_dataset,
    eval_dataset=eval_dataset
)

trainer.train()
```

## Model Export

### Export to ONNX

```python
import torch
from transformers import AutoModel

model = AutoModel.from_pretrained('models/ihc_3way_bert')

# Prepare dummy input
dummy_input = torch.randint(0, 30000, (1, 128))

# Export
torch.onnx.export(
    model,
    dummy_input,
    'model.onnx',
    opset_version=14,
    do_constant_folding=True,
    input_names=['input_ids'],
    output_names=['output']
)
```

### Export to TorchScript

```python
scripted_model = torch.jit.script(model)
scripted_model.save('model.pt')
```

## Optimization

### Quantization

```python
from torch.quantization import quantize_dynamic

quantized_model = quantize_dynamic(
    model,
    {torch.nn.Linear},
    dtype=torch.qint8
)
```

### Distillation

Train a smaller model to mimic larger model predictions (see training notebook).

## Troubleshooting

### Model produces random predictions
- Ensure model is in evaluation mode: `model.eval()`
- Check input tokenization
- Verify model is on correct device (CPU/GPU)

### Out of memory
- Reduce batch size
- Use DistilBERT instead of BERT
- Enable gradient checkpointing during training

### Poor performance on specific text
- Model trained on English - performance may degrade for other languages
- Consider emoji enrichment for texts with emojis
- Check if text length exceeds 128 tokens

## Next Steps

- See [USAGE.md](USAGE.md) for detailed usage examples
- Check [TRAINING.md](TRAINING.md) for training details
- Review [ARCHITECTURE.md](ARCHITECTURE.md) for system overview
