# pycheck
GitHub Action for Python code check

## check
- black
- flake8
- mypy
- isort

## How to use
Write `.github/workflows/main.yml`.

```yml
- name: GitHub Action for Python code check
  uses: nanato12/pycheck@master
  with:
      path: './'
```

Refer to this: [main.yml](.github/workflows/main.yml)

## Options
Write the options for each check to `setup.cfg`.

Example:
```conf
[flake8]
extend-ignore = E203,E501
exclude = .git,__init__.py,__pycache__
max-line-length = 120

[mypy]
python_version = 3.9
disallow_untyped_calls = True
disallow_untyped_defs = True

[mypy-selenium.*]
ignore_missing_imports = True
```

## For myself :3
```bash
docker build . -t pycheck
docker run --workdir /workspace -v $PWD:/workspace pycheck /workspace
```
