

import 'package:flutter/material.dart';
import 'package:lucid_decision/modules/main/app/ui/wheel/core/styling.dart';

/// A [FortuneItem] represents a value, which is chosen during a selection
/// process and displayed within a [FortuneWidget].
///
/// See also:
///  * [FortuneWidget]
@immutable
class FortuneItem {

  /// A widget to be rendered within this item.
  final Widget child;
  final int ratio;
  final FortuneItemStyle? style;


  const FortuneItem({
    required this.child,
    this.ratio = 1,
    this.style,
  });

}

@immutable
class TransformedFortuneItem implements FortuneItem {
  final FortuneItem _item;
  final double angle;
  final Offset offset;

  const TransformedFortuneItem({
    required FortuneItem item,
    this.angle = 0.0,
    this.offset = Offset.zero,
  }) : _item = item;

  @override
  Widget get child => _item.child;



  @override
  int get ratio => _item.ratio;

  @override
  FortuneItemStyle? get style => _item.style;


}
