# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-04-18

### Added
- Initial release of HateFusion
- BERT and DistilBERT models for hate speech detection
- 3-way classification: Clean, Implicit Hate, Explicit Hate
- 7-way classification with fine-grained hate categories
- 3-layer emoji detection system (294 + 969 + 5225 emojis)
- Emoji enrichment for improved model understanding
- Emoji feature extraction (9-dimensional vectors)
- Multi-dataset training (Toxigen, IHC, Gab Hate Corpus)
- LIME explainability support
- SHAP values integration
- BertViz attention visualization
- Gradio interactive interface
- Flask REST API
- Comprehensive documentation
- GitHub Actions CI/CD pipeline

### Features
- Advanced text preprocessing
- Stratified train-test split
- Class weight balancing
- Gradient accumulation for larger effective batch sizes
- Early stopping with customizable patience
- Learning rate warmup (10% ratio)
- Mixed precision training support (FP16)
- Reproducible results with seed control
- Confusion matrix and classification reports
- Word cloud visualizations
- Batch processing capabilities

### Models
- `ihc_3way_bert`: BERT for 3-way classification
- `ihc_3way_distilbert`: DistilBERT for 3-way classification
- `ihc_7way_bert`: BERT for 7-way classification
- `ihc_7way_distilbert`: DistilBERT for 7-way classification

### Datasets
- Toxigen (165+ MB)
- Implicit Hate Corpus (multiple stages)
- Gab Hate Corpus (4.5 MB)
- Emoji Sentiment Data (969 emojis)
- Manual hate emoji dictionary (294 emojis)

### Documentation
- Comprehensive README with feature overview
- Installation guide
- Usage examples (4 interfaces)
- Model documentation with specifications
- Dataset documentation with loading examples
- Architecture documentation with diagrams
- Contributing guidelines
- API documentation

## [Unreleased]

### Planned Features
- [ ] Multilingual support
- [ ] Docker containerization
- [ ] Hugging Face model hub integration
- [ ] Real-time monitoring dashboard
- [ ] Advanced bias detection
- [ ] Few-shot learning support
- [ ] Model quantization tools
- [ ] Additional explainability methods
- [ ] Mobile API wrapper
- [ ] Community model sharing

---

## How to Update

When making changes, update this file following:
1. Add entry under `[Unreleased]` section during development
2. Upon release, move to dated version section
3. Follow "Added", "Changed", "Deprecated", "Removed", "Fixed", "Security" structure
4. Include version number and date in format: `[X.Y.Z] - YYYY-MM-DD`
