#!/bin/sh -l

set -ea

echo "##################################################"
echo "#                                                #"
echo "#                Starting pycheck                #"
echo "#                                                #"
echo "##################################################"
echo ""

echo -e "Path to check: $@\n"

# python
echo -e "\n$(python --version)"

# pip
echo -e "$(pip --version)\n"

# black
echo -e "$(black --version)"
black --check "$@"

# flake8
echo -e "\nflake8 $(flake8 --version)"
flake8 "$@"

# mypy
echo -e "\n$(mypy --version)"
for file_name in `find $@`; do
    if [ "py" == `basename $file_name | sed 's/^.*\.\([^\.]*\)$/\1/'` ];
    then
        mypy --check $file_name
    fi
done

# isort
echo "$(isort --version)"
isort --check "$@"

echo ""
echo "##################################################"
echo "#                                                #"
echo "#                Complete pycheck                #"
echo "#                                                #"
echo "##################################################"

echo -e "\nfinish date: $(date)"
