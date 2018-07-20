# Inspire ORCID service client

This package is service client for ORCID API used in inspire-next.

## Client usage

TODO

## Development

```bash
# Create a venv and install the requirements:
$ make venv

# Run isort and lint:
$ make isort
$ make lint

# Run all the tests:
$ make test  # tox against Python27 and Python36.
$ tox -e py27  # tox against a specific Python version.
$ pytest  # pytest against the active venv.

# Run a specific test:
$ make test/tests/test_orcid.py  # tox against Python27 and Python36.
$ tox -e py27 -- tests/test_orcid.py  # tox against a specific Python version.
$ pytest tests/test_orcid.py  # pytest against the active venv.
```

To publish on PyPi:

```bash
# Edit .pypirc:
$ cat $HOME/.pypirc
[pypi]
username: myuser
password: mypass

# Edit the version in `setup_gen.py`.

# Finally compile and publish:
$ make publish
```
