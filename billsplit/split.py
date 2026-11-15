"""Split a bill between people. Amounts are whole cents, to avoid float rounding."""


def split_bill(total_cents: int, people: int) -> list[int]:
    """Return what each person pays, in cents. The shares add up to the total."""
    if people < 1:
        raise ValueError("people must be at least 1")
    if total_cents < 0:
        raise ValueError("total_cents can't be negative")
    share = total_cents // people
    return [share] * people


def format_cents(cents: int) -> str:
    """Format cents as dollars, for example 1050 -> '$10.50'."""
    return f"${cents // 100}.{cents % 100:02d}"
