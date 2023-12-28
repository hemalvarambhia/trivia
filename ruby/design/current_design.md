## Design that has emerged

```mermaid
classDiagram
    Game <|-- GameWithCommentary
    Game <|-- GameWithNoCommentary

    class GameCommentary {
        +puts(message)
        +commentary()
    }
    class StringIOBasedGameCommentary {
        
    }
    class NoGameCommentary {

    }
GameCommentary <|-- StringIOBasedGameCommentary
GameCommentary <|-- NoGameCommentary    
GameWithCommentary *-- StringIOBasedGameCommentary  
GameWithNoCommentary *-- NoGameCommentary
```