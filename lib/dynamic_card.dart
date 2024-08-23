import 'package:flutter/cupertino.dart';

class DynamicCard {
  final String? _content;

  final List<DynamicCard>? _cards;

  final Ordering _ordering;

  final double _padding;

  DynamicCard(this._content, this._cards, this._ordering, this._padding);

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

  DynamicCardBuilder setOrdering(Ordering ordering) {
    _ordering = ordering;
    return this;
  }

  DynamicCardBuilder setPadding(double padding) {
    _padding = padding;
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

    return DynamicCard(_content, _cards, finalOrdering, finalPadding);
  }
}

enum Ordering { row, column }
