import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucid_decision/core/extensions/string_ext.dart';
import 'package:lucid_decision/locale_keys.g.dart';
import 'package:lucid_decision/modules/app_setting/domain/enums/language.dart';
import 'package:lucid_decision/theme/ui_text_style.dart';

class AllLanguageWidget extends StatelessWidget {
  final Function(Language) onClick;
  final Language selectedLanguage;

  const AllLanguageWidget({
    super.key,
    required this.onClick,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _languageItemWidget(language: Language.en, title: LocaleKeys.lang_en.trans(), onClick: onClick),
        Divider(color: Colors.grey, thickness: 1.w),
        _languageItemWidget(language: Language.vn, title: LocaleKeys.lang_vi.trans(), onClick: onClick)
      ],
    );
  }

  Widget _languageItemWidget({
    required Language language,
    required String title,
    required Function(Language) onClick,
  }) {
    return InkWell(
      onTap: () {
        onClick(language);
      },
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          children: [
            Text(title, style: UITextStyle.black_18_bold),
            const Spacer(),
            if (language == selectedLanguage) Icon(Icons.done, color: Colors.green, size: 18.sp),
          ],
        ),
      ),
    );
  }
}
