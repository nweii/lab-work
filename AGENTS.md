# Lab work

This repository is an agent plugin. Its skill sets up and maintains a lab section in a website: pages where the user decides something about a subject by watching it run and changing it.

## Layout

- `skills/build-lab/SKILL.md` states the conventions and the setup steps. `references/` holds what each step or convention needs, loaded when the skill points to it.
- `skills/build-lab/GLOSSARY.md` gives each term one meaning. It lives inside the skill so an installed copy carries it.
- `skills/build-lab/references/agents-md-section.md` restates the conventions for the host project's agents file. Mirror every change to a convention in both places.
- `skills/build-lab/agents/openai.yaml` sets `allow_implicit_invocation: false` for Codex, and the skill sets `disable-model-invocation: true` for Claude Code. Keep the two in step.
- `plugin.json`, `.claude-plugin/`, and `.codex-plugin/` are the plugin manifests.

## Writing the skill

- Start a change from a situation the user is in, then say what the skill does today.
- Use each term as the glossary defines it. Edit the glossary in the same change when a term is added or shifts.
- Give a rule its reason and a "for instance". The skill relies on the agent's judgment, so avoid lists of every case.
- Judge a rule from the lab user's side. A choice the user makes while using a lab, such as where the panel sits, is theirs. The skill sets starting points.
- Use what DialKit provides before describing a lab feature that does the same job. Read DialKit's current documentation before changing `references/dialkit.md`, because DialKit changes often.
- Keep the skill person-neutral. It speaks of "the user" and "the host". A project's own paths and choices belong in that project's agents file.
- Write plainly: sentence case headings, active voice, whole sentences, no em dashes, no figures of speech.

## Releasing

Bump the version in every manifest (`plugin.json`, `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`, `.codex-plugin/plugin.json`) and in the skill's `metadata.version` together. Move the `Unreleased` entries in `CHANGELOG.md` under the new version and date, and tag the release as `v<version>`.

Record each change under `Unreleased` in the commit that makes it.

## Validating

```bash
bunx skills add . --list        # discovers exactly the skills under skills/
claude plugin validate .        # when the Claude CLI is available
```

Check that every relative Markdown link points at a file and heading that exist.
