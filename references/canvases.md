# Canvases

The **canvas** is the frame a lab renders inside: its inset, background, control-panel position, and title placement. A host has a few canvas layouts and every lab uses one, so labs look alike.

In production a subject renders in the window. In a lab it renders in the canvas pane, which is smaller. The canvas module is where a host fixes the differences this causes in every lab ([promotion.md](promotion.md)). For instance, a pane that is a size container and the containing block for fixed children lets a subject sized from its container render as it does in its destination.

## Layouts

Start the canvas module with three layouts, sized from the host's tokens:

- **Stage**: one subject, centered, at full size. The default.
- **Board**: several items on one grid, all visible at once, with one gap and one label style.
- **Full bleed**: the lab fills the pane and sets its own inset and background.

Start the control panel where it covers nothing the user is judging. A panel usually floats over a stage or full bleed lab and docks beside a board, where a floating panel would cover grid items. The user can move it from there. A variant picker ([variant-comparison.md](variant-comparison.md)) can sit over any layout, because it swaps what the lab renders.

When no layout fits a lab, add one to the canvas module so later labs can use it. Keep the module outside the shell, so a lab can import it without importing the shell.

## All-states view

A stage or board lab can give the user a switch between live use and every state at once. Both views read the same control values, so one control change updates every state. Put the switch's state in the URL, like the variant name, so a reload or a shared link keeps the view.

1. **List the states.** Read the component and list every variant and state it renders. Done when each one has an entry.
2. **Force each state.** Prefer the component's own controlled props or `data-*` attributes. An interaction pseudo-class such as hover has no prop, so hold it another way. For instance, duplicate each same-origin CSS rule that uses it with an attribute selector the entry sets. Done when every entry shows its state without input.
3. **Label each entry** so the user can name a state and find its code: the component, the state, and the source file and line that renders it.

The view follows [Raphael Salaja's `lab.js`](https://github.com/raphaelsalaja/skills/tree/main/skills/lab), which builds it as a web component with its own grid and sliders. In a lab, build it with the host's components and the lab's panel.

## Verification

Done when every live lab uses a layout, each layout holds the shell's title line and inset at wide and narrow widths, and an all-states view shows every listed state while a control change updates all of them.
