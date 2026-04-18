# GitHub Upload Guide

This document explains how to upload the HateFusion project to GitHub at:
`https://github.com/kirubaharan181/HateEmofusion`

## Prerequisites

1. GitHub account with username `kirubaharan181`
2. Git installed on your machine
3. GitHub authentication configured (SSH or HTTPS)

## Step 1: Create Repository on GitHub

1. Go to https://github.com/new
2. Fill in repository details:
   - **Repository name**: `HateEmofusion`
   - **Description**: "Advanced Hate Speech Detection with Emoji-Aware Feature Extraction"
   - **Public/Private**: Public (recommended)
   - **Initialize**: ❌ Don't initialize (we'll push existing code)
3. Click "Create repository"

## Step 2: Initialize Git Locally

```bash
cd D:\hatefusion_project\HateFusion
git init
git config user.name "Kirubaharan"
git config user.email "your.email@example.com"
```

## Step 3: Add Files

```bash
# Add all files (respecting .gitignore)
git add .

# Check what will be committed
git status
```

## Step 4: Create Initial Commit

```bash
git commit -m "chore: Initial commit - HateFusion project structure and documentation"
```

## Step 5: Add Remote Repository

Replace `YOUR_TOKEN` with your GitHub personal access token or use SSH:

### Option A: HTTPS (Personal Access Token)
```bash
git remote add origin https://github.com/kirubaharan181/HateEmofusion.git
git branch -M main
git push -u origin main
```

### Option B: SSH (Recommended)
```bash
git remote add origin git@github.com:kirubaharan181/HateEmofusion.git
git branch -M main
git push -u origin main
```

## Step 6: Handle Large Files

### Option A: Large Files Excluded (Recommended for Initial Push)

Large files (models, datasets) are already in `.gitignore`. To push:

```bash
git push -u origin main
```

### Option B: Use Git LFS (for model files)

Install Git LFS:
```bash
git lfs install
```

Track large files:
```bash
git lfs track "models/*.bin"
git lfs track "data/toxigen.csv"
git add .gitattributes
git commit -m "chore: Add Git LFS tracking"
git push -u origin main
```

Then add large files:
```bash
git add models/
git add data/
git commit -m "chore: Add pre-trained models and datasets (Git LFS)"
git push
```

## Step 7: Verify Upload

1. Go to https://github.com/kirubaharan181/HateEmofusion
2. Check files are visible
3. Verify README is displayed
4. Check docs are accessible

## What Gets Uploaded

### ✅ WILL BE UPLOADED
```
✓ README.md (13 KB)
✓ docs/ (40 KB total)
  - INSTALLATION.md
  - USAGE.md
  - MODELS.md
  - DATASETS.md
  - ARCHITECTURE.md
✓ HateFusion_Complete_21_Cells.ipynb (7 MB)
✓ requirements.txt
✓ LICENSE
✓ CONTRIBUTING.md
✓ CHANGELOG.md
✓ PROJECT_STRUCTURE.md
✓ .gitignore
✓ .github/workflows/tests.yml
✓ src/ (if created)
```

### ❌ WON'T BE UPLOADED (by .gitignore)
```
✗ venv/               (virtual environment)
✗ models/*.bin        (pre-trained weights) - LARGE
✗ data/toxigen.csv    (dataset) - LARGE
✗ __pycache__/        (Python cache)
✗ .pytest_cache/      (test cache)
✗ logs/               (training logs)
✗ results/            (large result files)
✗ .DS_Store           (macOS)
```

## Updating Repository Later

```bash
# Make changes to files
git add .
git commit -m "feat: Add new feature"
git push origin main
```

## Adding Models/Data Later (Git LFS)

After setting up Git LFS:

```bash
# Add model files
git lfs track "models/ihc_3way_bert/pytorch_model.bin"
git add models/
git commit -m "chore: Add BERT 3-way model"
git push

# Add dataset
git lfs track "data/toxigen.csv"
git add data/
git commit -m "chore: Add Toxigen dataset"
git push
```

## Creating Releases

```bash
git tag -a v1.0.0 -m "Version 1.0.0 - Initial Release"
git push origin v1.0.0
```

Then on GitHub:
1. Go to Releases
2. Find v1.0.0
3. Add release notes
4. Publish

## Troubleshooting

### Problem: "src refspec main does not match any"
**Solution**:
```bash
git branch -M main
git push -u origin main
```

### Problem: Authentication fails
**Solution** (HTTPS):
```bash
git remote remove origin
git remote add origin https://your_username:your_token@github.com/kirubaharan181/HateEmofusion.git
git push -u origin main
```

### Problem: ".gitignore not working"
**Solution**:
```bash
git rm -r --cached .
git add .
git commit -m "chore: Fix .gitignore"
git push
```

### Problem: Large files already committed
**Solution** (use BFG Repo-Cleaner):
```bash
bfg --strip-blobs-bigger-than 100M
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push --force
```

## After Upload Checklist

- [ ] Repository visible at https://github.com/kirubaharan181/HateEmofusion
- [ ] README.md displays correctly
- [ ] All documentation files are present
- [ ] Notebook file is uploaded
- [ ] .gitignore is properly configured
- [ ] GitHub Actions workflow is present
- [ ] No sensitive data exposed
- [ ] File tree looks correct
- [ ] Clone test works: `git clone https://github.com/kirubaharan181/HateEmofusion.git`

## Next Steps After Upload

1. **Add Repository Description**:
   - Go to Settings → General
   - Add description and topics
   - Add website URL (if any)

2. **Configure README**:
   - Verify badges are working
   - Update any placeholder links

3. **Set Up Collaborators** (if needed):
   - Settings → Collaborators → Add people

4. **Enable GitHub Pages** (optional):
   - Settings → Pages
   - Select main branch
   - Choose docs/ as source

5. **Add GitHub Topics**:
   - Go to main page
   - Add tags: `hate-speech-detection`, `nlp`, `pytorch`, `transformers`, `bert`, `explainability`

6. **Monitor Issues/Pull Requests**:
   - Enable discussions
   - Set up issue templates
   - Create contributing guidelines (already included)

## Helpful Commands

```bash
# Check status
git status

# View commit history
git log --oneline -10

# See what will be pushed
git diff origin/main

# Force clean staging
git reset --hard

# Remove accidental commits (careful!)
git reset --soft HEAD~1

# Create and push new branch
git checkout -b feature/new-feature
git push -u origin feature/new-feature

# View remote
git remote -v

# Change remote URL
git remote set-url origin new-url
```

## Security Notes

⚠️ **IMPORTANT**: Before pushing, ensure:
- ❌ No API keys, tokens, or credentials
- ❌ No personal information
- ❌ No large binary files (models should be Git LFS)
- ❌ No passwords in code or config
- ✅ All sensitive files in .gitignore

## Questions?

Refer to:
- [GitHub Docs](https://docs.github.com)
- [Git Documentation](https://git-scm.com/doc)
- Project's CONTRIBUTING.md

---

**Ready to push? Follow the steps above!** 🚀
