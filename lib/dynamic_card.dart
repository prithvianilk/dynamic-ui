import 'package:flutter/cupertino.dart';

class DynamicCard {
  final String? _content;

  final List<DynamicCard>? _cards;

  final Ordering _ordering;

  final double _padding;

  DynamicCard(this._content, this._cards, this._ordering, this._padding);

  // TODO: Refactor. Find more expressive patterns...
  Widget build() {
    if (_content != null) {
      return Padding(
        padding: EdgeInsets.all(_padding),
        child: Text(_content!),
      );
    }

    var renderedCards = _cards!.map((card) => card.build()).toList();

    switch (_ordering) {
      case Ordering.row:
        return Padding(
          padding: EdgeInsets.all(_padding),
          child: Row(children: renderedCards),
        );
      case Ordering.column:
        return Padding(
          padding: EdgeInsets.all(_padding),
          child: Column(children: renderedCards),
        );
    }
  }

  factory DynamicCard.fromJson(dynamic json) {
    print(json);

    // TODO: Find a good deserialization lib
    return switch (json) {
      {
        'content': String content,
        'ordering': String? ordering,
        'padding': double? padding,
      } =>
        DynamicCardBuilder()
            .setContent(content)
            .setOrdering(Ordering.from(ordering))
            .setPadding(padding)
            .build(),
      {'content': String content} =>
        DynamicCardBuilder().setContent(content).build(),
      {
        'cards': List<dynamic> cards,
        'ordering': String? ordering,
        'padding': double? padding,
      } =>
        DynamicCardBuilder()
            .setCards(
              cards.map((card) => DynamicCard.fromJson(card)).toList(),
            )
            .setOrdering(Ordering.from(ordering))
            .setPadding(padding)
            .build(),
      _ => throw const FormatException('Failed to load dynamic card.'),
    };
  }
}

class DynamicCardBuilder {
  String? _content;

  List<DynamicCard>? _cards;

  Ordering? _ordering;

  double? _padding;

  DynamicCardBuilder setContent(String content) {
    _content = content;
    return this;
  }

  DynamicCardBuilder setCards(List<DynamicCard> cards) {
    _cards = cards;
    return this;
  }

  DynamicCardBuilder setOrdering(Ordering? ordering) {
    _ordering = ordering ?? Ordering.column;
    return this;
  }

  DynamicCardBuilder setPadding(double? padding) {
    _padding = padding ?? 0;
    return this;
  }

  DynamicCard build() {
    var finalOrdering = switch (_ordering) {
      null => Ordering.column,
      _ => _ordering!,
    };

    double finalPadding = switch (_padding) {
      null => 0,
      _ => _padding!,
    };

    print("Printing DynamicCard on build");
    print(_content);
    print(_cards);
    print(finalOrdering);
    print(finalPadding);
    print("\n");

    return DynamicCard(_content, _cards, finalOrdering, finalPadding);
  }
}

enum Ordering {
  row,
  column;

  factory Ordering.from(String? value) {
    value ??= "column";
    return Ordering.values.firstWhere((enumValue) => enumValue.name == value);
  }
}
