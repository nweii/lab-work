# Agents-file section template

Merge this into the host project's `AGENTS.md` / `CLAUDE.md` during setup, adapted to the paths, libraries, and shell that were built.

The section records what is particular to this host. The lab-work skill states the conventions every lab section shares, so leave them out. A convention copied here stops matching the skill once either changes. Add a convention only where this host departs from the skill, and say that it departs.

Replace bracketed placeholders, and drop lines that don't apply.

```markdown
### Labs (`/lab`)

`[app/lab/<slug>/]` holds this site's labs. A lab is a page where the user decides something about a subject, such as a component, a section, or a motion, by watching it run and changing it. Labs are kept for retuning and as design history.

Use the `lab-work` skill for any work in a lab. It states the conventions, and this section states what is particular to this site. Where the two differ, this section wins.

Without the skill: a folder with a `[page.tsx]` is a lab and appears in the sidebar. A lab imports its subject and starting values from production and nothing from the shell, and production imports nothing from a lab. The user tunes and decides. The agent applies the decision to production and records it as the lab's outcome. Decided labs are frozen, never deleted.

- **Files**: `[page.tsx]` (thin server wrapper), `[lab.tsx]` (client component with the controls), and an optional `[meta.ts]` that default-exports a `[LabMeta]` from `[lib/lab-registry.ts]`.
- **Shell**: `[app/lab/layout.tsx]`, `[LabNav.tsx]`, `[entries.ts]`, `[app/lab/[slug]/]`. The registry (`[lib/lab-registry.ts]`) is a pure, tested module, so keep its tests passing.
- **Canvas**: `[the canvas module]`, with the layouts `[stage, board, full bleed]`. [How this host forces conditions and holds pseudo-classes on a conditions board.]
- **Control panel**: `[DialKit <version>, or the project's own control-panel library]`. Create panels through `[the host's panel hook]`, which persists values and saved versions and follows production when its defaults change.
- **Taste**: `[this project's design docs and tokens]`, then the user's own taste where those are silent.
- **Exposure**: [public direct-access, protected by the host's existing mechanism, or another deliberate posture], applied once at `[the lab section boundary]`. The section is `[noindex and omitted from the sitemap and main navigation / intentionally discoverable]`. [The command that verifies protection.]
- **Lifecycle**: `[bun run lab]` (`[scripts/lab.ts]`) runs `status`, `freeze`, `snapshot`, `visit`, and `thaw`. It never commits; review its diff and commit it.
- **Accidental differences found here**: [each difference between the lab and a destination this host has found, and its fix.]
- **Other work hosted in labs**: [kinds of work this project allows in the lab, and what each must state.]
- **Departures from the skill**: [any convention this host changes, and why.]
```
