PIP=venv/bin/pip
PYTHON=venv/bin/python3
QUART=venv/bin/quart

# linters and test tools
BLACK=venv/bin/black
ISORT=venv/bin/isort
MYPY=venv/bin/mypy

default: help

code: venv ## open vscode
	@code .
.PHONY: code

venv: pyproject.toml ## create a virtual environment
	@python3 -mvenv --upgrade-deps --prompt quartr venv
	@$(PIP) install -e .[dev]

lint: venv ## run all linters (black, isort, mypy)
	@$(BLACK) src tests
	@$(ISORT) src tests
	@$(MYPY) src tests
.PHONY: lint

routes: venv ## list routes
	@$(QUART) --app quartr routes
.PHONY: routes

serve: venv ## run a hot-reloading development server
	@$(QUART) --debug --app quartr.app run --host localhost --port 5000 --reload
.PHONY: serve

container: ## build a container image 
	@docker build -t quartr .
.PHONY: container

container-serve: container ## run the containerized app
	@docker run --rm -p 5000:5000 quartr
.PHONY: container-serve

test: venv ## run unit test suite
	@$(PYTHON) -m pytest --asyncio-mode=auto tests
.PHONY: test

coverage: venv ## generate a test coverage report
	@$(PYTHON) -m pytest --cov=src --cov-report=term-missing --cov-report=html --asyncio-mode=auto tests
.PHONY: coverage

clean: ## clean up build directories and cache files
	@rm -rf build src/quartr.egg-info src/quartr/__pycache__ tests/__pycache__
.PHONY: build-clean

venv-clean: ## delete the virtual environment
	@rm -rf venv
.PHONY: venv-clean

realclean: clean venv-clean ## clean up All the Things
.PHONY: realclean

help: ## show this help
	@echo "\nSpecify a command. The choices are:\n"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[0;36m%-18s\033[m %s\n", $$1, $$2}'
	@echo ""
.PHONY: help
