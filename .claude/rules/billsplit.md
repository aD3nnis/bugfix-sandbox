---
paths:
  - "billsplit/**"
---

# billsplit code

- Money is whole cents in an `int`. Don't use `float` or `round()` for amounts.
- Bad input raises `ValueError` with a message that names the argument.
- Every public function has a one-line docstring.
- A change to a function comes with a test in `billsplit/test_*.py` that fails without the change.
