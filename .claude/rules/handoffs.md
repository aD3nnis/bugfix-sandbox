---
paths:
  - "handoffs/**"
---

# Handoff files

A handoff is a snapshot: it records what was true when it was written. Handoffs for unfinished work sit at the top level of `handoffs/`. Finished or replaced ones move to `handoffs/archive/<YYYY-MM>/`.

## Reading a handoff
- Its Proof section is output from an earlier session, not from now. Don't report anything as passing because the handoff says it did: re-run the check, or say it hasn't been re-run.
- Handoffs in `archive/` describe finished or replaced work. Use them for history, not as a list of things to do.

## Changing handoffs
- Don't edit an existing handoff to bring it up to date. If the work has moved on, suggest the user run `/handoff` to write a new dated one.
- If the user asks you to change an existing handoff, change only the part they asked about.
- Don't rename or delete a handoff: the date in the filename decides which one is newest. The one move allowed is archiving, below.

## Archiving
- Offer to archive a top-level handoff when its work is finished (its PR is merged, or every step in its Next section is done and checked) or when a newer handoff covers the same work. Name the file and the reason, and wait for the user's yes.
- Move it to `handoffs/archive/<YYYY-MM>/`, taking `<YYYY-MM>` from the date in its filename, not today's date. Create the month folder if it doesn't exist, and keep the filename unchanged.
- Use `git mv` so git records a move, not a delete plus a new file. If the handoff isn't tracked by git yet, use a plain move.
- Don't commit the move unless the user asks.
