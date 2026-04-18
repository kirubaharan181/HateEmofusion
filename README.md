# 🔥 HateFusion: Advanced Hate Speech Detection with Emoji-Aware Feature Extraction

[![Python 3.9+](https://img.shields.io/badge/Python-3.9%2B-blue)](https://www.python.org/downloads/)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.0%2B-ee4c2c)](https://pytorch.org/)
[![Transformers](https://img.shields.io/badge/Transformers-4.0%2B-yellow)](https://huggingface.co/transformers/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

> **HateFusion** is a cutting-edge machine learning project that combines state-of-the-art NLP models with novel emoji-aware feature extraction to detect hate speech and implicit hate in online text. The project uses multi-dataset training and explainability techniques to provide transparent, interpretable predictions.

## 🎯 Key Features

### 🤖 Advanced Model Architecture
- **Multi-Model Support**: BERT and DistilBERT implementations for both 3-way and 7-way hate speech classification
- **Flexible Classification**: 
  - **3-way**: Clean, Implicit Hate, Explicit Hate
  - **7-way**: Fine-grained hate categories (Animosity, Dehumanization, Threatening, etc.)
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
Trained and evaluated on multiple diverse datasets:
- **Toxigen**: 165+ MB dataset with toxicity annotations
- **Implicit Hate Corpus (IHC)**: Multi-stage annotations for implicit hate detection
  - IHC Stage 1: Implicit hate identification
  - IHC Stage 2: Hate rationale extraction
  - IHC Stage 3: Targeted community identification
- **Gab Hate Corpus**: 4.5 MB of curated hate speech data
- **Cross-dataset evaluation** for robustness assessment

### 🔍 Explainability & Interpretability
- **LIME Integration**: Local Interpretable Model-agnostic Explanations for prediction transparency
- **SHAP Values**: Feature importance and model behavior analysis
- **BertViz**: Attention head visualization to understand model focus areas
- **Word Cloud Visualization**: Visual representation of important terms by hate category
- **Confusion Matrix Analysis**: Comprehensive classification performance breakdown

### 🎲 Advanced Training Techniques
- **Stratified Train-Test Split**: Ensures balanced class distribution
- **Class Weighting**: Handles imbalanced datasets automatically
- **Learning Rate Scheduling**: Warmup ratio of 0.1 for stable training
- **Early Stopping**: Prevents overfitting with 3-epoch patience
- **Seed Control**: Reproducible results with multiple seed runs
- **Gradient Accumulation**: Effective batch size of 32 (actual: 16, steps: 2)

### 🎪 User Interfaces
- **Gradio Integration**: Interactive web interface for easy predictions
- **Flask API**: RESTful API for integration into production systems
- **Batch Processing**: Process multiple texts efficiently
- **Real-time Predictions**: Get instant hate speech classification and explainability

## 📁 Project Structure

```
HateFusion/
├── 📓 HateFusion_Complete_21_Cells.ipynb     # Main notebook with full pipeline
├── 📊 data/                                   # Datasets and emoji dictionaries
│   ├── toxigen.csv                           # Toxigen dataset (165 MB)
│   ├── implicit_hate_v1_stg*.csv             # Implicit Hate Corpus
│   ├── GabHateCorpus_annotations.csv         # Gab Hate Corpus
│   ├── emoji_data.JSON                       # Manually curated hate emoji dictionary
│   └── Emoji_Sentiment_Data_v1.0.csv        # Emoji sentiment rankings
├── 🤖 models/                                 # Pre-trained model checkpoints
│   ├── ihc_3way_bert/                        # BERT for 3-way classification
│   ├── ihc_3way_distilbert/                  # DistilBERT for 3-way classification
│   ├── ihc_7way_bert/                        # BERT for 7-way classification
│   └── ihc_7way_distilbert/                  # DistilBERT for 7-way classification
├── 📈 results/                                # Evaluation results and metrics
├── 📉 figures/                                # Visualizations and plots
├── 📝 logs/                                   # Training logs
├── 🔧 src/                                    # Source code (Python modules)
└── 📚 docs/                                   # Documentation

```

## 🚀 Quick Start

### Prerequisites
- Python 3.9+
- CUDA 11.8+ (optional, for GPU acceleration)
- 8GB RAM minimum (16GB+ recommended)
- Storage: 30GB+ for datasets and models

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/kirubaharan181/HateEmofusion.git
cd HateEmofusion
```

2. **Create virtual environment**
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. **Install dependencies**
```bash
pip install --upgrade pip
pip install -r requirements.txt
```

### Usage Examples

#### Option 1: Jupyter Notebook (Recommended for Exploration)
```bash
jupyter notebook HateFusion_Complete_21_Cells.ipynb
```

#### Option 2: Interactive Gradio Interface
```python
from HateFusion_Complete_21_Cells import HateFusion_App
HateFusion_App.launch()
```

#### Option 3: Flask API
```python
from flask_app import app
app.run(debug=False, host='0.0.0.0', port=5000)
```

#### Option 4: Python Code
```python
from transformers import BertForSequenceClassification, BertTokenizer
import torch

# Load model and tokenizer
model = BertForSequenceClassification.from_pretrained('models/ihc_3way_bert')
tokenizer = BertTokenizer.from_pretrained('models/ihc_3way_bert')

# Prepare input
text = "This is a test message"
inputs = tokenizer(text, return_tensors='pt', truncation=True, max_length=128)

# Get prediction
with torch.no_grad():
    outputs = model(**inputs)
    predictions = torch.argmax(outputs.logits, dim=1)
    
print(f"Prediction: {predictions.item()}")  # 0: Clean, 1: Implicit Hate, 2: Explicit Hate
```

## 📊 Model Performance

### 3-Way Classification (BERT)
| Metric | Clean | Implicit Hate | Explicit Hate | Overall |
|--------|-------|---------------|---------------|---------|
| Precision | 0.96 | 0.82 | 0.91 | 0.90 |
| Recall | 0.94 | 0.78 | 0.94 | 0.89 |
| F1-Score | 0.95 | 0.80 | 0.92 | 0.89 |

### 7-Way Classification (BERT)
Fine-grained categories with specialized detection for:
- **Animosity**: Direct hostility toward groups
- **Dehumanization**: Treating groups as less than human
- **Threatening**: Violence or harm implications
- **Self-Directed**: Intra-community criticism
- **Irony/Sarcasm**: Nuanced sarcastic hate speech
- **Reclamation**: Reclaimed group terminology
- **Other**: Contextual or borderline hate

## 🎨 Emoji Detection Examples

```
Input:  "You people are 🐒🐒 go back 🔪"
Output: "You people are [monkey_racial_insult] [monkey_racial_insult] go back [knife_weapon_violence]"
Status: 3 emojis found (3 hate), max_score=0.96 ⚠️ HIGH RISK

Input:  "Thank you! 😊❤️👍"
Output: "Thank you! [smiling_face_with_smiling_eyes] [heavy_black_heart] [thumbs_up_approval]"
Status: 3 emojis found (1 hate), max_score=0.10 ✅ SAFE

Input:  "Go back to where you came from!"
Output: "Go back to where you came from!"
Status: 0 emojis found ✅ NO EMOJIS
```

## 🔬 Advanced Features

### Explainability Analysis
- **LIME Explanations**: Word-level contributions to predictions
- **SHAP Values**: Global and local feature importance
- **Attention Visualization**: See which tokens the model focuses on
- **Confidence Scores**: Probability distributions for all classes

### Batch Processing
```python
texts = [
    "This is great!",
    "I hate this",
    "This is implicitly offensive"
]
predictions = model.predict_batch(texts, batch_size=32)
```

### Cross-Dataset Evaluation
Test model robustness across different datasets:
- Train on Toxigen, test on IHC
- Train on IHC, test on Gab
- Cross-validation across all datasets

## 📈 Training Configuration

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
    'bert_model': 'bert-base-uncased',
    'distilbert_model': 'distilbert-base-uncased',
}
```

## 🛠️ Configuration & Customization

### Environment Variables
```bash
export TOKENIZERS_PARALLELISM=false
export CUDA_VISIBLE_DEVICES=0  # Use GPU 0
```

### Verify vs Full Mode
- **Verify Mode**: 1 seed, 6 epochs, 20K samples - For testing (5 min)
- **Full Mode**: 5 seeds, 16 epochs, full data - For production (8-12 hours)

Toggle in notebook:
```python
VERIFY_MODE = True  # Set to False for full training
```

## 📚 Dataset Documentation

### Toxigen
- **Size**: 165+ MB
- **Format**: CSV with text and toxicity labels
- **Purpose**: General toxicity detection baseline

### Implicit Hate Corpus (IHC)
- **Stages**: 3 progressive annotation stages
- **Stage 1**: Binary implicit hate detection
- **Stage 2**: Hate speech rationale extraction
- **Stage 3**: Targeted community/attribute identification
- **Purpose**: Deep understanding of subtle hate speech

### Gab Hate Corpus
- **Size**: 4.5 MB
- **Format**: Annotated hate speech from Gab platform
- **Purpose**: Platform-specific hate speech patterns

## 🎓 Research & Citation

This project is inspired by recent work on:
- Implicit Hate Speech Detection
- Multi-task Learning for NLP
- Explainable AI for Text Classification
- Multimodal Hate Speech (Text + Emoji)

If you use this project in research, please cite:
```bibtex
@software{hatefusion2024,
  author = {Kirubaharan},
  title = {HateFusion: Advanced Hate Speech Detection with Emoji-Aware Feature Extraction},
  year = {2024},
  url = {https://github.com/kirubaharan181/HateEmofusion}
}
```

## 🤝 Contributing

We welcome contributions! Areas for improvement:
- [ ] Additional emoji datasets
- [ ] Support for multilingual hate speech
- [ ] Real-time API deployment (Docker)
- [ ] Mobile app integration
- [ ] Interactive web dashboard
- [ ] Performance optimization
- [ ] Additional explainability techniques

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚠️ Ethical Considerations

This project is designed to **combat hate speech**, not facilitate it. 

**Responsible Use**:
- Use models to detect and remove harmful content
- Do not use to generate synthetic hate speech
- Respect privacy and consent when processing data
- Consider context and cultural nuances
- Report biases and limitations found

**Limitations**:
- Models may have biases from training data
- Context-dependent accuracy (sarcasm, reclamation)
- Performance varies across dialects and languages
- No single model is perfect - always validate predictions

## 📞 Support & Contact

- **Issues**: Report bugs via [GitHub Issues](https://github.com/kirubaharan181/HateEmofusion/issues)
- **Discussions**: Join community discussions
- **Documentation**: See [docs/](docs/) folder

## 🌟 Acknowledgments

Special thanks to:
- The creators of the Implicit Hate Corpus for comprehensive dataset
- Toxigen dataset contributors
- Gab Hate Corpus researchers
- HuggingFace Transformers team
- All open-source contributors

---

<div align="center">

**Made with ❤️ for making the internet safer**

[Report Issue](https://github.com/kirubaharan181/HateEmofusion/issues) • 
[Suggest Feature](https://github.com/kirubaharan181/HateEmofusion/discussions) • 
[View Docs](docs/)

</div>
