# Installation Guide

## System Requirements

- **OS**: Linux, macOS, or Windows
- **Python**: 3.9 or higher
- **RAM**: 8GB minimum (16GB+ recommended)
- **Storage**: 30GB+ for datasets and models
- **GPU** (Optional): NVIDIA CUDA 11.8+ for faster training

## Step-by-Step Installation

### 1. Clone Repository

```bash
git clone https://github.com/kirubaharan181/HateEmofusion.git
cd HateEmofusion
```

### 2. Create Virtual Environment

**On Linux/macOS:**
```bash
python3 -m venv venv
source venv/bin/activate
```

**On Windows (Command Prompt):**
```cmd
python -m venv venv
venv\Scripts\activate
```

**On Windows (PowerShell):**
```powershell
python -m venv venv
.\venv\Scripts\Activate.ps1
```

### 3. Upgrade pip

```bash
pip install --upgrade pip
```

### 4. Install Dependencies

```bash
pip install -r requirements.txt
```

### 5. (Optional) Install GPU Support

If you have an NVIDIA GPU:

```bash
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```

### 6. Verify Installation

```bash
python -c "import torch; print(f'PyTorch: {torch.__version__}, CUDA: {torch.cuda.is_available()}')"
python -c "from transformers import BertTokenizer; print('Transformers OK')"
python -c "import gradio; print('Gradio OK')"
```

## Common Issues & Solutions

### Issue: `ModuleNotFoundError: No module named 'transformers'`

**Solution**: Make sure virtual environment is activated and run:
```bash
pip install --upgrade transformers
```

### Issue: CUDA not available on GPU system

**Solution**: Reinstall PyTorch with CUDA support:
```bash
pip install torch --index-url https://download.pytorch.org/whl/cu118
```

### Issue: Out of Memory (OOM) during training

**Solutions**:
- Reduce `ACTUAL_BATCH_SIZE` in config
- Use DistilBERT instead of BERT (faster, lighter)
- Enable gradient accumulation
- Use CPU training (slower but uses less memory)

### Issue: Missing data files

**Solution**: Download datasets from:
- Toxigen: [Link to source]
- Implicit Hate Corpus: [Link to source]
- Gab Hate Corpus: [Link to source]

Place them in the `data/` directory.

## Running the Project

### Option 1: Jupyter Notebook

```bash
jupyter notebook "HateFusion_Complete_21_Cells (2) - Copy.ipynb"
```

### Option 2: Interactive Gradio Interface

Use the Gradio example in [USAGE.md](USAGE.md), or run the Gradio cells inside the notebook.

## Next Steps

- Read [USAGE.md](USAGE.md) for detailed usage examples
- Check [MODELS.md](MODELS.md) for model documentation
- Review [DATASETS.md](DATASETS.md) for dataset information
