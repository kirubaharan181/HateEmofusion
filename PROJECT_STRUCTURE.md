# Project Structure

This file describes the files that are tracked in the repository and the local folders that are expected when running the full project.

## Tracked Files

```text
HateEmofusion/
|-- HateFusion_Complete_21_Cells (2) - Copy.ipynb
|-- README.md
|-- QUICK_REFERENCE.md
|-- PROJECT_STRUCTURE.md
|-- CHANGELOG.md
|-- CONTRIBUTING.md
|-- LICENSE
|-- requirements.txt
|-- .gitignore
|-- .github/
|   `-- workflows/
|       `-- ci.yml
`-- docs/
    |-- README.md
    |-- INSTALLATION.md
    |-- USAGE.md
    |-- MODELS.md
    |-- DATASETS.md
    `-- ARCHITECTURE.md
```

## Local Runtime Folders

These folders are used by the notebook and local experiments, but they are intentionally ignored by git:

```text
data/       datasets and emoji resources
models/     trained model checkpoints and tokenizers
results/    generated metrics and evaluation outputs
logs/       local run logs
.gradio/    Gradio cache files
venv/       local Python virtual environment
```

The ignored folders can be large. In this local workspace, the `models/` directory contains many checkpoint files, so it should stay outside normal git tracking.

## Main Notebook

The current notebook file is:

```text
HateFusion_Complete_21_Cells (2) - Copy.ipynb
```

Run it with:

```bash
jupyter notebook "HateFusion_Complete_21_Cells (2) - Copy.ipynb"
```

## Documentation

| File | Purpose |
| --- | --- |
| `README.md` | Project overview and quick start |
| `QUICK_REFERENCE.md` | Short setup and usage notes |
| `docs/INSTALLATION.md` | Environment setup |
| `docs/USAGE.md` | Inference, batch processing, Gradio, and training examples |
| `docs/MODELS.md` | Model variants and loading examples |
| `docs/DATASETS.md` | Dataset descriptions and expected local files |
| `docs/ARCHITECTURE.md` | Pipeline architecture |

## Continuous Integration

The repository includes a lightweight workflow:

```text
.github/workflows/ci.yml
```

It validates that required documentation and notebook files exist, checks that the notebook is valid JSON, and verifies that dependencies in `requirements.txt` are pinned.

## Notes

- There is no separate `src/` package in the current repository.
- There is no separate Flask application file in the current repository.
- Generated figures are not currently tracked as a `figures/` directory.
- Data and model files must be restored locally before running full inference or training.
