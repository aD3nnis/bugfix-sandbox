# Handoff: split-remainder-cents
Date: 2026-11-15

## Goal
Fix the bug in `bug-report.md`: splitting $10.00 among 3 people charged $3.33 each, which totals $9.99 and loses a cent. This happened whenever the total didn't divide evenly. The user asked for the work on a new branch, not `main`.

## State
- Branch: `fix/split-remainder-cents` at `5bb3ee9 Give leftover cents to the first people in split_bill`
- Uncommitted: nothing: working tree clean
- Pushed: yes, tracking `origin/fix/split-remainder-cents` (`origin` is https://github.com/aD3nnis/bugfix-sandbox, a public repo)
- PR: https://github.com/aD3nnis/bugfix-sandbox/pull/1 "Give leftover cents to the first people in split_bill", open against `main`, not merged. No reviewer requested and no review decision. The repo has no CI workflows. The only status is `CodeRabbit: SUCCESS`, and its comment says it skipped the review because the repo has fewer than 10 stars. GitHub reports the PR as mergeable with no conflicts.

## Done
- Fixed `split_bill` in `billsplit/split.py`. It used `total_cents // people` and threw away the remainder. It now uses `divmod`, and the first `leftover` people each pay one extra cent, so the shares always add up to the total.
- Added two tests in `billsplit/test_split.py`, each of which fails without the fix: 1000 split 3 ways and 1000 split 7 ways.
- Ran `/code-review` at high effort (twice). The findings and what was done about each are in the PR body. The second run also posted its 2 findings as inline comments on the PR.
- Committed, pushed, and opened PR #1, with every section of `.github/pull_request_template.md` filled in.
- For a peer session, ran two hook checks that left no changes behind. (1) The PostToolUse lint hook (`.claude/hooks/lint.sh`) runs ruff on its own after each Edit. (2) The Stop hook (`.claude/hooks/check-tests.sh`) blocks the end of a turn while tests fail. Both deliberate breaks were undone.

## Files changed
- `billsplit/split.py`: committed in `5bb3ee9`. `split_bill` now hands out leftover cents instead of dropping them.
- `billsplit/test_split.py`: committed in `5bb3ee9`. Added `test_uneven_split_adds_up_to_total` and `test_several_cents_left_over_are_spread_out`.

## Proof
Reproduce command. "Before" was run against `main`'s `billsplit/` extracted to a temp folder; "after" was run on this branch:
```
$ python3 -c 'from billsplit.split import split_bill; s = split_bill(1000, 3); print(s, sum(s))'
before: [333, 333, 333] 999
after: [334, 333, 333] 1000
```
Tests and lint on this branch:
```
$ python3 -m unittest discover -p "test_*.py"
Ran 6 tests in 0.000s

OK
$ ruff check .
All checks passed!
```
The 7-way test against `main`'s `split.py`:
```
$ python3 -m unittest billsplit.test_split.SplitBillTest.test_several_cents_left_over_are_spread_out
Ran 1 test in 0.000s

FAILED (failures=1)
```
The 3-way test also failed before the fix was written. Not verified: the `main` branch protection ("require a pull request", "Do not allow bypassing"). The session that set it up reported that a direct push is refused, but this session didn't check it.

## Decisions and constraints
- **Leftover cents go to the first people in the list.** This keeps the result deterministic and matches the comment in the code. Don't switch to round-robin or random without asking.
- **Two review findings are out of scope, on the user's decision.** (1) A float `total_cents` raises a raw `TypeError` instead of a `ValueError` naming the argument. On `main` it returned float shares, so neither version is right. (2) The `total_cents < 0` guard has no test. The user said these aren't part of this bug. They're recorded as inline PR comments marked out of scope. Don't fix them in this PR.
- **Don't merge PR #1.** The user said so explicitly.
- **History was rewritten by another session.** At the user's request, the session "b4 LAST use ruff before step 2" rewrote every commit to use the user's GitHub no-reply email and set it as this repo's `user.email`. The fix commit was `6522274` and is now `5bb3ee9`. The old IDs don't exist anymore, so ignore any mention of them.
- `.claude/rules/billsplit.md` applies to `billsplit/**`: amounts are whole cents in an `int` (no `float` or `round()`), bad input raises a `ValueError` that names the argument, every public function has a one-line docstring, and every change to a function comes with a test that fails without it.

## Tried and abandoned
- none. The `divmod` fix worked on the first try.

## Next
1. Wait for the user to review PR #1. Check it with `gh pr view 1 --comments`. The repo has no CI and CodeRabbit won't review it, so a human review is the only gate.
2. If the user asks to merge, merge PR #1 through GitHub. `main` is protected, so a direct push is refused.
3. If the user wants the two out-of-scope findings fixed, do it on a new branch from `main` in a separate PR.

## Open questions
- Should the float-input `TypeError` and the missing negative-total test get a follow-up PR? The user decides.
- `/code-review medium --comment 1` loaded the high-effort instructions even though `medium` was typed. Why is unknown. It's worth checking if the review level matters.
