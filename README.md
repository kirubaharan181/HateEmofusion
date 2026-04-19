# 🔥 HateFusion: Advanced Hate Speech & Implicit Hate Detection

<div align="center">

![Python](https://img.shields.io/badge/Python-3.8%2B-blue?style=for-the-badge&logo=python)
![PyTorch](https://img.shields.io/badge/PyTorch-2.0%2B-red?style=for-the-badge&logo=pytorch)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Production%20Ready-success?style=for-the-badge)

**A state-of-the-art machine learning framework for detecting hate speech with fine-grained 7-way categorization and emoji-aware contextual analysis**

[🚀 Quick Start](#-quick-start) • [📊 Features](#-key-features) • [🎯 7-Way Classification](#-7-way-classification-taxonomy) • [📈 Performance](#-performance-metrics) • [📚 Docs](#-documentation)

</div>

---

## 📋 Overview

**HateFusion** is a cutting-edge deep learning framework that goes beyond simple binary hate speech detection. It provides:

- **Fine-grained 7-way classification** of hate speech types
- **Implicit hate detection** with multi-stage annotations and rationales
- **Emoji-aware feature extraction** using a novel 3-layer semantic enrichment system
- **Full explainability** via LIME, SHAP, and BertViz attention visualization
- **Multi-dataset training** combining Toxigen, Implicit Hate Corpus (IHC), and Gab Hate Corpus
- **Production-ready models** with 10 pre-trained variants

---

## 🎯 7-Way Classification Taxonomy

The core innovation: **Fine-grained categorization of hate speech into 7 distinct types**

| # | Category | Description | Example | Samples | Prevalence |
|---|----------|-------------|---------|---------|-----------|
| 0 | **Clean** | No hate speech | "I love this movie" | - | - |
| 1 | **White Grievance** | Direct hostility/resentment toward group | "They're replacing us" | 1,538 | 24% |
| 2 | **Incitement** | Calls for violence, harm, or action | "We should eliminate them" | 1,269 | 20% |
| 3 | **Stereotypical** | Negative stereotypes/generalizations | "All X are criminals" | 1,133 | 18% |
| 4 | **Inferiority** | Dehumanization or claims of inferiority | "They're animals" | 863 | 14% |
| 5 | **Irony/Sarcasm** | Hateful intent via sarcasm/irony ⚠️ | "Yeah sure, very intelligent" | 797 | 13% |
| 6 | **Self-Directed** | Within-group criticism/self-hate | "My people are lazy" | 666 | 11% |
| 7 | **Reclamation** | Reclaimed terminology in pride context | "We are X and proud" | 80 | 1% |

**Challenge Levels:**
- 🟢 Easy: Categories 1-4 (70-80% accuracy)
- 🟡 Medium: Category 6 (65% accuracy)
- 🔴 Hard: Categories 5, 7 (55-60% accuracy) - Requires contextual understanding

---

## 🎯 Key Features

### 🤖 Advanced Model Architecture
- **Multi-Model Support**: BERT and DistilBERT implementations for both 3-way and 7-way hate speech classification
- **Flexible Classification**: 
  - **3-way**: Clean, Implicit Hate, Explicit Hate
  - **7-way**: Fine-grained hate categories (White Grievance, Incitement, Stereotypical, Inferiority, Irony/Sarcasm, Self-Directed, Reclamation)
- **Optimized Training**: Gradient accumulation, mixed precision (FP16), early stopping, and class weighting
- **Ensemble Ready**: Pre-trained checkpoints for model averaging and voting

### 🎨 Emoji Intelligence Layer
- **3-Layer Emoji Processing**:
  - Layer 1: 294+ manually curated hate emojis with sentiment scores
  - Layer 2: 969 emojis with sentiment ranking from corpus analysis
  - Layer 3: 5,225+ general emoji coverage via emoji library
- **Smart Emoji Enrichment**: Replaces emojis with semantic tokens (e.g., 🔪 → [knife_weapon_violence])
- **Emoji Feature Extraction**: 9-dimensional feature vectors capturing emoji-based hate indicators
- **Emoji Reports**: Detailed analysis of emoji usage patterns and hate scores

### 📊 Multi-Dataset Training

| Dataset | Size | Samples | Type | Characteristics |
|---------|------|---------|------|-----------------|
| **Toxigen** | 165 MB | 238,310 | Binary (Toxic/Non-toxic) | Largest, balanced, synthetic |
| **IHC 3-Way** | 2.2 MB | 21,260 | 3-class | Clean/Implicit/Explicit |
| **IHC 7-Way** | 0.7 MB | 6,311 | 7-class | Fine-grained categorization |
| **Gab Hate Corpus** | 4.5 MB | 26,157 | Binary/3-way | Real-world platform data (3.2% emoji usage) |
| **Total** | 172.4 MB | 313,298 | Mixed | Multi-domain robustness |

**Implicit Hate Corpus (IHC) Multi-Stage Annotations:**
- **Stage 1**: Binary classification (Not Hate / Implicit Hate / Explicit Hate)
- **Stage 2**: 7-way categorization with rationales
- **Stage 3**: Target community identification

### 🔍 Explainability & Interpretability
- **LIME Integration**: Local Interpretable Model-agnostic Explanations for prediction transparency
- **SHAP Values**: Feature importance and model behavior analysis
- **BertViz**: Attention head visualization to understand model focus areas
- **Confidence Scores**: Softmax probabilities for all classes
- **Word Importance Analysis**: Word-level contributions to predictions

### 🎲 Advanced Training Techniques
- **Stratified Train-Test Split**: Ensures balanced class distribution
- **Class Weighting**: Handles imbalanced datasets automatically
- **Learning Rate Scheduling**: Warmup ratio of 0.1 for stable training
- **Early Stopping**: Prevents overfitting with 3-epoch patience
- **Seed Control**: Reproducible results with multiple seed runs
- **Gradient Accumulation**: Effective batch size of 32 (actual: 16, steps: 2)
- **Mixed Precision Training**: FP16 for faster training with minimal accuracy loss

### 🎪 Production Ready
- **Gradio Integration**: Interactive web interface for easy predictions
- **Flask API**: RESTful API for integration into production systems
- **Batch Processing**: Process multiple texts efficiently
- **Real-time Predictions**: Get instant hate speech classification
- **Inference Optimizations**: ~50ms per sample (GPU), ~400ms (CPU)

## 📁 Project Structure

```
HateFusion/
├── data/
│   ├── toxigen.csv (165 MB) ........... Toxicity classification dataset
│   ├── implicit_hate_v1_stg1.csv ..... IHC Stage 1: Binary annotations
│   ├── implicit_hate_v1_stg2.csv ..... IHC Stage 2: 7-way with rationales
│   ├── implicit_hate_v1_stg3.csv ..... IHC Stage 3: Target communities
│   ├── GabHateCorpus_*.csv ........... Real-world platform data
│   └── Emoji_Sentiment_Data_v1.0.csv . Emoji sentiment rankings (969 emojis)
│
├── models/
│   ├── ihc_3way_bert/ ................ 3-way BERT classifier
│   ├── ihc_3way_distilbert/ .......... 3-way DistilBERT classifier
│   ├── ihc_7way_bert/ ................ 7-way BERT classifier
│   ├── ihc_7way_distilbert/ .......... 7-way DistilBERT classifier
│   ├── toxigen_binary_bert/ .......... Toxigen binary BERT
│   ├── toxigen_binary_distilbert/ .... Toxigen binary DistilBERT
│   ├── gab_3way_bert/ ................ Gab 3-way BERT
│   ├── gab_3way_distilbert/ .......... Gab 3-way DistilBERT
│   └── [2 more variants]
│
├── results/
│   ├── all_results_summary.csv ........ Performance across all models
│   └── per_class_metrics.csv .......... Fine-grained per-class analysis
│
├── docs/
│   ├── INSTALLATION.md ............... Detailed setup instructions
│   ├── USAGE.md ...................... API documentation
│   ├── EMOJI_SYSTEM.md ............... Emoji processing details
│   ├── DATASETS.md ................... Dataset documentation
│   ├── ARCHITECTURE.md ............... Technical architecture
│   └── TROUBLESHOOTING.md ............ Common issues & solutions
│
├── 📓 HateFusion_Complete_21_Cells.ipynb .. End-to-end pipeline (Main entry point)
├── requirements.txt .................. Python dependencies
├── PROJECT_STRUCTURE.md .............. Project overview
├── CHANGELOG.md ...................... Version history
├── CONTRIBUTING.md ................... Contribution guidelines
└── LICENSE ........................... MIT License
```

## 🚀 Quick Start

### Prerequisites
- Python 3.8+
- CUDA 11.8+ (optional, for GPU acceleration)
- 8GB RAM minimum (16GB+ recommended)
- Storage: 30GB+ for datasets and models

### Installation

```bash
# Clone repository
git clone https://github.com/kirubaharan181/HateEmofusion.git
cd HateEmofusion

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### Basic Usage

```python
from transformers import AutoTokenizer, AutoModelForSequenceClassification
import torch

# Load pre-trained model
model_name = "ihc_7way_bert"
tokenizer = AutoTokenizer.from_pretrained(f"models/{model_name}")
model = AutoModelForSequenceClassification.from_pretrained(f"models/{model_name}")

# Inference
text = "I hate this community"
inputs = tokenizer(text, return_tensors="pt", max_length=128, truncation=True)

with torch.no_grad():
    outputs = model(**inputs)
    predictions = torch.softmax(outputs.logits, dim=-1)
    
class_labels = ["Clean", "White Grievance", "Incitement", "Stereotypical", 
                "Inferiority", "Irony/Sarcasm", "Self-Directed", "Reclamation"]
predicted_class = class_labels[predictions.argmax(dim=1).item()]
confidence = predictions.max().item()

print(f"Prediction: {predicted_class} ({confidence:.2%})")
```

### Jupyter Notebook (Recommended)

```bash
# Launch the complete 21-cell pipeline
jupyter notebook "HateFusion_Complete_21_Cells (2) - Copy.ipynb"
```

The notebook includes:
1. Data loading and exploration
2. Emoji processing pipeline
3. Model training and evaluation
4. Performance visualization
5. Explainability demonstrations
6. Real-world inference examples

## 📈 Performance Metrics

### Overall Results (Weighted Avg F1 / Macro Avg F1 / Accuracy)

| Task | BERT | DistilBERT | Speed Trade-off |
|------|------|-----------|-----------------|
| **3-Way Classification** | 0.7322 / 0.6199 / 0.7273 | 0.7293 / 0.6131 / 0.7266 | ✓ DistilBERT: 2-3x faster |
| **Binary Classification** | 0.7969 / 0.7852 / 0.7966 | 0.7929 / 0.7793 / 0.7943 | ✓ Practical for production |
| **7-Way Classification** | 0.6269 / 0.5654 / 0.6298 | 0.6083 / 0.5546 / 0.6120 | ⚠️ Fine-grained complexity |
| **Toxigen Binary** | 0.8125 / 0.8125 / 0.8125 | 0.8027 / 0.8027 / 0.8027 | ✓ Excellent on synthetic data |
| **Gab 3-Way** | 0.7873 / 0.4856 / 0.7551 | 0.7752 / 0.4728 / 0.7371 | ⚠️ Real-world challenges |

### Detailed Analysis

**7-Way Classification (Most Challenging)**
- Accuracy: 62.98% (BERT) vs 61.20% (DistilBERT)
- Macro F1: 56.54% (BERT) vs 55.46% (DistilBERT)
- Per-class variation: 40% (Reclamation) to 78% (White Grievance)

**Per-Class Performance (7-Way, BERT)**
```
White Grievance  ████████░ 78% (Easiest - 1,538 samples)
Incitement       ███████░░ 71%
Stereotypical    ███████░░ 70%
Inferiority      ██████░░░ 68%
Self-Directed    █████░░░░ 62%
Irony/Sarcasm    █████░░░░ 58% (Hardest - requires context)
Reclamation      ████░░░░░ 40% (Rarest - only 80 samples)
```

**Key Insights:**
1. ✓ Binary classification achieves 79-81% accuracy (production ready)
2. ⚠️ 7-way classification is 62% accurate (fine-grained categorization is challenging)
3. 📉 Macro F1 gap shows significant class imbalance (57% vs 63%)
4. 🎯 Irony/Sarcasm and Reclamation need specialized training
5. 🌍 Real-world data is harder than synthetic data (75% vs 81%)

## 🎨 Emoji Processing System (3-Layer Innovation)

```
Layer 1 (294 emojis): Manual curation of hate-related emojis
   ↓ (enriched with)
Layer 2 (969 emojis): Sentiment rankings and polarity scores
   ↓ (extended with)
Layer 3 (5,225+ emojis): Comprehensive emoji library
────────────────────────────────────────
Total: 6,488+ unique emoji mappings with priority lookup
```

**Emoji Enrichment Features:**
- Semantic token replacement (🔪 → `[knife_weapon_violence]`)
- Sentiment scoring (-1 to +1)
- Threat/dehumanization flags
- 9-dimensional feature vector

**Emoji Statistics in Datasets:**
| Dataset | Samples | Texts w/ Emojis | % | Hate Emojis |
|---------|---------|-----------------|---|------------|
| IHC | 21,260 | 3 | 0.01% | Minimal |
| Toxigen | 238,310 | 152 | 0.06% | Low usage |
| **Gab Hate Corpus** | **26,157** | **841** | **3.2%** | **1,134** |

**Example Processing:**
```
Input:  "You people are 🐒🐒 go back 🔪"
Output: "You people are [monkey_racial_insult] [monkey_racial_insult] go back [knife_weapon_violence]"
Status: 3 emojis found (3 hate), max_score=0.96 ⚠️ HIGH RISK

Input:  "Thank you! 😊❤️👍"
Output: "Thank you! [smiling_face_with_smiling_eyes] [heavy_black_heart] [thumbs_up_approval]"
Status: 3 emojis found (1 hate), max_score=0.10 ✅ SAFE
```

## 🔬 Advanced Features

### Explainability Methods
- **LIME**: Word-level feature importance
- **SHAP**: Shapley value-based explanations  
- **BertViz**: Attention weight visualization
- **Confidence Scores**: Softmax probabilities for all classes

### Code Examples

**Example 1: Simple Classification**
```python
from transformers import AutoTokenizer, AutoModelForSequenceClassification
import torch

tokenizer = AutoTokenizer.from_pretrained("models/ihc_7way_bert")
model = AutoModelForSequenceClassification.from_pretrained("models/ihc_7way_bert")

text = "They're replacing us"
inputs = tokenizer(text, return_tensors="pt")
outputs = model(**inputs)
prediction = outputs.logits.argmax(dim=1).item()

print(f"Class: {prediction}")  # 1 = White Grievance
```

**Example 2: Batch Processing**
```python
texts = ["This is great!", "Those people are animals", "We should eliminate them"]
encoded = tokenizer(texts, return_tensors="pt", padding=True, truncation=True)
outputs = model(**encoded)
predictions = outputs.logits.argmax(dim=1)
```

**Example 3: With Confidence Scores**
```python
outputs = model(**inputs)
logits = outputs.logits
probabilities = torch.softmax(logits, dim=1)
confidence = probabilities.max().item()

print(f"Confidence: {confidence:.2%}")
```

### Training Configuration
```python
CONFIG = {
    'learning_rate': 1e-5,
    'actual_batch_size': 16,
    'gradient_accumulation_steps': 2,
    'effective_batch_size': 32,
    'epochs': 6-16,           # 6 for verify, 16 for full
    'max_length': 128,
    'fp16': True,             # Mixed precision training
    'warmup_ratio': 0.1,
    'weight_decay': 0.01,
    'early_stopping_patience': 3,
}
```

## 🛠️ Configuration & Model Variants

### 10 Pre-trained Model Variants

All models available in `models/` directory:

| Model | Type | Architecture | Use Case | Speed | Accuracy |
|-------|------|--------------|----------|-------|----------|
| `ihc_3way_bert` | 3-way | BERT | Implicit hate detection | Slower | Higher |
| `ihc_3way_distilbert` | 3-way | DistilBERT | Fast implicit detection | 2-3x faster | Similar |
| `ihc_7way_bert` | 7-way | BERT | Fine-grained analysis | Slower | Higher |
| `ihc_7way_distilbert` | 7-way | DistilBERT | Fast fine-grained | 2-3x faster | Similar |
| `toxigen_binary_bert` | Binary | BERT | Toxicity detection | Slower | Higher |
| `toxigen_binary_distilbert` | Binary | DistilBERT | Fast toxicity | 2-3x faster | Similar |
| `gab_3way_bert` | 3-way | BERT | Real-world detection | Slower | Higher |
| `gab_3way_distilbert` | 3-way | DistilBERT | Fast real-world | 2-3x faster | Similar |
| `ihc_binary_bert` | Binary | BERT | Hate vs Non-hate | Slower | Higher |
| `ihc_binary_distilbert` | Binary | DistilBERT | Fast binary | 2-3x faster | Similar |

### Environment Variables
```bash
export TOKENIZERS_PARALLELISM=false
export CUDA_VISIBLE_DEVICES=0  # Use GPU 0
```

### Verify vs Full Mode
- **Verify Mode**: 1 seed, 6 epochs, 20K samples - For testing (5 min)
- **Full Mode**: 5 seeds, 16 epochs, full data - For production (8-12 hours)

## 📚 Dataset Documentation

### Implicit Hate Corpus (IHC) - Multi-Stage Annotations

**Stage 1 - Binary Classification:**
```
Not Hate:        13,291 (63%)
Implicit Hate:    7,100 (34%)
Explicit Hate:    1,089 (3%)
─────────────────────────
Total:           21,480 samples
```

**Stage 2 - 7-Way Classification (Implicit + Explicit):**
```
White Grievance:   1,538 (24%)
Incitement:        1,269 (20%)
Stereotypical:     1,133 (18%)
Inferiority:         863 (14%)
Irony/Sarcasm:       797 (13%)
Self-Directed:       666 (11%)
Reclamation:          80 (1%)
─────────────────────────
Total:             6,311 samples
```

**Stage 3 - Target Communities:**
- Fine-grained annotations of targeted groups and attributes

### Toxigen Dataset
- **Size**: 165+ MB
- **Samples**: 238,310
- **Format**: CSV with text and toxicity labels
- **Characteristics**: Large-scale, balanced, synthetic

### Gab Hate Corpus
- **Size**: 4.5 MB
- **Samples**: 26,157
- **Format**: Annotated hate speech from Gab platform
- **Characteristics**: Real-world data, 3.2% emoji usage, 1,134 hate emojis

## 🎓 Research & Citation

This project is inspired by recent work on:
- Implicit Hate Speech Detection
- Multi-task Learning for NLP
- Explainable AI for Text Classification
- Multimodal Hate Speech (Text + Emoji)

### Citation
```bibtex
@software{hatefusion2024,
  author = {Kirubaharan},
  title = {HateFusion: Advanced Hate Speech Detection with Fine-grained Classification},
  year = {2024},
  url = {https://github.com/kirubaharan181/HateEmofusion}
}
```

## 📚 Documentation

Complete documentation available in `docs/`:

1. **[INSTALLATION.md](docs/INSTALLATION.md)** - Environment setup, dependency management
2. **[USAGE.md](docs/USAGE.md)** - API reference, code examples
3. **[EMOJI_SYSTEM.md](docs/EMOJI_SYSTEM.md)** - 3-layer emoji processing deep dive
4. **[DATASETS.md](docs/DATASETS.md)** - Dataset descriptions and statistics
5. **[ARCHITECTURE.md](docs/ARCHITECTURE.md)** - Model architecture and training pipeline
6. **[TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)** - Common issues and solutions

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Bug reports and feature requests
- Pull request process
- Code style and standards
- Testing requirements

Areas for improvement:
- [ ] Additional emoji datasets
- [ ] Support for multilingual hate speech
- [ ] Real-time API deployment (Docker)
- [ ] Mobile app integration
- [ ] Interactive web dashboard
- [ ] Performance optimization
- [ ] Additional explainability techniques

## 📞 Support & Contact

- **Documentation**: Check the `docs/` directory
- **Issues**: Report bugs on [GitHub Issues](https://github.com/kirubaharan181/HateEmofusion/issues)
- **Discussions**: Join our community discussions
- **Email**: kirubaharan181@gmail.com

## 📝 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## ⚠️ Ethical Considerations

This project is designed to **combat hate speech**, not facilitate it.

**Responsible Use:**
- Use models to detect and remove harmful content
- Do not use to generate synthetic hate speech
- Respect privacy and consent when processing data
- Consider context and cultural nuances
- Report biases and limitations found

**Limitations:**
- Models may have biases from training data
- Context-dependent accuracy (sarcasm, reclamation)
- Performance varies across dialects and languages
- No single model is perfect - always validate predictions

## 🌟 Key Achievements

✨ **HateFusion Highlights:**
- 🥇 **7-way fine-grained hate speech classification** (industry-first approach)
- 🔄 **313,298 multi-dataset samples** for robust training
- 🎨 **Novel 3-layer emoji processing** with semantic enrichment
- 📊 **6,488+ emoji mappings** with priority lookup
- 🧠 **10 pre-trained model variants** for different use cases
- 🔍 **Full explainability suite** (LIME, SHAP, BertViz)
- ⚡ **Production-optimized** with FP16, gradient accumulation, early stopping
- 📈 **62-81% accuracy** across tasks (BERT models)
- 🌍 **Multi-domain robustness** (synthetic + real-world data)

## 🙏 Acknowledgments

This project builds upon:
- **Toxigen** dataset by Microsoft Research
- **Implicit Hate Corpus (IHC)** research
- **Gab Hate Corpus** by Emmery et al.
- **Hugging Face Transformers** library
- **LIME & SHAP** explainability frameworks

---

<div align="center">

**Built with ❤️ for detecting hate speech and promoting online safety**

⭐ Star this repository if you find it useful!

[🔝 Back to Top](#-hatefusion-advanced-hate-speech--implicit-hate-detection)

</div>
