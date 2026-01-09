# Communication

- If I'm wrong, say so and explain why.
- Ground feedback in specifics, not generalities.

# Before Writing Code and Plan

- Understand the WHY before the WHAT.
- Push back if the approach seems wrong. I trust you to disagree.
- Read existing code before proposing changes.
- Ask clarifying questions rather than making assumptions.
- ALWAYS pitch solutions with an estimate of how many LINE- and FILE-changes it will take. The lower the better. A PR that can be landed in 20 lines is nearly always far superior to one in 200.
- Give a high-level architectural overview in a Mermaid chart in the plan. The landmarks to flag are usually changes/additions/removals of 1) Data Schemas, 2) Interfaces and 3) Entry/Exit points. Thinking along the lines of the C4 Model is in general helpful. You should also include the main functions/objects you're planning to introduce.
- It's IMPERATIVE that we prior to building something have a way of VALIDATING that the new thing works.


# Code Quality

- Avoid `any` types in general or unknowns. 
- Let errors propagate unless there's a specific reason to handle them.
- Avoid over-engineering: no premature abstractions, no unused flexibility.
- Delete unused code completely. DON'T think about backwards-compatibility if not explicitly instructed to.
- When debugging, state your hypothesis before making changes.
- If a fix doesn't work, revert it. Don't layer fixes on top of failed fixes.
- Prioritize locality of behavior. If a change requires touching more than 3 distinct modules, pause and ask if the architecture needs a small 'seam' or interface instead.
- 3-strike rule: If something fails repeatedly, stop up and ask the user.

# After Code Changes

- Conduct a thorough review before suggesting the work is done and provide a summary of your review. Be VERY self-critical of the work you've done and start by diffing against main to get a clear view of your changes.
- List concrete next steps or improvements discovered during implementation.
- Make sure to flag unexpected "ugly" code bits in your summary of changes.
- Make sure to communicate how we can verify it works. This might be a test, this might require the user run some cli command, but the implemented changes should always have SOME WAY OF VERIFYING it works.
- Flag potential areas where you suspect we've added tech debt.

# DO NOT

- Add features, refactors, or "improvements" beyond what was asked.
- Create documentation files unless explicitly requested.
- Soften criticism or add unnecessary praise.
- Guess at requirements. Ask instead.
