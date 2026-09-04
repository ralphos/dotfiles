---
name: handoff
description: Create a handoff document at the end of a work session so a fresh session (or another agent) can resume with full context. Writes a date-prefixed file into thoughts/handoffs/ — the same file /catchup reads first. Use when the user says "/handoff", "write a handoff", "wrap up this session", or before ending a long working session with meaningful state.
---

# Create Handoff

Write a handoff document transferring this session's work to a future session.
Thorough but **concise**: compact your context without losing the key details.
The handoff is the highest-leverage document in a project — `/catchup` reads
the newest one *first* in every fresh session, so write for an agent (or the
user) who has none of your context.

This skill is user-level — it runs in any repo. Adapt to the project's
conventions; never invent structure the project doesn't have.

## Process

### 1. Gather state (don't guess — run these)

- `git log --oneline -15` · `git status --short` · `git branch --show-current`
- Unpushed count (`git log origin/<default>..HEAD --oneline | wc -l`) —
  **unpushed commits are state**; always report them
- Current date/time for the filename and frontmatter
- If the project has a plan/backlog (`IMPLEMENTATION_PLAN.md`,
  `thoughts/plans/`, `TODO.md`…), skim its checkboxes — status is expressed
  against the plan's phases/slices/items, not vague prose

### 2. Filepath

`thoughts/handoffs/YYYY-MM-DD-<kebab-description>.md`

- Create `thoughts/handoffs/` if the project doesn't have it yet (it's the
  convention `/catchup` reads). If the project keeps handoffs somewhere else
  already, follow the project.
- Date-prefixed so the newest sorts last. If one already exists for today,
  append the time: `YYYY-MM-DD-HHMM-<description>.md`.

### 3. Write the document

```markdown
---
date: [ISO 8601 with timezone]
git_commit: [current HEAD short hash]
branch: [branch]
unpushed: [N commits not on origin, or "none"]
topic: "[one-line description of the session's work]"
status: [complete | in-progress handoff]
---

# Handoff: {very concise description}

## TL;DR — where things stand
{2–4 sentences: what state is the project in RIGHT NOW, and the single most
likely next action. Lead with this — it's what /catchup quotes.}

## Task(s)
{Each task with status: done / in progress / planned. Express against the
project's plan phases/slices/items where a plan exists ("slice A3: charter ✓,
spine in progress — beat partials render, expand/collapse not started").
Reference the plan/spec/research docs you were working from.}

## Critical references
{The 2–4 docs the next session MUST read before acting (the relevant spec or
design doc, the quality bar, the plan section). List what's load-bearing, not
everything.}

## Decisions made this session
{Decisions and WHERE each was recorded (the spec's decisions section, an ADR,
the plan). If a decision was made but NOT yet recorded anywhere durable, flag
that loudly — it's a defect to fix, not a footnote.}

## Recent changes
{What changed, as `path/to/file.ext:line` references and commit hashes.
References over snippets.}

## Learnings & gotchas
{What the next session would otherwise rediscover the hard way: patterns, root
causes, environment quirks, guardrail behaviours (e.g. actions auto-mode
blocks and must go to the human), flaky areas, "the doc says X but reality is
Y" findings.}

## Artifacts
{Exhaustive list of files produced/updated this session, as paths.}

## Action items & next steps
{Ordered list for the next session. Specific — "Start slice A4: read
specs/03-discover.md, then …" beats "continue with discover". Include any
blockers/open questions and who answers them.}

## Other notes
{Anything useful that fits nowhere above: where relevant code lives, costs,
open PRs/CI state, links. Omit if empty.}
```

### 4. Commit

Commit the handoff (it's part of the repo's memory):
`git add thoughts/handoffs/ && git commit -m "Add handoff: <description>"`
Do **not** push unless the user has authorized pushes this session.

### 5. Respond

Reply with exactly this shape:

> Handoff written and committed: `thoughts/handoffs/<filename>`
>
> Resume in a fresh session with **`/catchup`** — it reads the newest handoff
> first. {One sentence: the single next action it will recommend.}

## Guidelines

- **More information, not less** — the template is the minimum, not the ceiling.
- **Be precise**: top-level objectives AND the low-level details that resume
  work mid-task (which test was red, which file was half-edited).
- **Avoid code dumps**: `path/to/file.rb:12-24` references over snippets;
  include a snippet only when it IS the point (e.g. the exact failing assertion).
- **Honesty over tidiness**: failing tests, skipped steps, and unverified work
  go in as-is. A handoff that says "all good" when it isn't poisons the next
  session.
- **Project-specific pre-flight**: before writing, check whatever ledgers the
  project keeps — a schema-delta register, a decisions section in the master
  spec, a quality baseline — and verify this session's changes are recorded
  there (e.g. in thy.news: `specs/01-data-model.md` §11 deltas, `specs/spec.md`
  §11 decisions, suite/lint green or not — say so either way).
