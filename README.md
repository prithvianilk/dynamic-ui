# dynamic_ui

# Design

## Card

    - content: string
    - cards: Card[]
    - ordering: row | column
    - padding: double

### Example

```json
{
  "root": {
    "cards": [
      {
        "content": "1",
        "padding": 100
      },
      {
        "content": "2"
      }
    ],
    "ordering": "column"
  }
}
```