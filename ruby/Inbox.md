## Inbox

- Quieten printing to standard out.

## Penalty Box Diagram

```mermaid
stateDiagram-v2
    [*] --> OutsidePenaltyBox
    OutsidePenaltyBox --> InsidePenaltyBox: Answered question incorrectly
    InsidePenaltyBox --> CanLeavePenaltyBox: Rolled an odd number 
    CanLeavePenaltyBox --> OutsidePenaltyBox: Answered question correctly
    CanLeavePenaltyBox --> InsidePenaltyBox: Answered question incorrectly
```
