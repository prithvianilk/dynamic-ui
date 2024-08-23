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
  "cards": [
    {
      "cards": [
        {
          "content": "first card",
          "ordering": "column",
          "padding": {
            "left": 550,
            "right": 200
          }
        },
        {
          "content": "second card?"
        }
      ],
      "ordering": "row"
    },
    {
      "content": "another one (dj khaled)",
      "padding": {
        "top": 50
      }
    }
  ],
  "ordering": "column",
  "padding": {
    "top": 300
  }
}
```

### UI (via flutter web)

![output](https://github.com/prithvianilk/dynamic_ui/blob/main/readme_content/example.png?raw=true)