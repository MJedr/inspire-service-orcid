[![Build Status](https://travis-ci.org/puntonim/inspire-service-orcid.svg?branch=master)](https://travis-ci.org/puntonim/inspire-service-orcid)

# Inspire ORCID service client

This package is service client for ORCID API used in inspire-next.

## Client usage

```python
# Configure settings.
import inspire_services.orcid.conf
d = dict(
    DO_USE_SANDBOX=False,
    CONSUMER_KEY='myorcidappkey',
    CONSUMER_SECRET='myorcidappsecret',
    REQUEST_TIMEOUT=30,
)
inspire_services.orcid.conf.settings.configure(**d)

# Use the client.
from inspire_services.orcid.client import OrcidClient
client = OrcidClient('mytoken', '0000-0002-0942-3697')
response = client.get_all_works_summary()
response.raise_for_result()
putcode = response['group'][0]['work-summary'][0]['put-code']
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
$ make test/tests/test_orcid.py  # tox against Python27 and Python36.
$ tox -e py27 -- tests/test_orcid.py  # tox against a specific Python version.
$ pytest tests/test_orcid.py  # pytest against the active venv.
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
# Edit the version in `setup_gen.py`.
# ... version=pep440_version('1.1.1'),
# Then generate setup.py with:
$ make setup.py
# Commit, tag, push:
$ git commit -m '1.1.1 release'
$ git tag 1.1.1
$ git push origin master --tags

# Finally publish:
$ make publish
```
