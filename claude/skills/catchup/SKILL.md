---
name: catchup
description: Get oriented in the current project at the start of a session — and validate that reality still matches the record. Reads the newest handoff in thoughts/handoffs/ (or a given path), the active plan, IMPLEMENTATION_PLAN.md, CLAUDE.md, README and git state; verifies the handoff's claims against the actual repo; then reports the state of play, classifies the continuation scenario, and proposes next actions WITHOUT starting any work. Use when the user says "/catchup", "catch me up", "resume from <handoff>", "get oriented", "where are we", or opens a fresh session.
---

# Catch up (orient → validate → propose)

Orient yourself in whatever project the session is rooted in, **verify the
record against reality**, and report. **Do not start building or editing
anything** — end by proposing next actions and waiting for the user's
confirmation.

**Context discipline — the reason this skill delegates.** The main session
carries everything it reads forward into the whole working session that
follows. Orientation reads (handoffs, plans, specs, sweeps) are consumed once
and then dead weight — so they belong in subagents, whose contexts are thrown
away. Only the compact briefings they return should land in the main context.
Do the heavy reading in subagents; keep your own turns to spawning, the
briefing, and the report.

This skill is user-level, so it runs in any repo. Project conventions vary —
have the agents read what exists, skip what doesn't, never invent structure
that isn't there.

## Invocation

- `/catchup` — default: resume from the **newest** handoff (date-prefixed
  names sort newest-last; fall back to mtime).
- `/catchup <path-to-handoff>` — resume from a specific handoff.
- No handoffs at all? Tell the orientation agent to orient from the plan /
  backlog / README alone — and say plainly in your report that no handoff
  exists.

## Phase 1 — Locate (cheap; the only main-session gathering)

One Bash call: list `thoughts/handoffs/` (or take the given path) and pick the
handoff. Do not read it yourself — pass its path to the agents.

## Phase 2 — Delegate (both agents in ONE turn, in parallel)

**Agent A — orientation + validation** (general-purpose). Give it the handoff
path and this mandate verbatim, plus the briefing contract below:

> Read the handoff FULLY (no limit/offset). Read the 2–4 docs it marks as
> critical references. Skim the standing docs: the active plan/backlog
> (`IMPLEMENTATION_PLAN.md`, `thoughts/plans/` highest-numbered,
> `TODO.md`/`ROADMAP.md`), `CLAUDE.md`/`.claude/CLAUDE.md`, README top.
> Gather repo state: `git log --oneline -15`, `git status --short`,
> `git branch --show-current`, unpushed count vs origin, `gh pr list -L 10`
> if authed. Then VALIDATE — never assume the handoff matches reality:
> commits since its `git_commit`? Uncommitted/unpushed drift? Do its "recent
> changes" file refs still exist? Do plan checkboxes agree with its claimed
> statuses? Were "decisions made" actually recorded where it says? If it
> claims tests/lint green, do NOT run suites — report "claimed green, not
> re-verified". Classify the continuation scenario:
> clean continuation (no commits since, claims verify) · diverged
> (commits/changes since) · incomplete work (tasks in-progress) · stale
> (old date / major refactors since).

**Agent B — artifact sweep** (Explore, medium breadth): "Read the handoff at
<path>; for every file in its Artifacts section, confirm it exists and return
a one-line summary + any surprise (missing, empty, moved, obviously stale)."

### The briefing contract (give to Agent A)

Return ONLY this briefing, ≤120 lines — it is consumed by another agent, not
a human:

- **TL;DR** — 2–3 sentences: where the project stands, what's next.
- **Scenario** — one of the four, with the one-line signal.
- **Verification table** — each material handoff claim → verified / diverged /
  missing, one line each.
- **Repo state** — branch, last 5 commits one-line, dirty/unpushed counts,
  open PRs / red CI.
- **Learnings & gotchas — VERBATIM** — copy the handoff's learnings section
  word-for-word; do not summarize (this is the next session's inherited
  wisdom; paraphrase loses the detail that makes it actionable).
- **Action items & open decisions — VERBATIM** — same rule.
- **Watch-outs** — environment rules, guardrails, flaky areas (from any doc).
- **Surprises** — anything contradicting the handoff or the user's likely
  expectations.

## Phase 3 — Cross-check & report

Sanity-check the briefings against each other (do the two agents disagree?
did either return thin/missing sections?). Chase a contradiction with one
cheap targeted check (a `git log` or a grep) — not by re-reading the docs.

Then report — tight, scannable, state of play in ~20 seconds:

- **Where we are** — 1–2 sentences (the TL;DR, corrected by validation).
- **Verification** — claims → verified/diverged/missing where it matters; the
  scenario classification, stated plainly.
- **Last activity** — recent commits, uncommitted/unpushed state, red CI.
- **Learnings to honor** — the gotchas that still apply (don't bury them).
- **Open items** — unchecked plan boxes / action items / open decisions and
  who owns them.
- **Watch-outs** — environment rules, guardrail behaviours, flaky areas.

## Phase 4 — Propose & wait

1. **Recommended next actions** — 1–3, ordered, specific ("Start slice A4:
   read specs/03-discover.md, then …" — not "continue").
2. If resuming work is likely, **create a task list** (TaskCreate) from the
   briefing's action items + anything validation surfaced; show it.
3. **Ask** — "Proceed with [action 1], or adjust?" — and **wait**. Do not act
   until the user confirms.

## Guidelines

- **Validate before acting** — a handoff that says "all green" and a repo that
  disagrees is a finding, not an inconvenience.
- **Honor the learnings** — apply documented patterns, don't re-trip recorded
  mistakes; cite the handoff when its wisdom changes your approach.
- **Stay read-only until confirmed** — gather/validate freely; mutate nothing.
- **Fallback when delegation fails** — if an agent errors, times out, or
  returns a briefing missing required sections (handoffs have recorded exactly
  this during API incidents), read the handoff yourself with Read and proceed
  with the old inline flow rather than reporting nothing. A complete catchup
  beats a cheap one.
- **Don't re-read what the briefing already tells you** — the deliverable of
  Phase 2 is trust in the briefing; only verify on contradiction.
- When orientation material is thin, say what the briefing was based on and
  what couldn't be found.
- **Close the loop**: when the resumed session ends with meaningful state,
  suggest `/handoff` (its writing half) if the project has it.
