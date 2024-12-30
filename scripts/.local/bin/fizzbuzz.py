#!/usr/bin/env python


def fizzbuzz(num: int) -> None:
    out = ""
    if num % 3 == 0:
        out += "fizz"
    if num % 5 == 0:
        out += "buzz"
    if num % 7 == 0:
        out += "bazz"
    if not out:
        print(num)
    else:
        print(out)


for num in range(1, 101):
    fizzbuzz(num)
