# Installing Boltz-2

Boltz-2 is distributed on PyPI and GitHub. We recommend using a fresh Python environment with Python 3.10 or newer.

```bash
pip install boltz -U
```

For the latest development version:

```bash
git clone https://github.com/jwohlwend/boltz.git
cd boltz
pip install -e .
```

Boltz downloads model weights and CCD data on first use. Set the environment variable `BOLTZ_CACHE` if you want to change the cache location.

