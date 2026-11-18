---
name: lab-work
description: "Work in a site's /lab section: add a lab, wire its controls, compare variants, check a subject under conditions, apply a decision, promote a variant, or freeze a decided lab. Use when the user asks for a lab or works on one."
metadata:
  author: nweii
  version: "0.5.0"
  credit: "Lab-building patterns draw on DialKit by Josh Puckett, Emil Kowalski's prototype workflow, and shadcn/ui's sidebar building blocks."
---

# Lab work

A **lab** is a page inside a website the user runs where a design idea is built against the production components and tuned with live controls. The user keeps labs to revisit them and as design history. The `/lab` section holds the labs, with a sidebar to move between them.

The user tunes and decides in a lab. The agent builds it, sets starting points the user can change while using it, and applies what the user decides.

[GLOSSARY.md](GLOSSARY.md) defines the terms used here. Use each term as it is defined there.

## Find the host's lab section

This skill states the conventions every lab section shares. The host project's agents file states what is particular to this site: where labs live, the file names, the canvas module, the control-panel library, the lifecycle command, and what the host has learned. Read its Labs section before working. Where the two differ, the host's section wins, because the user shaped it.

When the project has no lab section, tell the user and offer `/build-lab`, which sets one up. Build a lab outside a lab section only when the user asks for that.

## Working defaults

Everything here is a working default. Reshape it around the user's needs and the host codebase. Keep labs by default: record settled decisions in outcome metadata and freeze decided labs. Remove a lab only when the user or the host's lifecycle calls for it.

How work divides into labs is the user's call. One lab can hold one decision about a subject or several. Help the user think it through when the question comes up, for instance when a second decision would crowd a lab's controls or its outcome.

## The conventions

- **Folder = lab.** The sidebar lists every folder in the lab directory that has a page. The loader reads the directory, so a new lab needs only its folder.
- **File split**: a thin server/route wrapper (`page`) plus a client component holding the experiment and its controls (`lab`).
- **Optional metadata**: a lab may carry a small `meta` module with a title, description, date, and outcome. The outcome is a short note on what the user decided in the lab, stating the accepted values, written once when they go back to production. A lab without metadata takes its title from the folder slug.
- **Defaults come from production.** A lab whose subject is in production imports its starting values from the production module, so the lab starts from what ships. The user accepts values by copying them from the control panel and handing them to the agent. The agent applies them to the production source and reloads the lab to confirm it starts from them.
- **Labs host other work through an adapter.** A lab can hold whatever another skill or tool produces, such as a state machine, a model, a variant round or a prototype. That skill owns the artifact and its rules, and the lab maps four things onto it: what the page renders, what the controls change, how to state the outcome, and what a capture keeps. Read [references/hosting.md](references/hosting.md) when a lab holds anything other than a tuning panel.
- **Harmonize with the destination.** For changes to an existing page, section, or component, use its surrounding content, layout, hierarchy, and interface patterns as the starting point. Depart when that is part of the experiment.
- **A lab differs from the destination.** Deliberate differences, such as forced conditions, fixtures, or an isolated stage, are part of the experiment. Accidental ones come from what the subject reads from its surroundings, such as viewport units that resolve against the window while the subject sits in a smaller pane. Find them by comparing the subject in the lab and in the destination, before the user decides. Compare when the result could depend on the subject's surroundings. A layout decision usually can, and a color or a duration usually cannot.
- **Code ships by promotion.** Current lives in production and the lab imports it. A proposed variant lives in the lab folder. When the subject has a current, keep it as a variant, so the user can compare a proposal with what ships. When the user decides to ship a proposed variant, move it into production in place of current and import it back into the lab. Read [references/promotion.md](references/promotion.md) before promoting a variant, or when a subject renders differently in the lab and the destination.
- **Taste has two sources.** Follow the host's design system and docs first. Where they are silent, follow the user's own taste, wherever they keep it. Read both before building. When the user corrects a lab's look, offer to record the rule in whichever source it belongs to.
- **Labs share a canvas.** Render each lab in one of the host's canvas layouts (stage, board, or full bleed) and write only the lab's content. A stage lab can give the user a switch to a board that shows its subject under several conditions, such as interaction states, themes, content extremes, and widths. Read [references/canvases.md](references/canvases.md) before adding a layout or a conditions board.
- **The control surface is an interface.** DialKit is the default control panel. Order controls in the sequence someone tunes the result, group them by concept, keep high-leverage choices visible, and collapse secondary calibration. Use clear labels, useful ranges, and intentional defaults, and place the panel where the subject stays visible. The panel takes the lab's appearance by default; give it its own only as a deliberate experiment choice. The user can drag a floating panel while using a lab. Panels remember the user's values and saved versions, and follow production when its defaults change. Read [references/dialkit.md](references/dialkit.md) before wiring a lab's controls.
- **Files define a lab's state.** A folder with a page is a live lab. A folder holding only a record and captures is a frozen one. Read the state from the folder each time, and store it nowhere else.
- **Decided labs freeze.** A lab imports live production code, so later production changes break a decided lab or alter what it shows. Freezing removes its code and keeps a record of the outcome, captures of it running, and the main-branch commit where it still runs, served at the lab's old URL. Suggest a freeze or snapshot when the lab's history warrants one, and act only when asked. Read [references/freezing.md](references/freezing.md) before freezing, snapshotting, visiting, or thawing a lab.
- **Dependencies point one way.** The shell imports only labs' metadata. Labs import the canvas and nothing from the shell, so a replacement shell requires no lab edits. Production code imports nothing from a lab.
- **Variants** inside a lab use a `?v=<name>` search param, each named for the axis it diverges on (layout, density, personality, motion). Retain unadopted variants by default for later comparison, and name the accepted one in the outcome note. Follow the user's or host's cleanup preference when it differs. Read [references/variant-comparison.md](references/variant-comparison.md) when one lab needs rapid comparison between structural or interaction directions. Keep parameter snapshots in the control panel.

## Adding a lab

1. **Name the subject and the decision.** Ask the user when either is unclear. Done when you can say what the user will decide by using the lab.
2. **Create the folder and the file split**, and pick a canvas layout.
3. **Bring in the subject.** Import current and its starting values from production when the subject ships. Put a proposed variant in the lab folder.
4. **Wire the controls.** Start the control panel where it covers nothing the user is judging. The user can move it from there. Use the panel's own features, such as saved versions and copy, before building a lab equivalent.
5. **Open the lab in a browser.** Smoke-test unusual wiring such as actions, text fields, manual render loops, and paused states. Done when the lab loads with a clean console and each control changes the subject.

## Applying a decision

When the user settles a decision in a lab, apply it to production. Accepted values go to the production source, and a proposed variant ships by promotion. Reload the lab to confirm it starts from what was decided, and confirm the destination shows what the lab showed. Then write the outcome in the lab's metadata.

Check the lab's lifecycle status after finishing work on it. When a freeze or snapshot is warranted, mention it to the user with its reason.

## What the host learns

A host finds things no general convention covers, such as an accidental difference and its fix, or how it holds a hover state on a conditions board. Offer to record each one in the Labs section of the host's agents file, so later sessions start from it.
