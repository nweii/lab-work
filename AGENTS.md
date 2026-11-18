# Lab work

This repository is an agent plugin. Its skills set up a lab section in a website and work in it. A lab is a page where the user decides something about a subject by watching it run and changing it.

## Layout

- `skills/build-lab/` sets up a lab section, once per site. The user starts it, so it sets `disable-model-invocation: true` for Claude Code and `allow_implicit_invocation: false` in `agents/openai.yaml` for Codex. Keep the two in step.
- `skills/lab-work/` covers work in a lab: adding one, wiring controls, applying a decision, promoting, and freezing. An agent loads it when the user asks for a lab, so both settings allow that. Its `SKILL.md` is the one statement of the conventions.
- `skills/lab-work/GLOSSARY.md` gives each term one meaning. It lives inside the skill so an installed copy carries it.
- Each skill's `references/` holds what a step or convention needs, loaded when the skill points to it.
- `skills/build-lab/references/agents-md-section.md` is the section setup writes into the host project's agents file. It holds the host's own facts and a short fallback. Keep conventions out of it, because a copy in a host stops matching the skill.
- The two skills link to each other by relative path (`../lab-work/SKILL.md`), so they install together as one plugin.
- `plugin.json`, `.claude-plugin/`, and `.codex-plugin/` are the plugin manifests.

## Writing the skill

- Place a rule by what it acts on. A rule about the lab section as a whole belongs in `build-lab`, and a rule about one lab belongs in `lab-work`.
- Start a change from a situation the user is in, then say what the skill does today.
- Use each term as the glossary defines it. Edit the glossary in the same change when a term is added or shifts.
- Give a rule its reason and a "for instance". The skill relies on the agent's judgment, so avoid lists of every case.
- Judge a rule from the lab user's side. A choice the user makes while using a lab, such as where the panel sits, is theirs. The skill sets starting points.
- Use what DialKit provides before describing a lab feature that does the same job. Read DialKit's current documentation before changing `skills/lab-work/references/dialkit.md`, because DialKit changes often.
- Keep the skills person-neutral. They speak of "the user" and "the host". A project's own paths and choices belong in that project's agents file.
- Write plainly: sentence case headings, active voice, whole sentences, no em dashes, no figures of speech.

## Releasing

Record each change under `Unreleased` in `CHANGELOG.md` in the commit that makes it.

To release, make one commit that does both of these:

- Bump the version in every manifest (`plugin.json`, `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`, `.codex-plugin/plugin.json`) and in each skill's `metadata.version` together.
- Move the `Unreleased` entries in `CHANGELOG.md` under a `## <version> - <date>` heading.

Run `scripts/release.sh --check` before pushing. It fails when the versions disagree or the changelog has no section for the version, and prints the release notes otherwise.

Pushing that commit to `main` is the release. The Release workflow creates the tag `v<version>` and a GitHub release whose notes are that changelog section. Never create the tag by hand. Give a breaking change a line at the top of its changelog section that says how to move an existing lab section across.

## Validating

```bash
bunx skills add . --list        # discovers exactly the skills under skills/
claude plugin validate .        # when the Claude CLI is available
```

Check that every relative Markdown link points at a file and heading that exist.
