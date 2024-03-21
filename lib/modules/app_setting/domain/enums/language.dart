import 'package:json_annotation/json_annotation.dart';
import 'package:lucid_decision/core/extensions/string_ext.dart';
import 'package:lucid_decision/locale_keys.g.dart';

enum Language {
  @JsonValue('unknown')
  unknown,
  @JsonValue('en')
  en,
  @JsonValue('vi')
  vn
}

extension LanguageExt on Language {
  String getValue() {
    switch (this) {
      case Language.unknown:
        return 'unknown';
      case Language.en:
        return 'en';
      case Language.vn:
        return 'vi';
    }
  }

  String getName() {
    switch (this) {
      case Language.unknown:
        return 'Unknown';
      case Language.en:
        return LocaleKeys.lang_en.trans();
      case Language.vn:
        return LocaleKeys.lang_vi.trans();
    }
  }
}
