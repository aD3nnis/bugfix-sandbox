---
name: handoff
description: Save unfinished work for a fresh session to resume, as a dated file in handoffs/.
disable-model-invocation: true
argument-hint: "[topic]"
---

## Purpose

A handoff carries unfinished work across a memory reset. Some of what this session knows lives only in the conversation: why things were done, what was ruled out, what the user decided, what is verified and what isn't, what's waiting outside the repo, and what comes next. The repo doesn't hold any of that, so a fresh session would redo dead ends, undo decisions, or call unverified work done.

A handoff is for when both of these are true:
1. **The work is unfinished:** mid-fix, waiting on someone (a review, CI, an answer), or one step of a larger plan.
2. **The next step will happen with a fresh memory:** the user is stopping for the day, the context is getting full, they're switching machines, or someone else will pick it up.

## Check first

Before writing anything, check both conditions against this session:
- **Unfinished?** Look for uncommitted changes, a failing or unrun check, an open PR or pending CI, an open question, or a step the user said comes next. If everything is committed, verified, and nothing is pending, the work is finished: the commits and PR description already carry it, and a handoff would only bury an older, useful one as the "newest" file.
- **Fresh memory?** The user typing `/handoff` usually means yes. If they said they're continuing in this same session, it's no: suggest `/compact` instead.

If either condition fails, tell the user which one and why in a sentence, and ask whether they still want a handoff. Write it only if they say yes. If both hold, go ahead without asking.

## Writing it

Write a handoff to `handoffs/<YYYY-MM-DD>-<topic>.md` (today's date), using the structure in [template.md](template.md). Create `handoffs/` if it doesn't exist.

Topic: $ARGUMENTS (if empty, choose a short kebab-case topic from this session's goal).

The next session starts by reading the newest file at the top level of `handoffs/` (not `handoffs/archive/`) and nothing else from this conversation, so write for a reader who has the repo but not your memory. The date in the filename is what makes "newest" reliable; file modification times change when files are copied or checked out.

- Fill every section from what happened in this session. Write "none" in a section with nothing to report rather than dropping it, so the reader knows it was considered.
- **State:** run `git branch --show-current`, `git log -1 --oneline`, `git status --short`, and check whether the branch has an upstream. Record any PR, its CI status and reviewer from the conversation.
- **Files changed:** list every file from `git status --short`, plus every file changed in commits made during this session (use the commits you remember making, or `git log --since` the session's start, then `git show --stat <hash>`). Mark each one as committed (with the hash) or uncommitted.
- **Proof:** paste the actual commands and their output from this session as code blocks. Don't summarize them as "tests pass". If something was planned but not run, say so here rather than implying it passed.
- **Decisions and constraints / Tried and abandoned:** these are what a fresh session is most likely to get wrong, so record the reason with each one, not just the fact.
- If the file already exists, ask before overwriting it.
- After writing, offer to commit the handoff on its own. On a yes, commit only that file: `git add handoffs/<file>`, then `git commit -m "Add handoff: <topic>" -- handoffs/<file>`. Naming the file keeps any staged code changes out of this commit. Don't push.
