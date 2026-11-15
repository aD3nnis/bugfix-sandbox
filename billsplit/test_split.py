import unittest

from billsplit.split import format_cents, split_bill


class SplitBillTest(unittest.TestCase):
    def test_even_split(self):
        self.assertEqual(split_bill(1000, 4), [250, 250, 250, 250])

    def test_one_person_pays_everything(self):
        self.assertEqual(split_bill(1999, 1), [1999])

    def test_no_people_is_an_error(self):
        with self.assertRaises(ValueError):
            split_bill(1000, 0)


class FormatCentsTest(unittest.TestCase):
    def test_pads_cents(self):
        self.assertEqual(format_cents(1005), "$10.05")


if __name__ == "__main__":
    unittest.main()
