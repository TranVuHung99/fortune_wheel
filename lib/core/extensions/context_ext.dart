import 'package:flutter/widgets.dart';
import 'package:keyboard_service/keyboard_service.dart';

extension ContextExt on BuildContext {
  void hideKeyboard() {
    KeyboardService.dismiss(unfocus: this);
  }
}
