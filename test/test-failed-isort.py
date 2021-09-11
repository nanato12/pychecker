import sys
import os


def test_success() -> None:
    print("success")


if __name__ == "__main__":
    test_success()
    print(os.getcwd())
    print(sys.argv)
