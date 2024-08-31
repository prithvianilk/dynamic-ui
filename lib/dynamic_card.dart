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

  factory DynamicCardPadding.none() {
    return DynamicCardPadding(0, 0, 0, 0);
  }

  factory DynamicCardPadding.fromJson(dynamic json) {
    log("logging dynamic card padding json:");
    log(json);

    if (json == null) {
      return DynamicCardPadding.none();
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

  final DynamicCardOrdering _ordering;

  final DynamicCardAlignment _alignment;

  final DynamicCardPadding _padding;

  DynamicCard(this._content, this._cards, this._ordering, this._alignment,
      this._padding);

  Widget build() {
    if (_content != null) {
      return _padding.build(Text(_content));
    }

    var renderedCards = _cards!.map((card) => card.build()).toList();

    var alignment = switch (_alignment) {
      DynamicCardAlignment.start => MainAxisAlignment.start,
      DynamicCardAlignment.center => MainAxisAlignment.center,
    };

    switch (_ordering) {
      case DynamicCardOrdering.row:
        return _padding
            .build(Row(mainAxisAlignment: alignment, children: renderedCards));

      case DynamicCardOrdering.column:
        return _padding.build(
            Column(mainAxisAlignment: alignment, children: renderedCards));
    }
  }

  factory DynamicCard.loadingCard() {
    return DynamicCard("Loading...", null, DynamicCardOrdering.column,
        DynamicCardAlignment.start, DynamicCardPadding.none());
  }

  factory DynamicCard.fromJson(dynamic json) {
    log(json);

    var cards = json['cards'] as List<dynamic>?;
    var resolvedCards =
        cards?.map((card) => DynamicCard.fromJson(card)).toList();

    return DynamicCard(
        json['content'] as String?,
        resolvedCards,
        DynamicCardOrdering.from(json['ordering']),
        DynamicCardAlignment.from(json['alignment']),
        DynamicCardPadding.fromJson(json['padding']));
  }
}

enum DynamicCardOrdering {
  row,
  column;

  factory DynamicCardOrdering.from(String? value) {
    value ??= "column";
    return DynamicCardOrdering.values
        .firstWhere((enumValue) => enumValue.name == value);
  }
}

enum DynamicCardAlignment {
  start,
  center;

  factory DynamicCardAlignment.from(String? value) {
    value ??= "start";
    return DynamicCardAlignment.values
        .firstWhere((enumValue) => enumValue.name == value);
  }
}
