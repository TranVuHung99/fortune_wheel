
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// Represents the style of a single [FortuneItem].
///
/// See also:
///  * [StyleStrategy], which allows for styling a list of [FortuneItem]s
@immutable
class FortuneItemStyle extends Equatable {
  final Color color;

  final Color borderColor;

  final double borderWidth;

  final TextAlign textAlign;

  final TextStyle textStyle;

  final ui.Image? image;


  const FortuneItemStyle({
    this.color = Colors.white,
    this.borderColor = Colors.black,
    this.borderWidth = 1.0,
    this.textAlign = TextAlign.start,
    this.textStyle = const TextStyle(),
    this.image,
  });

  /// Creates an opinionated disabled style based on the current [ThemeData].
  FortuneItemStyle.disabled(ThemeData theme, {double opacity = 0.0})
      : this(
    color: Color.alphaBlend(
      theme.disabledColor.withOpacity(opacity),
      theme.disabledColor,
    ),
    borderWidth: 0.0,
    textStyle: TextStyle(color: theme.colorScheme.onPrimary),
  );

  @override
  List<Object?> get props => [color, borderColor, borderWidth, textAlign, textStyle];

}

/// Interface for providing common styling to a list of [FortuneItem]s.
// ignore: one_member_abstracts
abstract class StyleStrategy {
  /// {@template flutter_fortune_wheel.StyleStrategy.getItemStyle}
  /// Creates an [FortuneItemStyle] based on the passed [theme] while
  /// considering an item's [index] with respect to the overall [itemCount].
  /// {@endtemplate}
  FortuneItemStyle getItemStyle(
    ThemeData theme,
    int index,
    int itemCount,
  );
}

/// Mixin to allow style strategies to have a common style for disabled items.
mixin DisableAwareStyleStrategy {
  List<int> get disabledIndices;

  bool _isIndexDisabled(int index) {
    return disabledIndices.contains(index);
  }

  FortuneItemStyle getDisabledItemStyle(
    ThemeData theme,
    int index,
    int itemCount,
    FortuneItemStyle Function() orElse,
  ) {
    if (_isIndexDisabled(index)) {
      return FortuneItemStyle.disabled(
        theme,
        opacity: index % 2 == 0 ? 0.2 : 0.0,
      );
    } else {
      return orElse();
    }
  }
}

/// This strategy renders all items using the same style based on the current
/// [ThemeData].
///
/// The [ThemeData.primaryColor] is used as the border color and the background
/// is drawn using the same color at 0.3 opacity.
class UniformStyleStrategy
    with DisableAwareStyleStrategy
    implements StyleStrategy {
  final Color? color;
  final Color? borderColor;
  final double? borderWidth;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final List<int> disabledIndices;

  const UniformStyleStrategy({
    this.color,
    this.borderColor,
    this.borderWidth,
    this.textAlign,
    this.textStyle,
    this.disabledIndices = const <int>[],
  });

  /// {@macro flutter_fortune_wheel.StyleStrategy.getItemStyle}
  @override
  FortuneItemStyle getItemStyle(ThemeData theme, int index, int itemCount) {
    return getDisabledItemStyle(
      theme,
      index,
      itemCount,
      () => FortuneItemStyle(
        color: color ??
            Color.alphaBlend(
              theme.colorScheme.primary.withOpacity(0.3),
              theme.colorScheme.surface,
            ),
        borderColor: borderColor ?? theme.colorScheme.primary,
        borderWidth: borderWidth ?? 1.0,
        textStyle: textStyle ?? TextStyle(color: theme.colorScheme.onSurface),
        textAlign: textAlign ?? TextAlign.center,
      ),
    );
  }
}

/// This strategy renders items in alternating variations of the
/// [ThemeData.primaryColor].
///
/// It renders even items at 0.5 opacity and odd items using the original color.
/// If the item count is odd, the first item is rendered with 0.7 opacity to
/// prevent a non-uniform style.
class AlternatingStyleStrategy
    with DisableAwareStyleStrategy
    implements StyleStrategy {
  final List<int> disabledIndices;

  Color _getFillColor(ThemeData theme, int index, int itemCount) {
    final color = theme.colorScheme.primary;
    final background = theme.colorScheme.background;
    final opacity = itemCount % 2 == 1 && index == 0
        ? 0.7 // TODO: make 0.75
        : index % 2 == 0
            ? 0.5
            : 1.0;

    return Color.alphaBlend(
      color.withOpacity(opacity),
      background,
    );
  }

  const AlternatingStyleStrategy({
    this.disabledIndices = const <int>[],
  });

  /// {@macro flutter_fortune_wheel.StyleStrategy.getItemStyle}
  @override
  FortuneItemStyle getItemStyle(ThemeData theme, int index, int itemCount) {
    return getDisabledItemStyle(
      theme,
      index,
      itemCount,
      () => FortuneItemStyle(
        color: _getFillColor(theme, index, itemCount),
        borderColor: theme.colorScheme.primary,
        borderWidth: 0.0,
        textAlign: TextAlign.start,
        textStyle: TextStyle(color: theme.colorScheme.onPrimary),
      ),
    );
  }
}
