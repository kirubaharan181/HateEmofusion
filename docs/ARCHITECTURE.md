# System Architecture

## Overview

HateFusion follows a modular pipeline architecture for hate speech detection with integrated emoji-aware feature extraction.

```
┌─────────────────┐
│  Input Text     │
└────────┬────────┘
         │
    ┌────▼─────────────────┐
    │ Text Preprocessing   │
    │ - Normalization      │
    │ - Cleaning           │
    └────┬─────────────────┘
         │
    ┌────▼──────────────────────┐
    │ Emoji Extraction Layer     │
    │ ┌────────────────────────┐ │
    │ │ Layer 1: Hate Emojis   │ │  294 hand-curated emojis
    │ │ Layer 2: Sentiment     │ │  969 sentiment-ranked
    │ │ Layer 3: General       │ │  5225 from emoji library
    │ └────────────────────────┘ │
    └────┬───────────────────────┘
         │
    ┌────▼──────────────────────┐
    │ Emoji Enrichment          │
    │ Replace emojis with       │
    │ semantic tokens           │
    └────┬───────────────────────┘
         │
    ┌────▼──────────────────────┐
    │ Tokenization              │
    │ (BERT/DistilBERT)         │
    │ Max length: 128 tokens    │
    └────┬───────────────────────┘
         │
    ┌────▼──────────────────────┐
    │ BERT/DistilBERT Encoder   │
    │ ┌─ 12 layers (BERT)       │
    │ └─ 6 layers (DistilBERT)  │
    └────┬───────────────────────┘
         │
    ┌────▼──────────────────────┐
    │ Classification Head       │
    │ ├─ 3-way                 │
    │ └─ 7-way                 │
    └────┬───────────────────────┘
         │
    ┌────▼──────────────────────┐
    │ Output Logits            │
    └────┬───────────────────────┘
         │
    ┌────▼──────────────────────┐
    │ Softmax Probabilities    │
    │ & Predictions            │
    └────┬───────────────────────┘
         │
    ┌────▼──────────────────────┐
    │ Explainability Layer      │
    │ ├─ LIME                   │
    │ ├─ SHAP                   │
    │ ├─ Attention Viz          │
    │ └─ Feature Analysis       │
    └────┬───────────────────────┘
         │
    ┌────▼──────────────────────┐
    │ Final Predictions         │
    │ with Explanations         │
    └──────────────────────────┘
```

## Component Details

### 1. Input Processing

**Purpose**: Prepare raw text for model consumption

**Operations**:
- Trim/normalize whitespace
- Handle special characters
- Remove corrupted bytes
- Preserve case information

**Code location**: Notebook cells 1-2

### 2. Emoji Extraction (Layer 1-3)

**Purpose**: Extract and enrich emoji information

**Process**:
```
For each character in text:
  ├─ Check if character is emoji
  ├─ Layer 1: Check manual hate emoji dict (294 emojis)
  │   └─ If found: high-priority hate scores
  ├─ Layer 2: Check sentiment dict (969 emojis)
  │   └─ If found: compute hate_score from sentiment ratio
  └─ Layer 3: Check emoji library (5225 emojis)
      └─ If found: fallback mapping
```

**Output**: List of emoji objects with:
- Character
- Position in text
- Hate score
- Sentiment value
- Category
- Description

**Code location**: Notebook cell 3.5

### 3. Emoji Enrichment

**Purpose**: Add semantic context to emojis

**Transform**:
- Original: "I love this! 😊❤️"
- Enriched: "I love this! [smiling_face_with_smiling_eyes] [heavy_black_heart]"

**Benefits**:
- BERT better understands emoji meaning
- Hate emojis are now "readable" as text tokens
- Improves model accuracy

**Code location**: `emoji_enrich_text()` function

### 4. Emoji Feature Extraction

**Purpose**: Generate 9-dimensional feature vector

**Features**:
1. Total emoji count
2. Hate emoji count
3. Proportion of hate emojis
4. Mean hate score
5. Max hate score
6. Mean sentiment
7. Contains threatening category (binary)
8. Contains dehumanizing category (binary)
9. Contains death threat category (binary)

**Usage**: Combined with text features for richer representation

### 5. BERT/DistilBERT Encoder

**Architecture**:
```
Input Embeddings
    ├─ Token Embeddings (30K vocab)
    ├─ Position Embeddings (0-127)
    └─ Segment Embeddings
         │
    Transformer Layers (6 or 12)
    ├─ Multi-head Attention (12 heads)
    ├─ Feed-forward Network
    ├─ Layer Normalization
    └─ Residual Connections
         │
    [CLS] Token Representation
         │
    Classification Layer
         │
    Logits (3 or 7 outputs)
```

**Process**:
1. Text is tokenized into subword tokens
2. Special tokens: [CLS] at start, [SEP] at end
3. Each token gets embedded (768-dim for BERT, 384-dim for DistilBERT)
4. Position embeddings added
5. 12 (BERT) or 6 (DistilBERT) transformer layers process
6. [CLS] token attends to all words, captures document meaning
7. Classification head processes [CLS] representation

### 6. Classification Head

**3-Way Head**:
```
[CLS] (768-dim)
    ↓
Dropout (10%)
    ↓
Linear (768 → 256)
    ↓
ReLU Activation
    ↓
Dropout (10%)
    ↓
Linear (256 → 3)
    ↓
Softmax
    ↓
[p_clean, p_implicit, p_explicit]
```

**7-Way Head**: Same structure but outputs 7 classes

### 7. Training Pipeline

**Components**:
```
Loss Function
├─ CrossEntropyLoss (handles softmax internally)
└─ Class weighting for imbalanced data

Optimizer
├─ AdamW
├─ Learning rate: 1e-5
├─ Weight decay: 0.01
└─ Warmup: 10% of steps

Scheduler
├─ Linear warmup
└─ Linear decay

Early Stopping
├─ Monitor validation loss
├─ Patience: 3 epochs
└─ Restore best weights

Gradient Accumulation
├─ Accumulate 2 steps
├─ Effective batch: 32 (actual: 16)
└─ Better memory usage
```

**Training Loop**:
```
For each epoch:
  For each batch:
    1. Tokenize texts
    2. Forward pass through model
    3. Compute loss
    4. Backward pass (with accumulation)
    5. Update weights every 2 steps
    6. Evaluate on validation set
    7. Check early stopping condition
  Save checkpoint if improved
```

### 8. Evaluation Metrics

**Computed Metrics**:
- Accuracy
- Precision (per class)
- Recall (per class)
- F1-Score (per class)
- Confusion Matrix
- Macro-averaged F1
- Weighted-averaged F1

**Validation Process**:
```
1. Evaluate on validation set every epoch
2. Track best validation loss/F1
3. Early stop if no improvement for 3 epochs
4. Final evaluation on test set
5. Generate confusion matrix and classification report
```

### 9. Explainability Layer

**LIME (Local Interpretable Model-Agnostic Explanations)**:
```
For each prediction:
  1. Generate perturbed samples around instance
  2. Get model predictions for perturbed samples
  3. Fit linear model to approximate local behavior
  4. Extract feature weights/importance
  5. Show top words contributing to prediction
```

**SHAP (SHapley Additive exPlanations)**:
```
1. Compute Shapley values for each feature
2. Show feature importance for specific prediction
3. Visualize with force plot or summary plot
```

**Attention Visualization (BertViz)**:
```
1. Extract attention weights from BERT layers
2. Visualize which tokens attend to which
3. Show attention patterns in transformer heads
```

## Data Flow Diagram

```
Training Phase:
┌────────────────────┐
│ Raw Training Data  │
└────────┬───────────┘
         │
    ┌────▼──────────────┐
    │ Data Preparation  │
    │ - Clean           │
    │ - Split (80/20)   │
    │ - Balance classes │
    └────┬──────────────┘
         │
    ┌────▼──────────────────────┐
    │ Emoji Enrichment          │
    │ Apply all 3 layers        │
    └────┬──────────────────────┘
         │
    ┌────▼──────────────┐
    │ Model Training    │
    │ - Forward pass    │
    │ - Loss compute    │
    │ - Backprop        │
    │ - Weight update   │
    └────┬──────────────┘
         │
    ┌────▼──────────────┐
    │ Validation        │
    │ - Track metrics   │
    │ - Early stopping  │
    │ - Save best       │
    └────┬──────────────┘
         │
    ┌────▼──────────────┐
    │ Saved Model       │
    │ - Weights         │
    │ - Config          │
    │ - Tokenizer       │
    └───────────────────┘

Inference Phase:
┌────────────────────┐
│ Input Text         │
└────────┬───────────┘
         │
    ┌────▼──────────────┐
    │ Emoji Enrichment  │
    └────┬──────────────┘
         │
    ┌────▼──────────────┐
    │ Tokenization      │
    └────┬──────────────┘
         │
    ┌────▼──────────────┐
    │ Load Model        │
    │ Set eval mode     │
    └────┬──────────────┘
         │
    ┌────▼──────────────┐
    │ Forward Pass      │
    │ (no gradients)    │
    └────┬──────────────┘
         │
    ┌────▼──────────────┐
    │ Softmax           │
    │ Get probabilities │
    └────┬──────────────┘
         │
    ┌────▼──────────────┐
    │ Explanations      │
    │ LIME, SHAP, etc   │
    └────┬──────────────┘
         │
    ┌────▼──────────────┐
    │ Output            │
    │ Prediction +      │
    │ Confidence +      │
    │ Explanations      │
    └────────────────────┘
```

## Performance Characteristics

### Speed (per 100 texts, CPU)
| Model | Tokenization | Inference | Total |
|-------|--------------|-----------|-------|
| BERT | 200ms | 5000ms | 5200ms |
| DistilBERT | 200ms | 2000ms | 2200ms |

### Memory Usage
| Model | Weights | Inference |
|-------|---------|-----------|
| BERT | ~350MB | ~1.5GB |
| DistilBERT | ~200MB | ~800MB |

### Accuracy Trade-offs
```
BERT-3way:    92% accuracy, 50ms/text
DistilBERT-3way: 89% accuracy, 20ms/text

BERT-7way:    88% accuracy, 50ms/text
DistilBERT-7way: 85% accuracy, 20ms/text
```

## Scalability Considerations

### Horizontal Scaling
- Use batching to process multiple texts
- Distribute across GPUs
- Use API servers (Flask, FastAPI)

### Vertical Optimization
- Model quantization
- Mixed precision inference
- KV-cache optimization
- Attention sparsification

## Next Steps

- See [MODELS.md](MODELS.md) for model details
- Check [TRAINING.md](TRAINING.md) for training specifics
- Review [USAGE.md](USAGE.md) for practical examples
