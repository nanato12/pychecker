import os
import sys


def test_success() -> None:
    print("success")
    success = 1


if __name__ == "__main__":
    test_success()
    print(os.getcwd())
    print(sys.argv)
