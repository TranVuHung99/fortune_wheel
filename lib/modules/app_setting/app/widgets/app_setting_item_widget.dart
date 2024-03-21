import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucid_decision/theme/ui_text_style.dart';

class AppSettingItemWidget extends StatelessWidget {
  final Function() onClick;
  final Widget iconLabel;
  final String title;

  const AppSettingItemWidget({
    super.key,
    required this.onClick,
    required this.iconLabel,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
        ),
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          children: [
            iconLabel,
            SizedBox(width: 8.w),
            Text(
              title,
              style: UITextStyle.black_18_bold,
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 18.sp)
          ],
        ),
      ),
    );
  }
}
