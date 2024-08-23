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
          "content": "",
          "ordering": "column",
          "padding": 250
        },
        {
          "content": "first card",
          "ordering": "column",
          "padding": 20
        },
        {
          "content": "",
          "ordering": "column",
          "padding": 100
        },
        {
          "content": "second card?"
        }
      ],
      "ordering": "row",
      "padding": 0
    },
    {
      "content": "another one (dj khaled)",
      "padding": 150,
      "ordering": "column"
    }
  ],
  "ordering": "column",
  "padding": 0
}
```

### UI (via flutter web)

![output](https://github.com/prithvianilk/dynamic_ui/blob/main/readme_content/example.png?raw=true)