# This Makefile requires the following commands to be available:
# * python2
# * virtualenv

DEPS:=requirements.txt
VIRTUALENV=$(shell which virtualenv)
PIP:="venv/bin/pip"
TWINE:="venv/bin/twine"
CMD_FROM_VENV:=". venv/bin/activate; which"
TOX=$(shell "$(CMD_FROM_VENV)" "tox")
PYTHON=$(shell "$(CMD_FROM_VENV)" "python")
TOX_PY_LIST="$(shell $(TOX) -l | grep ^py | xargs | sed -e 's/ /,/g')"


.PHONY: venv requirements pyclean clean pipclean tox tests test pytests pytest lint isort setup.py publish


venv:
	$(VIRTUALENV) -p $(shell which python2.7) venv
	. venv/bin/activate
	$(PIP) install -U "pip>=18.0" -q
	$(PIP) install -U -r $(DEPS)


## Utilities for the venv currently active.

_ensure_active_env:
ifndef VIRTUAL_ENV
	@echo 'Error: no virtual environment active'
	@exit 1
endif

requirements: _ensure_active_env
	pip install -U "pip>=18.0" -q
	pip install -U -r $(DEPS)


## Generic utilities.

pyclean:
	find . -name *.pyc -delete
	rm -rf *.egg-info build
	rm -rf coverage.xml .coverage
	rm -rf .pytest_cache
	rm -rf __pycache__

clean: pyclean
	rm -rf venv
	rm -rf .tox
	rm -rf dist

pipclean:
	rm -rf ~/Library/Caches/pip
	rm -rf ~/.cache/pip


## Tox, pytest, setuptools.

tox: venv setup.py
	$(TOX)

tests: clean tox

test/%: venv pyclean
	$(TOX) -e $(TOX_PY_LIST) -- $*

pytests: _ensure_active_env
	pytest tests -s -x

pytest/%: _ensure_active_env
	pytest tests -s -x -k $*

lint: venv
	$(TOX) -e lint
	$(TOX) -e isort-check

isort: venv
	$(TOX) -e isort-fix

setup.py: venv
	$(PYTHON) setup_gen.py
	$(PYTHON) setup.py check --restructuredtext

publish: setup.py
	$(PYTHON) setup.py sdist
	$(TWINE) upload dist/*
