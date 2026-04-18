# Contributing to HateFusion

Thank you for your interest in contributing to HateFusion! We welcome contributions from the community.

## Code of Conduct

Be respectful and constructive. We're committed to providing a welcoming environment for all contributors.

## How to Contribute

### 1. Report Bugs

**Before reporting**, please check existing issues to avoid duplicates.

**When reporting**, include:
- Python version
- PyTorch version
- CUDA version (if applicable)
- Minimal code to reproduce
- Expected vs actual behavior
- Error traceback

### 2. Suggest Features

Open an issue with:
- Clear description of the feature
- Use cases
- Potential implementation approach
- Any relevant references

### 3. Submit Pull Requests

#### Setup Development Environment

```bash
git clone https://github.com/kirubaharan181/HateEmofusion.git
cd HateEmofusion
python -m venv venv
source venv/bin/activate  # or venv\Scripts\activate on Windows
pip install -r requirements.txt
```

#### Make Changes

1. Create a feature branch: `git checkout -b feature/your-feature`
2. Make your changes
3. Add tests if applicable
4. Update documentation
5. Commit with clear messages: `git commit -m "Add feature: description"`

#### Submit PR

1. Push to your fork
2. Open PR against `main` branch
3. Provide clear description of changes
4. Link related issues

#### PR Requirements

- [ ] Code follows project style
- [ ] Tests pass (if applicable)
- [ ] Documentation updated
- [ ] No breaking changes (or clearly documented)

## Areas for Contribution

### High Priority
- [ ] Multilingual support (for hate speech detection)
- [ ] Additional emoji datasets
- [ ] Docker containerization
- [ ] Production API deployment
- [ ] Mobile app integration

### Medium Priority
- [ ] Performance optimization
- [ ] Additional explainability techniques
- [ ] Web dashboard UI
- [ ] Better data preprocessing
- [ ] Bias detection tools

### Low Priority
- [ ] Code refactoring
- [ ] Documentation improvements
- [ ] Example notebooks
- [ ] Visualization enhancements

## Development Guidelines

### Code Style

- Use Python 3.9+ features
- Follow PEP 8 conventions
- Type hints where possible
- Docstrings for functions and classes

### Git Workflow

```
main (stable) ← develop (staging) ← feature branches
```

### Commit Messages

```
feat: Add new feature
fix: Fix bug
docs: Update documentation
style: Code style changes
refactor: Refactor code
test: Add tests
perf: Performance improvement
```

### Testing

If adding new features:
```python
import pytest

def test_new_feature():
    result = new_feature(test_input)
    assert result == expected_output
```

## Documentation

### README Section Guidelines
- Keep it concise
- Add examples
- Link to detailed docs
- Use badges for status

### Docstring Format
```python
def emoji_enrich_text(text):
    """Enrich text with emoji semantic meanings.
    
    Args:
        text: Input text with emojis
        
    Returns:
        Enriched text with emoji meanings replaced
        
    Examples:
        >>> emoji_enrich_text("I love this! 😊")
        "I love this! [smiling_face_with_smiling_eyes]"
    """
```

## Release Process

1. Update version in appropriate files
2. Update CHANGELOG
3. Create release notes
4. Tag release on GitHub
5. Push to main

## Questions?

- Open a discussion in GitHub Discussions
- Check existing issues/documentation
- Contact maintainers

## Thank You!

Your contributions help make HateFusion better for everyone!

---

**Happy Contributing!** 🚀
