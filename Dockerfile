FROM python:3.9-alpine

# add label
LABEL "com.github.actions.name"="pycheck"
LABEL "com.github.actions.description"="GitHub Action for Python code check"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="green"
LABEL "com.github.actions.repository"="https://github.com/nanato12/pycheck"
LABEL "com.github.actions.homepage"="https://github.com/nanato12/pycheck"
LABEL "com.github.actions.maintainer"="nanato12"

# need packages
RUN apk update
RUN apk add gcc musl-dev

# pip control
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install flake8 black mypy isort

# entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
