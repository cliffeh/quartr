ifeq ($(IN_DEVCONTAINER), true)
    # if we're in a devcontainer, we can assume the tools are installed globally
	PIP ?= $(shell which pip3)
	QUART ?= $(shell which quart)

	# linters and other tools
	BLACK ?= $(shell which black)
	BUMP2VERSION ?= $(shell which bump2version)
	COV ?= $(shell which coverage)
	ISORT ?= $(shell which isort)
	MYPY ?= $(shell which mypy)
	PYTEST ?= $(shell which pytest)
else
	# if we're not in a devcontainer, we need to use the venv tools
	PIP := venv/bin/pip3
	QUART := venv/bin/quart

	# linters and other tools
	BLACK := venv/bin/black
	BUMP2VERSION := venv/bin/bump2version
	COV := venv/bin/coverage
	ISORT := venv/bin/isort
	MYPY := venv/bin/mypy
	PYTEST := venv/bin/pytest
endif

help: ## show this help
	@echo "\nSpecify a command. The choices are:\n"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[0;36m%-18s\033[m %s\n", $$1, $$2}'
	@echo ""
	@if [ -z "$(IN_DEVCONTAINER)" ]; then make -s -f venv.mk venv-help; fi
.PHONY: help

venv/bin/%: pyproject.toml
	@make -s -f venv.mk $@ --debug

lint: $(BLACK) $(ISORT) $(MYPY) ## run all linters (black, isort, mypy)
	@$(BLACK) src tests
	@$(ISORT) src tests
	@$(MYPY) src tests
.PHONY: lint

routes: $(QUART) ## list routes
	@$(QUART) --app quartr.app routes --all-methods
.PHONY: routes

serve: $(QUART) ## run a hot-reloading development server
	@$(QUART) --debug --app quartr.app run --host localhost --port 5000 --reload
.PHONY: serve

version: .bumpversion.cfg ## show the current version
	@grep current_version $< | head -1 | awk '{print $$3}'
.PHONY: version

bump-version: lint test $(BUMP2VERSION) ## bump the version number and push a new version tag
	@$(BUMP2VERSION) patch
	@git push origin main --tags
.PHONY: bump-version

test: $(PYTEST) ## run unit test suite
	@$(PYTEST) --asyncio-mode=auto tests
.PHONY: test

htmlcov: $(PYTEST)
	@$(PYTEST) --cov=src --cov-report=term-missing --cov-report=html --asyncio-mode=auto -q tests 1> /dev/null 2> /dev/null
.PHONY: htmlcov

coverage: $(PYTEST) ## generate a test coverage report
	@$(PYTEST) --cov=src --cov-report=term-missing --cov-report=html --asyncio-mode=auto -q tests

# NB we do it this way rather than having a dependency on `coverage` so we can generate the coverage report silently
coverage-md: $(COV) htmlcov ## generate a test coverage report in markdown format
	@$(COV) report --format=markdown

container: ## build a container image
	@docker build -t quartr .
.PHONY: container

container-serve: container ## run the containerized app
	@docker run --rm -p 5000:5000 quartr
.PHONY: container-serve

clean: ## clean up build directories and cache files
	@find . | grep -E "(/__pycache__$$|\.pyc$$|\.pyo$$|\.egg-info$$)" | xargs rm -rf
.PHONY: build-clean

cov-clean: ## clean up coverage reports
	@rm -rf .coverage htmlcov
.PHONY: cov-clean

realclean: clean cov-clean ## clean up All the Things
	@if [ -z "$(IN_DEVCONTAINER)" ]; then make -s -f venv.mk venv-clean; fi
.PHONY: realclean
