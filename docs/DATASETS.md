# Datasets Documentation

## Overview

HateFusion uses multiple carefully curated datasets for training and evaluation. This document provides detailed information about each dataset.

## Toxigen Dataset

### Description
Large-scale dataset of toxic text generated and annotated for toxicity levels.

### Size & Format
- **Size**: 165+ MB
- **Rows**: ~100,000+ examples
- **Format**: CSV
- **File**: `data/toxigen.csv`

### Columns
- `text`: Input text
- `toxicity_score`: Toxicity level (typically 0-1 or discrete labels)
- Additional metadata fields

### Characteristics
- General domain (diverse topics)
- Binary or multi-class toxicity labels
- Relatively balanced class distribution
- Good baseline for general toxicity detection

### Statistics
```
Clean messages:        X%
Toxic messages:        Y%
Average length:        Z words
```

## Implicit Hate Corpus (IHC)

### Description
Three-stage annotation framework for detecting subtle, implicit hate speech.

### Stages

#### Stage 1: Implicit Hate Detection
- **File**: `data/implicit_hate_v1_stg1.csv` (IDs), `implicit_hate_v1_stg1_posts.csv` (posts)
- **Size**: 0.7 MB (IDs), 2.2 MB (posts)
- **Task**: Binary classification - identify if text contains implicit hate

#### Stage 2: Hate Rationale Extraction
- **File**: `data/implicit_hate_v1_stg2.csv` (IDs), `implicit_hate_v1_stg2_posts.csv` (posts)
- **Size**: 0.2 MB (IDs), 0.7 MB (posts)
- **Task**: Extract which part of the text indicates implicit hate

#### Stage 3: Target Community Identification
- **File**: `data/implicit_hate_v1_stg3.csv` (IDs), `implicit_hate_v1_stg3_posts.csv` (posts)
- **Size**: 0.4 MB (IDs), 0.9 MB (posts)
- **Task**: Identify which community/demographic is targeted

#### Stage Additional: Self-Annotated Posts (SAP)
- **File**: `data/implicit_hate_v1_SAP_posts.csv`
- **Size**: 0.1 MB
- **Purpose**: Validation set

### Data Format

Each stage has two files:
- **IDs file**: Post IDs with labels
- **Posts file**: Actual post text with metadata

### Sample Fields

```python
{
    'post_id': 12345,
    'post': 'Example post text here',
    'implicit_hate_label': 1,  # 0 = not implicit hate, 1 = implicit hate
    'rationale': 'Offensive phrase here',
    'target_community': 'Arab people',
    'annotator_id': 'A001',
    'confidence': 0.95
}
```

### Characteristics
- Focuses on **subtle, indirect** hate speech
- Includes rationales and target identification
- Multi-stage expert annotation
- Challenging for models (requires understanding context)

### Examples

**Explicit Hate**: "I hate [group]" ❌
**Implicit Hate**: "People like [group] shouldn't reproduce" ✓

## Gab Hate Corpus

### Description
Real-world hate speech data from the Gab platform with expert annotations.

### Size & Format
- **Size**: 4.5 MB
- **Rows**: ~25,000+ examples
- **Format**: CSV (unique annotations)
- **File**: `data/GabHateCorpus_annotations_unique.csv`

### Columns
- `post_id`: Unique post identifier
- `post`: The text of the post
- `hate_speech`: Binary label (0 = not hate, 1 = hate)
- Additional fields with annotator information

### Characteristics
- Real platform data (not synthetic)
- Multiple annotators per post
- Well-balanced classes
- Platform-specific language patterns
- Original annotated file: `GabHateCorpus_annotations.tsv` (14 MB)

### Data Quality
- Inter-annotator agreement >0.8
- Expert validation
- Hate speech includes various forms:
  - Targeted harassment
  - Dehumanization
  - Incitement to violence

## Emoji Datasets

### Layer 1: Manual Hate Emoji Dictionary
- **File**: `data/emoji_data.JSON`
- **Size**: 53 KB
- **Emojis**: 294 manually curated
- **Purpose**: Domain-specific hate emoji detection

#### Structure
```json
{
    "🔪": {
        "meaning": "knife_weapon_violence",
        "hate_score": 0.96,
        "category": "threatening",
        "description": "Often used to threaten violence"
    },
    "🐒": {
        "meaning": "monkey_racial_insult",
        "hate_score": 0.94,
        "category": "dehumanizing",
        "description": "Used as racist insult comparing people to animals"
    }
}
```

### Layer 2: Emoji Sentiment Data
- **File**: `data/Emoji_Sentiment_Data_v1.0.csv`
- **Size**: 78 KB
- **Emojis**: 969 emojis with sentiment scores
- **Columns**:
  - `Emoji`: The emoji character
  - `Unicode name`: Official emoji name
  - `Positive`: Number of positive votes
  - `Negative`: Number of negative votes
  - `Neutral`: Number of neutral votes
  - `Position`: Sentiment position score (-1 to 1)
  - `Occurrences`: Total occurrences in corpus

#### Hate Score Calculation
```
hate_score = max(0, neg_ratio - 0.3) if neg_ratio > 0.4 else 0
where: neg_ratio = negative_votes / total_votes
```

### Layer 3: General Emoji Library
- **Source**: emoji library (5,225+ emojis)
- **Purpose**: Fallback for unmapped emojis
- **Coverage**: All standard Unicode emojis

## Additional Annotations

### Annotator IAT and Attitudes
- **File**: `data/AnnotatorIAT_and_Attitudes.csv`
- **Size**: 850 bytes
- **Purpose**: Metadata about annotators' implicit attitudes

## Data Loading Examples

### Load Toxigen
```python
import pandas as pd

df_toxigen = pd.read_csv('data/toxigen.csv')
print(f"Toxigen shape: {df_toxigen.shape}")
print(df_toxigen.head())
```

### Load IHC Stage 1
```python
df_posts = pd.read_csv('data/implicit_hate_v1_stg1_posts.csv')
df_labels = pd.read_csv('data/implicit_hate_v1_stg1.csv')

# Merge
df_ihc = pd.merge(df_posts, df_labels, on='post_id')
print(f"IHC Stage 1 shape: {df_ihc.shape}")
```

### Load Emoji Dictionary
```python
import json

with open('data/emoji_data.JSON', 'r', encoding='utf-8') as f:
    emoji_dict = json.load(f)

print(f"Loaded {len(emoji_dict)} hate emojis")
```

## Data Preprocessing

### Text Cleaning
```python
import re

def clean_text(text):
    text = text.lower()
    text = re.sub(r'http\S+|www\S+', '', text)  # Remove URLs
    text = re.sub(r'@\w+', '@user', text)  # Normalize mentions
    text = re.sub(r'#\w+', '#hashtag', text)  # Normalize hashtags
    text = re.sub(r'\s+', ' ', text)  # Normalize whitespace
    return text.strip()
```

### Train-Test Split
```python
from sklearn.model_selection import train_test_split

train, test = train_test_split(df, test_size=0.2, random_state=42, stratify=df['label'])
print(f"Train: {len(train)}, Test: {len(test)}")
```

### Class Balancing
```python
from sklearn.utils.class_weight import compute_class_weight

weights = compute_class_weight('balanced', classes=np.unique(labels), y=labels)
class_weights = {i: w for i, w in enumerate(weights)}
```

## Statistics Summary

| Dataset | Size | Rows | Classes | Type |
|---------|------|------|---------|------|
| Toxigen | 165 MB | 100K+ | 2-3 | General Toxicity |
| IHC Stg1 | 2.9 MB | 2000+ | 2 | Implicit Hate |
| IHC Stg2 | 0.9 MB | ~600 | 2 | Rationale |
| IHC Stg3 | 1.3 MB | ~600 | Multi | Target |
| Gab Hate | 4.5 MB | 25K+ | 2 | Real Platform |
| Emojis | 0.13 MB | 1263 | Features | Emoji Only |

## Downloading Datasets

### Toxigen
[Provide download link or instructions]

### Implicit Hate Corpus
[Provide download link or instructions]

### Gab Hate Corpus
[Provide download link or instructions]

## Citation

If you use these datasets in research, please cite the original sources:

```bibtex
@dataset{toxigen,
  title={Toxigen: A Large-Scale Machine-Generated Dataset for Adversarial and Implicit Hate Speech Detection},
  year={2024}
}

@dataset{implicit_hate,
  title={Implicit Hate Corpus: An Annotated Dataset of Implicit Hate Speech},
  year={2021}
}

@dataset{gab_hate,
  title={Gab Hate Corpus: A Hate Speech Dataset},
  year={2020}
}
```

## Next Steps

- See [USAGE.md](USAGE.md) for data loading examples
- Check [MODELS.md](MODELS.md) for model training details
- Review [ARCHITECTURE.md](ARCHITECTURE.md) for pipeline overview
