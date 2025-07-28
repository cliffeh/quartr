CMDS = black bump2version coverage isort mypy pip3 pytest quart
CMDS := $(addprefix venv/bin/, $(CMDS))

venv-help: ## show help for venv commands
	@echo "Available venv commands:"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[0;36m%-18s\033[m %s\n", $$1, $$2}'
	@echo ""
.PHONY: help

venv: $(CMDS) ## create a virtual environment and install dependencies

$(CMDS): pyproject.toml
	@python3 -m venv --upgrade-deps --prompt quartr venv
	@venv/bin/pip3 install -e .[dev]
	@touch $(CMDS)

venv-clean: ## delete the virtual environment
	@rm -rf venv
.PHONY: venv-clean
