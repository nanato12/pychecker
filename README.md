# pycheck
GitHub Action for Python code check  
Pythonのコードチェック用のGitHub Action

## check
- black
- flake8
- mypy
- isort

このActionでは上記4点が評価されます。

## How to use
Write `.github/workflows/main.yml`.  
使用するには`.github/workflows/main.yml`に追記してください。

```yml
- name: GitHub Action for Python code check
  uses: nanato12/pycheck@master
  with:
      path: './'
```

Refer to this: [main.yml](.github/workflows/main.yml)  
こちらを参考に: [main.yml](.github/workflows/main.yml)

## Options [required]
Write the options for each check to `setup.cfg`.  
各チェックのオプションは`setup.cfg`に記載してください。

**If `setup.cfg` does not exist, each check will conflict.**  
**もし、`setup.cfg` が存在しない場合、各チェックは競合し失敗します。**

Recommended:  
おすすめ:
```conf
[flake8]
extend-ignore = E203, E501
exclude = __init__.py

[isort]
multi_line_output=3
include_trailing_comma = True
force_grid_wrap = 0
use_parentheses = True
ensure_newline_before_comments = True
line_length = 88

[mypy]
disallow_untyped_calls = True
disallow_untyped_defs = True
```

## For myself :3
```bash
docker build . -t pycheck
docker run --workdir /workspace -v $PWD:/workspace pycheck /workspace
```
