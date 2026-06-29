# Makefile — Developer commands for FemCalfHermesAGENT repos
# Usage: make <target>

.PHONY: help install install-dev lint format test test-cov clean pre-commit

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-18s\033[0m %s\n", $$1, $$2}'

install: ## Install production deps
	pip install -r requirements.txt

install-dev: ## Install production + dev deps
	pip install -r requirements.txt
	pip install -r requirements-dev.txt

lint: ## Run ruff linter
	ruff check src/ tests/

format: ## Run ruff formatter
	ruff format src/ tests/

format-check: ## Check formatting without modifying
	ruff format --check src/ tests/

test: ## Run tests
	pytest

test-cov: ## Run tests with coverage
	pytest --cov --cov-report=term-missing --cov-report=html

clean: ## Remove build artifacts
	rm -rf build/ dist/ *.egg-info .pytest_cache .coverage htmlcov/ .ruff_cache/
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true

pre-commit: ## Install and run pre-commit hooks
	pre-commit install
	pre-commit run --all-files

all: format lint test ## Format, lint, and test
