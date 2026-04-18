# Project Structure Overview

## Directory Layout

```
HateEmofusion/
│
├── 📓 HateFusion_Complete_21_Cells.ipynb      # Main Jupyter notebook with full pipeline
│                                              # (7+ MB - comprehensive implementation)
│
├── 📄 README.md                               # Main project documentation
├── 📄 LICENSE                                 # MIT License
├── 📄 requirements.txt                        # Python dependencies
├── 📄 .gitignore                              # Git ignore file
├── 📄 CONTRIBUTING.md                         # Contribution guidelines
├── 📄 CHANGELOG.md                            # Version history
├── 📄 PROJECT_STRUCTURE.md                    # This file
│
├── 📁 docs/                                   # Documentation directory
│   ├── INSTALLATION.md                        # Step-by-step setup guide
│   ├── USAGE.md                               # Usage examples (4 interfaces)
│   ├── MODELS.md                              # Model specifications & performance
│   ├── DATASETS.md                            # Dataset documentation
│   ├── ARCHITECTURE.md                        # System architecture & diagrams
│   └── README.md                              # Docs index (auto-generated)
│
├── 📁 data/                                   # Datasets and data files (⚠️ Large)
│   ├── toxigen.csv                            # Toxigen dataset (165 MB)
│   ├── GabHateCorpus_annotations.tsv          # Gab Hate Corpus raw (14 MB)
│   ├── GabHateCorpus_annotations_unique.csv   # Gab Hate Corpus unique (4.5 MB)
│   ├── implicit_hate_v1_stg1_posts.csv        # IHC Stage 1 posts (2.2 MB)
│   ├── implicit_hate_v1_stg1.csv              # IHC Stage 1 labels (0.7 MB)
│   ├── implicit_hate_v1_stg2_posts.csv        # IHC Stage 2 posts (0.7 MB)
│   ├── implicit_hate_v1_stg2.csv              # IHC Stage 2 labels (0.2 MB)
│   ├── implicit_hate_v1_stg3_posts.csv        # IHC Stage 3 posts (0.9 MB)
│   ├── implicit_hate_v1_stg3.csv              # IHC Stage 3 labels (0.4 MB)
│   ├── implicit_hate_v1_SAP_posts.csv         # IHC Self-Annotated Posts (0.1 MB)
│   ├── emoji_data.JSON                        # 294 manually curated hate emojis
│   ├── Emoji_Sentiment_Data_v1.0.csv          # 969 sentiment-ranked emojis
│   └── AnnotatorIAT_and_Attitudes.csv         # Annotator metadata
│
├── 📁 models/                                 # Pre-trained model checkpoints (⚠️ Large)
│   ├── ihc_3way_bert/                         # BERT 3-way classification model
│   │   ├── pytorch_model.bin                  # Model weights (~350 MB)
│   │   ├── config.json                        # Model configuration
│   │   ├── tokenizer.json                     # Tokenizer vocabulary
│   │   ├── tokenizer_config.json              # Tokenizer settings
│   │   ├── label_names.json                   # Class labels
│   │   ├── checkpoint-2680/                   # Training checkpoint 1
│   │   └── checkpoint-3216/                   # Training checkpoint 2
│   │
│   ├── ihc_3way_distilbert/                   # DistilBERT 3-way (lighter, faster)
│   │   ├── pytorch_model.bin                  # (~200 MB)
│   │   ├── config.json
│   │   ├── tokenizer.json
│   │   └── ...
│   │
│   ├── ihc_7way_bert/                         # BERT 7-way classification model
│   │   ├── pytorch_model.bin
│   │   ├── config.json
│   │   └── ...
│   │
│   └── ihc_7way_distilbert/                   # DistilBERT 7-way
│       ├── pytorch_model.bin
│       └── ...
│
├── 📁 results/                                # Evaluation results
│   ├── metrics.json                           # Performance metrics
│   ├── predictions.csv                        # Model predictions on test set
│   ├── classification_report.txt              # Detailed classification report
│   └── confusion_matrices.pkl                 # Confusion matrices for all models
│
├── 📁 figures/                                # Visualizations
│   ├── confusion_matrix_3way.png              # 3-way confusion matrix
│   ├── confusion_matrix_7way.png              # 7-way confusion matrix
│   ├── attention_heatmap.png                  # Attention visualization
│   ├── wordcloud_hate.png                     # Word cloud for hate class
│   ├── wordcloud_clean.png                    # Word cloud for clean class
│   ├── training_loss.png                      # Training loss curve
│   └── performance_comparison.png             # Model comparison
│
├── 📁 logs/                                   # Training logs
│   ├── training_3way_bert.log                 # BERT 3-way training log
│   ├── training_3way_distilbert.log           # DistilBERT 3-way training log
│   ├── training_7way_bert.log                 # BERT 7-way training log
│   └── training_7way_distilbert.log           # DistilBERT 7-way training log
│
├── 📁 .github/                                # GitHub-specific configuration
│   └── workflows/
│       └── tests.yml                          # GitHub Actions CI/CD pipeline
│
├── 📁 src/                                    # Python source code (optional)
│   ├── __init__.py                            # Package initialization
│   ├── utils.py                               # Utility functions
│   ├── emoji_processor.py                     # Emoji extraction & processing
│   ├── models.py                              # Model definitions
│   ├── training.py                            # Training pipeline
│   ├── inference.py                           # Inference utilities
│   ├── explainability.py                      # LIME, SHAP, BertViz wrappers
│   └── api.py                                 # Flask API application
│
├── 📁 .gradio/                                # Gradio interface cache
│
├── 📁 checkpoints/                            # Additional model checkpoints
│
└── 📁 venv/                                   # Virtual environment (not in git)
    └── ...
```

## File Descriptions

### Root Level Files

| File | Size | Description |
|------|------|-------------|
| HateFusion_Complete_21_Cells.ipynb | 7+ MB | Complete Jupyter notebook with 21 cells covering entire pipeline |
| README.md | 30 KB | Main documentation with overview, quick start, and examples |
| LICENSE | 1 KB | MIT License for open source usage |
| requirements.txt | 1 KB | Python package dependencies |
| .gitignore | 2 KB | Git ignore rules for Python projects |
| CONTRIBUTING.md | 5 KB | Guidelines for contributing to project |
| CHANGELOG.md | 5 KB | Version history and changes |

### Documentation (docs/)

| File | Description |
|------|-------------|
| INSTALLATION.md | System requirements, step-by-step installation, troubleshooting |
| USAGE.md | 5 detailed usage examples (basic, batch, emoji, LIME, Gradio) |
| MODELS.md | Model specs, architecture, training config, fine-tuning |
| DATASETS.md | Complete dataset documentation with loading examples |
| ARCHITECTURE.md | System architecture with diagrams and data flow |

### Data (data/) - ⚠️ Large Files

| File | Size | Description |
|------|------|-------------|
| toxigen.csv | 165 MB | Large toxicity dataset |
| GabHateCorpus_annotations.tsv | 14 MB | Raw Gab hate corpus |
| GabHateCorpus_annotations_unique.csv | 4.5 MB | Deduplicated Gab corpus |
| IHC Stage files | 5 MB total | Multi-stage implicit hate annotation |
| emoji_data.JSON | 53 KB | 294 curated hate emojis |
| Emoji_Sentiment_Data_v1.0.csv | 78 KB | 969 sentiment-ranked emojis |

### Models (models/) - ⚠️ Large Files

| Directory | Size | Description |
|-----------|------|-------------|
| ihc_3way_bert/ | 350 MB | BERT for clean/implicit/explicit classification |
| ihc_3way_distilbert/ | 200 MB | Faster DistilBERT version |
| ihc_7way_bert/ | 350 MB | BERT for fine-grained 7-way classification |
| ihc_7way_distilbert/ | 200 MB | Faster DistilBERT 7-way version |

Each model includes:
- `pytorch_model.bin`: Weights (300-350 MB)
- `config.json`: Configuration (< 1 KB)
- `tokenizer.json`: Vocabulary (100+ KB)
- Checkpoints: Training intermediate states

### Results (results/)

Output files from model evaluation:
- Metrics in JSON format
- Predictions on test set
- Classification reports
- Confusion matrices

### Figures (figures/)

Visualization outputs:
- Confusion matrices (PNG)
- Attention heatmaps
- Word clouds by class
- Training curves
- Performance comparisons

### Logs (logs/)

Training run logs:
- One log per model variant
- Training progress
- Validation metrics
- Error messages

### GitHub (.github/)

CI/CD configuration:
- Automated tests on push/PR
- Python version matrix testing
- Dependency verification

### Source Code (src/) - Optional

Refactored Python modules:
- `emoji_processor.py`: Emoji extraction logic
- `models.py`: Model definitions
- `training.py`: Training utilities
- `inference.py`: Prediction utilities
- `explainability.py`: LIME/SHAP wrappers
- `api.py`: Flask application

## File Size Summary

```
Total Dataset Size:       ~200 MB
Total Model Size:         ~1.1 GB
Total Documentation:      ~100 KB
Total Code:              ~7 MB (notebook)
Logs & Results:          ~10 MB
─────────────────────────────────
TOTAL:                   ~1.3 GB
```

## How to Navigate

### For Quick Start
1. Read: `README.md`
2. Install: Follow `docs/INSTALLATION.md`
3. Run: `HateFusion_Complete_21_Cells.ipynb`

### For Understanding Models
1. Read: `docs/MODELS.md`
2. Reference: `docs/ARCHITECTURE.md`
3. Run experiments in notebook

### For Understanding Data
1. Read: `docs/DATASETS.md`
2. Load examples from `data/` directory
3. Check preprocessing in notebook

### For Usage Examples
1. Check: `docs/USAGE.md`
2. Adapt examples to your needs
3. Refer to notebook for full context

### For Contributing
1. Read: `CONTRIBUTING.md`
2. Follow setup in `docs/INSTALLATION.md`
3. Make changes in new branch
4. Submit PR with explanation

## Important Notes

### Large Files ⚠️
- Models directory: ~1.1 GB (not in git by default, download separately)
- Data directory: ~200 MB (not in git, download datasets)
- These are specified in `.gitignore`

### Virtual Environment
- `venv/` is not committed to git
- Recreate with: `pip install -r requirements.txt`

### Checkpoint Files
- Training creates intermediate checkpoints
- Can be deleted after training to save space
- Keep best model only in production

## Recommended Actions Before Uploading to GitHub

1. ✅ Remove `venv/` and `__pycache__/` directories
2. ✅ Confirm `.gitignore` excludes large files
3. ✅ Keep only essential model files (or use Git LFS)
4. ✅ Verify all documentation is complete
5. ✅ Test clone and setup on clean environment

## Next Steps

- Review [README.md](../README.md) for project overview
- Check [INSTALLATION.md](../docs/INSTALLATION.md) for setup
- Start with [USAGE.md](../docs/USAGE.md) for examples
