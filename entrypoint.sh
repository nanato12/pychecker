#!/bin/sh -l

# color
ESC=$(printf '\033')
RESET="${ESC}[0m"

TARGET_PATH_COLOR="${ESC}[38;5;51m"
PYCHECKER_COLOR="${ESC}[38;5;190m"
VERSION_COLOR="${ESC}[38;5;69m"
SUCCESS_COLOR="${ESC}[38;5;120m"
TIME_COLOR="${ESC}[38;5;14m"
ERROR_COLOR="${ESC}[38;5;196m"

set -ea

echo -e "\nstart date: $(date)\n"

echo -e "${PYCHECKER_COLOR}"
echo "##################################################"
echo "#                                                #"
echo "#               Starting pychecker               #"
echo "#                                                #"
echo "##################################################"
echo -e "\n${RESET}"

echo -e "target path to check: ${TARGET_PATH_COLOR} $@ ${RESET}\n"

# python
echo -e "\n${VERSION_COLOR}$(python --version)${RESET}"

# pip
echo -e "${VERSION_COLOR}$(pip --version)${RESET}\n"

# black
TIME_A=`date +%s`
echo -e "${VERSION_COLOR}$(black --version)${RESET}"
black --check "$@"
TIME_B=`date +%s`
BLACK_PROCCESS_TIME=$((TIME_B-TIME_A))
echo -e "[black] ${SUCCESS_COLOR}success${RESET}"

# flake8
TIME_A=`date +%s`
echo -e "\n${VERSION_COLOR}flake8 $(flake8 --version)${RESET}"
flake8 "$@"
TIME_B=`date +%s`
FLAKE8_PROCCESS_TIME=$((TIME_B-TIME_A))
echo -e "[flake8] ${SUCCESS_COLOR}success${RESET}"

# mypy
set +e
TIME_A=`date +%s`
echo -e "\n${VERSION_COLOR}$(mypy --version)${RESET}"
for file_name in `find $@`; do
    file_ext=`basename $file_name | sed 's/^.*\.\([^\.]*\)$/\1/'`
    if [ -z $file_ext ] || [ "py" != $file_ext ];
    then
        continue
    fi
    echo -en "[mypy] check: ${file_name}"
    result=$(mypy --check --install-types --non-interactive $file_name)
    if [ $? == 0 ];
    then
        echo -e "  ${SUCCESS_COLOR}success${RESET}"
    else
        echo -e "\n${ERROR_COLOR}$result${RESET}"
        exit 1
    fi
done
TIME_B=`date +%s`
MYPY_PROCCESS_TIME=$((TIME_B-TIME_A))
set -e

# isort
TIME_A=`date +%s`
echo -e "${VERSION_COLOR}$(isort --version)${RESET}\n"
for file_name in `find $@`; do
    file_ext=`basename $file_name | sed 's/^.*\.\([^\.]*\)$/\1/'`
    if [ -z $file_ext ] || [ "py" != $file_ext ];
    then
        continue
    fi
    echo -n "[isort] check: ${file_name}"
    isort --check $file_name
    echo -e "  ${SUCCESS_COLOR}success${RESET}"
done
TIME_B=`date +%s`
ISORT_PROCCESS_TIME=$((TIME_B-TIME_A))

echo -e "${PYCHECKER_COLOR}"
echo "##################################################"
echo "#                                                #"
echo "#               Complete pychecker               #"
echo "#                                                #"
echo "##################################################"
echo -e "${RESET}"

echo -e "${TIME_COLOR}"
echo "black: ${BLACK_PROCCESS_TIME}s"
echo "flake8: ${FLAKE8_PROCCESS_TIME}s"
echo "mypy: ${MYPY_PROCCESS_TIME}s"
echo "isort: ${ISORT_PROCCESS_TIME}s"
echo -e "${RESET}"

echo -e "\nfinish date: $(date)\n"
