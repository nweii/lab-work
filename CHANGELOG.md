# Changelog

All notable changes to this plugin are recorded here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and versions follow [Semantic Versioning](https://semver.org/).

## Unreleased

## 0.6.1 - 2026-11-18

### Changed

- Panels persist values and saved versions under a stable id and follow production. One host hook moves the base version when production's defaults change, keeps saved versions, and keeps unaccepted values as a saved version. This replaces leaving `persist` off.

## 0.6.0 - 2026-11-18

To bring a lab section set up with 0.5.0 up to this release: replace the Labs section of the project's agents file with the shorter template, keeping the host's own facts.

### Added

- A `lab-work` skill for working in a lab: adding one, wiring controls, applying a decision, promoting, and freezing. An agent loads it when the user asks for a lab.

### Changed

- `build-lab` covers setup only. The conventions, the glossary, and the references for controls, canvases, variants, hosting, promotion, and freezing moved to `lab-work`.
- The section setup writes into a host's agents file holds the host's own facts and a short fallback. It no longer restates the conventions.
- How work divides into labs is stated as the user's call.
- The glossary defines a condition by its role in the decision.
- A board's items are places one subject shows, or one subject under several conditions.

## 0.5.0 - 2026-11-10

To bring a lab section set up with 0.4.0 up to this release: merge the updated agents-file section, name each production subject's variant `current`, and rename any all-states view to a conditions board.

### Added

- `GLOSSARY.md`, which gives each term one meaning.
- A variant named `current` for a subject that exists in production, so each proposal is compared with what ships.
- A plugin of its own, with a README, a contributing guide, and manifests for Claude Code and Codex.

### Changed

- Current and proposed variants replace tuning and exploring labs.
- The all-states view is a conditions board: a stage lab switches to a board that shows its subject under several conditions, which cover themes, content extremes, and widths as well as interaction states.
- Judging a variant in its destination comes before the decision. Promotion ends by confirming the destination shows what the lab showed.
- "State" means live or frozen. A component's hover or disabled state is a condition.

## 0.4.0 - 2026-11-10

### Added

- Shared canvas layouts (stage, board, full bleed) in one module outside the shell.
- An all-states view.
- Promotion of a subject from a lab into production, and guidance on how a lab differs from its destination.
- DialKit as the default control panel, with a reference that maps what the user wants in a lab to DialKit features.

### Changed

- The user tunes and decides, and the agent builds and applies.

## 0.3.1 and earlier

Released as part of another plugin. These versions added the lab section, the freeze lifecycle (freeze, snapshot, visit, thaw), and the adapter for hosting other skills' work in a lab.
