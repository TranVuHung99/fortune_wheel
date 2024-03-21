import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucid_decision/theme/ui_text_style.dart';

class SettingOptionBodyWidget extends StatelessWidget {
  final Function(dynamic) onClick;
  final dynamic selectedValue;
  final List<dynamic> values;
  final List<String> titles;

  const SettingOptionBodyWidget({
    super.key,
    required this.onClick,
    required this.selectedValue,
    required this.values,
    required this.titles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int index = 0; index < values.length; index++) ...[
          _buildSettingOptionWidget(value: values[index], title: titles[index], onClick: onClick),
          if (index != values.length - 1) ...[
            Divider(color: Colors.grey, thickness: 1.w),
          ]
        ]
      ],
    );
  }

  Widget _buildSettingOptionWidget({
    required dynamic value,
    required String title,
    required Function(dynamic) onClick,
  }) {
    return InkWell(
      onTap: () {
        onClick(value);
      },
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          children: [
            Text(title, style: UITextStyle.black_18_bold),
            const Spacer(),
            if (value == selectedValue) Icon(Icons.done, color: Colors.green, size: 18.sp),
          ],
        ),
      ),
    );
  }
}
