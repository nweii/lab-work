---
name: build-lab
description: "Set up a durable /lab section of design experiments in a website, or add shared canvases or freezing to an existing one."
disable-model-invocation: true
metadata:
  author: nweii
  version: "0.6.0"
  credit: "Lab-building patterns draw on DialKit by Josh Puckett, Emil Kowalski's prototype workflow, and shadcn/ui's sidebar building blocks."
---

# Build lab

This skill sets up a lab section in a website: the shell, the canvas, the freeze lifecycle, and the host's own facts in the project's agents file. Working in a lab afterwards, such as adding one, tuning it, or freezing it, belongs to the [lab-work skill](../lab-work/SKILL.md).

Read [../lab-work/SKILL.md](../lab-work/SKILL.md) before setup. It defines a lab and states the conventions the section must support. [../lab-work/GLOSSARY.md](../lab-work/GLOSSARY.md) defines the terms. Use each term as it is defined there.

Everything in this skill is a working default. Reshape its structure, tools, appearance, exposure, and lifecycle around the user's needs and the host codebase.

If the project has no `app`-style routing or the user wants a standalone playground, the host can be a bare app whose only content is `/lab`; its labs hold their own starting values. If the host already has a lab section, start at step 5 to add canvases or step 6 to add freezing.

## Section conventions

These apply to the section as a whole. The lab-work skill states the conventions for each lab.

- **Labs own the backdrop.** Keep every shell layer transparent across the content pane. An opaque shell layer covers a lab that paints a fixed or negative-z backdrop.
- **Exposure follows the host.** Public labs default to direct access, `noindex`, and omission from the sitemap and main navigation. Protected labs reuse the host's route protection or deployment infrastructure at the `/lab` boundary. `noindex` only asks crawlers to skip the section, so protect a private lab with access control. Read [references/access-control.md](references/access-control.md) when protection is selected or already exists.
- **The shell depends on labs' metadata only.** Labs import the canvas and nothing from the shell, so a replacement shell requires no lab edits.

## Shell design defaults

The shell makes labs easy to find and use, and draws less attention than their contents. Adapt these defaults to the user's needs, the host's design language, and the purpose of each lab.

- **Extend the site's design language.** When the host has an established visual system, reuse its tokens, components, typography, and interaction patterns. Diverge when that difference is part of the experiment.
- **Finish the shared chrome.** Give the shell production fit-and-finish even when an experiment is unfinished. Omit status badges, introductory eyebrows, and portfolio-style explanation unless the host uses them.
- **Quieter than content.** Build the shell from the host's design tokens at lower emphasis than content: muted text at rest, small type, no ornament.
- **Separate by tone.** Mark the sidebar/content boundary with a step between surface colors, plus a hairline at most.
- **One title line.** Define one title-line height and inset for the shell wordmark, collapsed trigger, and standard lab headers, and preserve it across wide, narrow, expanded, and collapsed states.
- **Raised surfaces are lighter (dark UIs).** Make a surface that rests on another, such as an active-item fill, lighter than its parent. Component-library dark defaults often invert this.
- **Dim stroke icons with solid colors.** Semi-transparent strokes brighten where an icon's paths overlap, so pick the solid gray that matches the intended level.
- **Complete every interaction state.** Give navigation, triggers, tabs, and buttons intentional rest, hover, focus-visible, pressed, and selected states with legible contrast in every supported appearance.
- **Restrained motion.** Slide the sidebar on an eased curve, animate reordered list items to their new slots, and fall back to cross-fades under reduced motion. Switch labs instantly, because it is the most frequent action.

## Setup

For a Next.js App Router host, read [references/nextjs-scaffold.md](references/nextjs-scaffold.md) before writing code. It holds the concrete module shapes and gotchas. For another router or a bare app, skip that reference and build from the conventions using the host's native route, module, and styling patterns.

1. **Recon the host.** Done when you can name the router, styling system, design tokens, any installed component and control-panel libraries, the site's existing route-protection pattern, the intended public or protected exposure, and every experiment route scattered elsewhere (debug routes, internal pages).
2. **Migrate strays.** Show the user the experiment routes the recon found and which ones would move. Move the ones the user approves into the lab directory with history-preserving renames (`git mv`), normalize each to the file split, and consolidate route gates at the section boundary according to the chosen exposure. Tell the user that the old URLs stop resolving. Done when every route from the recon has a migrated destination or a recorded reason to stay put.
3. **Build the registry seam.** Write one pure function that takes folder slugs plus optional metadata and returns the nav model. Put filesystem access and metadata imports in a thin loader beside the layout. Done when the registry has passing tests and the loader lists exactly the live and frozen lab folders.
4. **Build the shell.** Render the sidebar from the registry, set the chosen exposure once at the section boundary, and add `noindex` unless the user wants the lab discoverable. Reuse the host's navigation, component, and control systems. If a needed system is absent, choose an implementation suited to the stack with the user. When the host has no control panel, propose DialKit and install it once the user agrees. Read [../lab-work/references/dialkit.md](../lab-work/references/dialkit.md) and the installed DialKit version's documentation before wiring grouping, placement, appearance, actions, persistence, and export behavior. On a host with another control-panel library, read that library's documentation. Put host-specific extras (an internal dashboard or main-site link) in the sidebar footer, marked as host extensions outside the general pattern.
5. **Build the canvas.** Follow [../lab-work/references/canvases.md](../lab-work/references/canvases.md). Done when its verification passes.
6. **Add the lifecycle.** Follow [../lab-work/references/freezing.md](../lab-work/references/freezing.md): a record page at the lab URL, a quieter frozen group in the sidebar, and a script for freeze, snapshot, visit, thaw, and status. The record page is shared chrome, so it follows the shell design defaults: the standard title line, plain labels instead of eyebrows, and the host's tokens. Done when the planners have passing tests and one lab has been frozen, visited, and thawed in a scratch worktree, or the user has deferred the lifecycle. Use the copy-source fallback only for a host without git history, after telling the user its tradeoff.
7. **Update the host's agents file.** Merge the section in [references/agents-md-section.md](references/agents-md-section.md) into the project's `AGENTS.md` / `CLAUDE.md`. It records what is particular to this host. The lab-work skill supplies the conventions, so keep them out of the section. Done when the merged section contains no bracketed placeholders and its paths, libraries, and commands match what was built.
8. **Verify.** Done when: registry, loader, and lifecycle tests pass; the production build passes; the `/lab` index, every live lab, and every frozen lab's record page load in a browser with a clean console; metadata and discovery match the chosen exposure; protected sections block an unauthenticated request at the index and a nested lab; and the shared chrome passes one wide and one narrow viewport with the sidebar expanded, collapsed, and mobile. In those states, inspect title alignment, unexplained gaps or overlap, and every shell control's hover, focus-visible, pressed, and selected states in each supported appearance.

Completion criterion: every experiment route the recon found is migrated or accounted for, every sidebar entry resolves to a rendering lab, the agents-file section is placeholder-free and accurate, and every check in step 8 passes.
