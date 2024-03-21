import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucid_decision/core/extensions/string_ext.dart';
import 'package:lucid_decision/locale_keys.g.dart';
import 'package:lucid_decision/theme/ui_text_style.dart';

class CustomDialog extends StatelessWidget {
  final Widget body;
  final Function() onAccept;
  final Function() onReject;

  const CustomDialog({
    super.key,
    required this.body,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.r))),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.h),
          body,
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onReject,
                child: Container(
                  alignment: Alignment.center,
                  height: 50.h,
                  width: 145.w,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.r)),
                  ),
                  child: Text(
                    LocaleKeys.cancel.trans(),
                    style: UITextStyle.black_18_bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onAccept,
                child: Container(
                  width: 145.w,
                  alignment: Alignment.center,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.r)),
                  ),
                  child: Text(
                    LocaleKeys.ok.trans(),
                    style: UITextStyle.black_18_bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
