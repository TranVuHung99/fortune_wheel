

import 'package:flutter/material.dart';

@immutable
class FortuneIndicator {
  final Alignment alignment;
  final Widget child;

  const FortuneIndicator({
    this.alignment = Alignment.center,
    required this.child,
  });

}
