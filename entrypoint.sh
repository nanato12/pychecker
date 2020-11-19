#!/bin/sh -l

set -ea

echo -e "\nstart date: $(date)\n"

echo "##################################################"
echo "#                                                #"
echo "#                Starting pycheck                #"
echo "#                                                #"
echo "##################################################"
echo -e "\n"

echo -e "Path to check: $@\n"

# python
echo -e "\n$(python --version)"

# pip
echo -e "$(pip --version)\n"

# black
TIME_A=`date +%s`
echo -e "$(black --version)"
black --check "$@"
TIME_B=`date +%s`
BLACK_PROCCESS_TIME=$((TIME_B-TIME_A))

# flake8
TIME_A=`date +%s`
echo -e "\nflake8 $(flake8 --version)"
flake8 "$@"
TIME_B=`date +%s`
FLAKE8_PROCCESS_TIME=$((TIME_B-TIME_A))

# mypy
TIME_A=`date +%s`
echo -e "\n$(mypy --version)"
for file_name in `find $@`; do
    if [ "py" == `basename $file_name | sed 's/^.*\.\([^\.]*\)$/\1/'` ];
    then
        python /module_finder.py $file_name
        mypy --check $file_name
    fi
done
TIME_B=`date +%s`
MYPY_PROCCESS_TIME=$((TIME_B-TIME_A))

# isort
TIME_A=`date +%s`
echo "$(isort --version)"
isort --check "$@"
TIME_B=`date +%s`
ISORT_PROCCESS_TIME=$((TIME_B-TIME_A))

echo ""
echo "##################################################"
echo "#                                                #"
echo "#                Complete pycheck                #"
echo "#                                                #"
echo "##################################################"

echo -e "\n\nProcess time\n"

echo "black: ${BLACK_PROCCESS_TIME}s"
echo "flake8: ${FLAKE8_PROCCESS_TIME}s"
echo "mypy: ${MYPY_PROCCESS_TIME}s"
echo "isort: ${ISORT_PROCCESS_TIME}s"

echo -e "\nfinish date: $(date)\n"
