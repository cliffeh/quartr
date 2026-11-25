UV ?= uv
UV_RUN := $(UV) run

help: ## show this help
	@echo "\nSpecify a command. The choices are:\n"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[0;36m%-18s\033[m %s\n", $$1, $$2}'
	@echo ""
.PHONY: help

sync: ## create/update the virtual environment from uv.lock
	@$(UV) sync
.PHONY: sync

lock: ## upgrade all locked dependencies
	@$(UV) lock --upgrade
.PHONY: lock

lint: ## run all linters (black, isort, mypy)
	@$(UV_RUN) black src tests
	@$(UV_RUN) isort src tests
	@$(UV_RUN) mypy src tests
.PHONY: lint

routes: ## list routes
	@$(UV_RUN) quart --app quartr.app routes --all-methods
.PHONY: routes

serve: ## run a hot-reloading development server
	@$(UV_RUN) quart --debug --app quartr.app run --host localhost --port 8000 --reload
.PHONY: serve

version: ## show the current version
	@$(UV_RUN) bump-my-version show current_version
.PHONY: version

bump-version: lint test ## bump the version number and push a new version tag
	@$(UV_RUN) bump-my-version bump patch
	@git push origin main --tags
.PHONY: bump-version

test: ## run unit test suite
	@$(UV_RUN) pytest --asyncio-mode=auto tests
.PHONY: test

htmlcov:
	@$(UV_RUN) pytest --cov=src --cov-report=term-missing --cov-report=html --asyncio-mode=auto -q tests 1> /dev/null 2> /dev/null
.PHONY: htmlcov

coverage: ## generate a test coverage report
	@$(UV_RUN) pytest --cov=src --cov-report=term-missing --cov-report=html --asyncio-mode=auto -q tests

# NB we do it this way rather than having a dependency on `coverage` so we can generate the coverage report silently
coverage-md: htmlcov ## generate a test coverage report in markdown format
	@$(UV_RUN) coverage report --format=markdown

container: ## build a container image
	@docker build -t quartr .
.PHONY: container

container-serve: container ## run the containerized app
	@docker run --rm -p 8000:8000 quartr
.PHONY: container-serve

clean: ## clean up build directories and cache files
	@find . | grep -E "(/__pycache__$$|\.pyc$$|\.pyo$$|\.egg-info$$)" | xargs rm -rf
.PHONY: build-clean

cov-clean: ## clean up coverage reports
	@rm -rf .coverage htmlcov
.PHONY: cov-clean

realclean: clean cov-clean ## clean up All the Things
	@rm -rf .venv
.PHONY: realclean
