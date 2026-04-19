# HateFusion Quick Reference

## What is in this repository

- `HateFusion_Complete_21_Cells (2) - Copy.ipynb` - main notebook pipeline.
- `requirements.txt` - Python dependencies.
- `docs/` - installation, usage, model, dataset, and architecture notes.
- `data/` - local datasets, ignored by git because of size and licensing.
- `models/` - local trained model checkpoints, ignored by git because of size.
- `results/` and `logs/` - local run outputs, ignored by git.

## Setup

```bash
python -m venv venv
venv\Scripts\activate
pip install --upgrade pip
pip install -r requirements.txt
```

On Linux or macOS:

```bash
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

## Run the notebook

```bash
jupyter notebook "HateFusion_Complete_21_Cells (2) - Copy.ipynb"
```

## Use a local model

```python
from transformers import BertForSequenceClassification, BertTokenizer
import torch

model_path = "models/ihc_3way_bert"
model = BertForSequenceClassification.from_pretrained(model_path)
tokenizer = BertTokenizer.from_pretrained(model_path)

text = "This is a test message"
inputs = tokenizer(text, return_tensors="pt", truncation=True, max_length=128)

with torch.no_grad():
    outputs = model(**inputs)
    prediction = torch.argmax(outputs.logits, dim=1).item()

labels = {0: "Clean", 1: "Implicit Hate", 2: "Explicit Hate"}
print(labels[prediction])
```

## Important local files

The repository does not include datasets or trained model weights. Keep them in:

- `data/`
- `models/`

If another machine clones this project, those folders must be restored separately before running model inference or full training.

## Documentation

- `docs/INSTALLATION.md` - environment setup.
- `docs/USAGE.md` - inference and training examples.
- `docs/MODELS.md` - model descriptions.
- `docs/DATASETS.md` - dataset notes.
- `docs/ARCHITECTURE.md` - pipeline architecture.
