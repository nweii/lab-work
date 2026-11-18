# Lab work

Agent skills for keeping a design lab inside your own site. A lab is a page where you try a design idea on the site's real components, decide by watching it run, and keep a record of what you decided.

Design decisions about a running product often get made in a throwaway branch or a chat with an agent, and the reasons are lost once the change ships. A lab keeps the experiment beside the product. You open `/lab/footer`, switch between the footer that ships and two proposals, move sliders until the spacing is right, and tell your agent which one to ship. The agent moves the code into production and writes down what you chose.

You tune and decide. The agent builds the lab, sets starting points you can change while using it, and applies what you decide.

This project is early. The skills have set up and run one site's lab section, so expect their terms and steps to change as they run on more.

## What a lab is for

A lab suits any design decision you want to tune in a dedicated space, with [DialKit](https://github.com/joshpuckett/dialkit) controls on the real component. Some examples:

- Tune a feel, such as a ripple that runs too fast, with controls on the production component.
- Redesign something that ships by switching between the current version and your proposals, in the page they ship into.
- Design something new by comparing a few directions, choosing one, and tuning it.
- Check that a design holds up under hover, focus, dark theme, a long title, and phone width, all on one board.
- Tune motion by replaying, pausing, and scrubbing a timeline.
- Tune one scale, such as spacing, across every component that uses it.
- Reopen a decided lab later to read what you decided and see captures of it running.

## How it fits together

The `build-lab` skill builds a `/lab` section in your site: a sidebar that lists every lab, a shared canvas, and a script for freezing decided labs. Each lab is a folder with a page.

- A lab renders in one of three canvas layouts. A stage centers one subject, a board puts several items on one grid, and a full bleed lab fills the pane.
- DialKit, by Josh Puckett, is the control panel. You save versions to compare and press **Copy** to hand values to your agent.
- When the subject already ships, the lab keeps the current version as a variant, so every proposal is judged against it.
- Promoting a proposal moves its code into production. The lab then imports it from there.
- Freezing a decided lab removes its code and keeps the outcome, captures of it running, and the commit to revisit.

Setup also records your site's own facts in the project's agents file, such as where labs live and which control panel they use. The `lab-work` skill holds the conventions, so they update with the plugin and your agents file stays short. [GLOSSARY.md](skills/lab-work/GLOSSARY.md) defines every term.

## Skills

| Skill | Use it to |
| --- | --- |
| `build-lab` | Set up the lab section in a site, or add shared canvases or freezing to an existing one. You start it. |
| `lab-work` | Add a lab, wire its controls, apply a decision, promote a variant, or freeze a decided lab. Your agent loads it when you ask for a lab. |

## What it assumes

- A website or app whose routes are folders. The skill includes a scaffold for the Next.js App Router and builds from its conventions on other routers.
- An agent that can read and edit the project, run it, and open it in a browser.
- DialKit for controls. On a project that already uses another panel library, the skill maps its uses onto that library.

## Install

For Codex, run these commands in your terminal.

```bash
codex plugin marketplace add nweii/lab-work
codex plugin add lab-work@lab-work
```

For Claude Code, run these commands in a session.

```text
/plugin marketplace add nweii/lab-work
/plugin install lab-work@lab-work
```

To install the skill directly, use the [skills CLI](https://github.com/vercel-labs/skills).

```bash
bunx skills add nweii/lab-work -g -a claude-code codex
```

Start with `/build-lab` in the project you want a lab in. It does not run automatically. After setup, ask your agent for a lab and it loads `lab-work`.

## Credits

The lab pattern draws on DialKit by Josh Puckett, Emil Kowalski's prototype workflow, and shadcn/ui's sidebar building blocks. The conditions board follows [Raphael Salaja's `lab.js`](https://github.com/raphaelsalaja/skills/tree/main/skills/lab).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT. See [LICENSE](LICENSE).
