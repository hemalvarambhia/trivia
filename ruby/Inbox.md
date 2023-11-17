## Inbox

- Quieten printing to standard out.

## Penalty Box Diagram

```mermaid
stateDiagram-v2
    [*] --> OutsidePenaltyBox
    OutsidePenaltyBox --> InsidePenaltyBox: Answered Question Incorrectly
    InsidePenaltyBox --> CanLeavePenaltyBox: Rolled an odd number 
    CanLeavePenaltyBox --> OutsidePenaltyBox: Answered Question Correctly
    CanLeavePenaltyBox --> InsidePenaltyBox: Answered Question Incorrectly
```
