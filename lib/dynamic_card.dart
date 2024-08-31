import 'package:flutter/cupertino.dart';

import 'logger.dart';

class DynamicCardPadding {
  final double _top, _bottom, _left, _right;

  DynamicCardPadding(this._top, this._bottom, this._left, this._right);

  Padding build(Widget child) {
    log("logging card padding");
    log(child);
    return Padding(
      padding: EdgeInsets.only(
          top: _top, bottom: _bottom, left: _left, right: _right),
      child: child,
    );
  }

  factory DynamicCardPadding.fromJson(dynamic json) {
    log("logging dynamic card padding json:");
    log(json);

    if (json == null) {
      return DynamicCardPadding(0, 0, 0, 0);
    }

    return DynamicCardPadding(
      json['top'] as double? ?? 0,
      json['bottom'] as double? ?? 0,
      json['left'] as double? ?? 0,
      json['right'] as double? ?? 0,
    );
  }
}

class DynamicCard {
  final String? _content;

  final List<DynamicCard>? _cards;

  final Ordering _ordering;

  final DynamicCardPadding _padding;

  DynamicCard(this._content, this._cards, this._ordering, this._padding);

  Widget build() {
    if (_content != null) {
      return _padding.build(Text(_content!));
    }

    var renderedCards = _cards!.map((card) => card.build()).toList();

    switch (_ordering) {
      case Ordering.row:
        return _padding.build(Row(children: renderedCards));
      case Ordering.column:
        return _padding.build(Column(children: renderedCards));
    }
  }

  factory DynamicCard.loadingCard() {
    return DynamicCardBuilder().setContent("Loading...").build();
  }

  factory DynamicCard.fromJson(dynamic json) {
    log(json);

    var cards = json['cards'] as List<dynamic>?;
    var resolvedCards =
        cards?.map((card) => DynamicCard.fromJson(card)).toList();

    return DynamicCard(
        json['content'] as String?,
        resolvedCards,
        Ordering.from(json['ordering']),
        DynamicCardPadding.fromJson(json['padding']));
  }
}

class DynamicCardBuilder {
  String? _content;

  List<DynamicCard>? _cards;

  Ordering? _ordering;

  Padding? _padding;

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

  DynamicCardBuilder setPadding(dynamic padding) {
    _padding = padding;
    return this;
  }

  DynamicCard build() {
    var finalOrdering = switch (_ordering) {
      null => Ordering.column,
      _ => _ordering!,
    };

    log("logging DynamicCard on build");
    log(_content);
    log(_cards);
    log(finalOrdering);
    log(_padding);
    log("\n");

    return DynamicCard(
        _content, _cards, finalOrdering, DynamicCardPadding.fromJson(_padding));
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
