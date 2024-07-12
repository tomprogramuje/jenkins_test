import pytest
from main import add2num


def test_add2num():
    res = add2num(2, 3)
    assert res == 5
