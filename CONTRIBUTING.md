# Contributing

Reports from real use help most. If you ran the skill on a site, open an issue that says what the site is built with, what you asked for, and where the result differed from what you expected. A screenshot of the lab helps.

## Proposing a change

Start from a situation someone is in. "I was redesigning a footer and could not compare it with the one that ships" leads to a better change than "add a comparison mode". Say what the person wants to do, then what the skill does today.

A change to the skill's text should follow these rules:

- **Use the glossary.** [GLOSSARY.md](skills/build-lab/GLOSSARY.md) gives each term one meaning. If a change needs a new term or shifts an old one, edit the glossary in the same pull request.
- **Give a reason and an example.** The skill relies on the agent's judgment. A rule with its reason and a "for instance" holds up better than a list of every case.
- **Leave the user's choices to the user.** Where the panel sits and whether it remembers values are choices the user makes while using a lab. The skill sets starting points.
- **Use what the control panel has.** Add a lab feature only where DialKit has none.
- **Keep the two statements in step.** `SKILL.md` states the conventions, and `references/agents-md-section.md` restates them for the host project. Change both.
- **Write plainly.** Use sentence case headings, active voice, and whole sentences. Leave out em dashes and figures of speech.

## Before opening a pull request

- Add a line under `Unreleased` in [CHANGELOG.md](CHANGELOG.md).
- Check that every relative link points at a file and heading that exist.
- If you ran the changed skill on a site, say so and say what you saw. If you did not, say that.

Version numbers are bumped at release, in every manifest and in the skill's `metadata.version` together.
