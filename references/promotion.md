# Promoting a subject

Read this when a lab's subject will ship, when a production component comes into a lab, or when a subject renders differently in the lab and in its destination.

## Terms

- **Subject**: what a lab renders and decides about.
- **Destination**: the production page or component where the subject ships.
- **Tuning lab**: the subject lives in production and the lab imports it. Only values go back to production.
- **Exploring lab**: the subject lives in the lab folder and production does not use it.
- **Promote**: move an explored subject into production, when the user decides to ship it.

## How a lab differs from the destination

A lab renders the subject outside its destination, and the two differ in two ways.

- **Deliberate differences** are part of the experiment: forced states, fixtures, an isolated stage. The lab's code already shows them.
- **Accidental differences** come from what the subject reads from its surroundings. For instance, the canvas pane is smaller than the window, so `vh`, `vw`, media queries, and `fixed` positioning resolve against the wrong box. Anything else the destination supplies can differ the same way, for example a parent's width, a provider, global styles, or live data.

Find an accidental difference by comparing the subject in the lab and in the destination under the same conditions, such as the same width. Compare when the result could depend on the subject's surroundings. A layout decision usually can, and a color or a duration usually cannot. Tell the user what differs before changing the subject. Fix it in the subject when the subject can stop reading the surroundings that differ. For instance, a subject sized from its container (`cqw`, `cqh`, `@container`) renders the same in the pane and in the window. Fix it in the lab when the lab supplied the wrong surroundings. When neither fix is possible, state the difference in the lab's description.

When a host finds another kind of accidental difference, offer to record it and its fix in the host's agents file, so later labs avoid it.

## Choose where the subject renders

For a change to an existing page, a lab can render the destination's surrounding section with the subject in place. The subject then reads the surroundings it ships into. Render the subject alone on a stage when isolation helps the decision, for instance when inspecting states, tuning a component used in many places, or exploring work that has no destination yet.

## Promote an explored subject

1. **Move the subject.** Move its modules from the lab folder into production with history-preserving renames.
2. **Import it back.** Replace the lab's copy with an import. The lab is now a tuning lab, and its defaults come from production.
3. **Check it in the destination.** Render the subject where it ships and compare it with the lab under the same conditions. Fix or state each accidental difference.
4. **Write the outcome.** Suggest a freeze when the lab's history warrants one ([freezing.md](freezing.md)).

Done when production imports nothing from the lab folder, the lab imports the subject from production, and every accidental difference step 3 found is fixed or stated.

A lab can stay live through several promotions. Suggest a snapshot at each decision.

## Bring a production subject into a lab

Import the subject. A copy stops matching production once production changes, and values tuned on a copy may not suit what ships. When the subject renders only inside its page, one option is to extract the part under study into its own production module and import that. Extraction changes production code, so propose it to the user first.
