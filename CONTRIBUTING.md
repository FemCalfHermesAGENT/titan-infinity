# Contributing to FemCalfHermesAGENT Repos

## Development Setup

1. Clone the repo and create a virtual environment:
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # Linux/macOS
   # or: .venv\Scripts\activate  # Windows
   make install-dev
   ```

2. Install pre-commit hooks:
   ```bash
   make pre-commit
   ```

## Code Standards

- **Linter**: Ruff (replaces flake8, isort, black)
- **Line length**: 100 characters
- **Python target**: 3.11+
- **Test framework**: pytest

## Workflow

1. Create a feature branch: `git checkout -b feat/my-feature`
2. Write code + tests
3. Run `make all` (format + lint + test) — must pass before PR
4. Push and open a pull request

## CI Pipeline

Every push and PR triggers GitHub Actions:
- **Lint**: `ruff check` + `ruff format --check`
- **Test**: `pytest` with coverage
- **Build**: verify `pyproject.toml` is valid

## Commit Convention

```
feat: add quantum classifier
fix: correct amplitude encoding
docs: update API reference
test: add edge-case coverage
chore: bump dependencies
```
