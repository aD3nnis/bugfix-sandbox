# <Project name>

<One sentence: what this project does, and its main language and framework.>

## Commands
- Run all tests: `<test command>`
- Run one test file: `<test command> <path>`
- Lint: `<lint command>`

## Conventions
- Tests live next to the code they test, named `<test file pattern>`.
- When opening a PR, read `.github/pull_request_template.md` and fill in every section in the PR body.

## Sessions
- At the start of a session, read the newest handoff at the top level of `handoffs/` if there is one. Don't look in `handoffs/archive/`: if the top level is empty, there's no work to pick up. Files are named `YYYY-MM-DD-<topic>.md`, so "newest" means the latest date in the filename, not the file's modification time. If two share the latest date, read both.
- Before acting on a handoff, compare its State section (branch, latest commit, uncommitted files) with `git status` and `git log`. Ignore the handoff files themselves and commits that only change files in `handoffs/`: writing, committing and archiving handoffs isn't the work moving on. If they differ, the work may have moved on since it was written: tell the user what differs before following its Next steps.

## Compact Instructions
- When writing the summary, keep which handoff this session started from, and which of its Next steps are done.
- After compacting, start your next message with **CONTEXT COMPACTED** on its own line, then list what you re-read below.
- After compacting, and before editing more files, re-read:
  - the CLAUDE.md of any folder you are working in (not the fake repos under `.claude/skills/*/evals/*/files/`),
  - any `.claude/rules/` file whose `paths:` match files you are reading or editing,
  - the newest handoff at the top level of `handoffs/`, for its decisions and dead ends. This session's progress since then comes from the summary, not from the handoff.
