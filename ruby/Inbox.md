## Inbox
- Trivia is poorly encapsulated
- Quieten printing to standard out.
- Current player is implicit in the code and it is difficult, then, to set up the test correctly.

## Penalty Box Diagram

```mermaid
stateDiagram-v2
    [*] --> OutsidePenaltyBox
    OutsidePenaltyBox --> InsidePenaltyBox: Answered question incorrectly
    InsidePenaltyBox --> CanLeavePenaltyBox: Rolled an odd number 
    InsidePenaltyBox --> InsidePenaltyBox: Rolled an even number
    CanLeavePenaltyBox --> OutsidePenaltyBox: Answered question correctly
    CanLeavePenaltyBox --> InsidePenaltyBox: Answered question incorrectly
```
