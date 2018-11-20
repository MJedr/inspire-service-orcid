[![Build Status](https://travis-ci.org/puntonim/inspire-service-orcid.svg?branch=master)](https://travis-ci.org/puntonim/inspire-service-orcid)

# Inspire ORCID service client

This package is service client for ORCID API used in inspire-next.

## Client usage

```python
# Configure settings.
import inspire_service_orcid.conf
d = dict(
    DO_USE_SANDBOX=False,
    CONSUMER_KEY='myorcidappkey',
    CONSUMER_SECRET='myorcidappsecret',
    REQUEST_TIMEOUT=30,
)
inspire_service_orcid.conf.settings.configure(**d)

# Use the client.
from inspire_service_orcid.client import OrcidClient
client = OrcidClient('mytoken', '0000-0002-0942-3697')
response = client.get_all_works_summary()
response.raise_for_result()
putcode = response['group'][0]['work-summary'][0]['put-code']
```

In order to use time_execution to collect metrics, configure it first:
```python
import time_execution
from inspire_service_orcid import hooks

hooks = [
    hooks.status_code_hook,
    hooks.orcid_error_code_hook,
    hooks.orcid_service_exception_hook,
]
time_execution.settings.configure(
    backends=[mybackend],
    hooks=hooks,
    origin='inspire_next'
)
```

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
$ make test/tests/test_client.py  # tox against Python27 and Python36.
$ tox -e py27 -- tests/test_client.py  # tox against a specific Python version.
$ pytest tests/test_client.py  # pytest against the active venv.
```

To publish on PyPi, first set the PyPi credentials:

```bash
# Edit .pypirc:
$ cat $HOME/.pypirc
[pypi]
username: myuser
password: mypass
```

```bash
# Tag the new version:
$ git tag 1.1.1
# Then generate setup.py and publish:
$ make setup.py
$ make publish
# Commit the setup.py file:
$ git add .
$ git commit -m '1.1.1 released'
$ git push origin master --tags
```
