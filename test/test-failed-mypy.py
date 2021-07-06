import os
import sys


def test_success() -> str:
    print("success")


if __name__ == "__main__":
    test_success()
    print(os.getcwd())
    print(sys.argv)
