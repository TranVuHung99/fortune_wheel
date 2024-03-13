import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucid_decision/core/helper/format_helper.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_model.dart';

class WheelItemWidget extends StatelessWidget {
  final Function() onDelete;
  final WheelModel wheel;

  const WheelItemWidget({super.key, required this.wheel, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              wheel.name,
              style: const TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              FormatHelper.formatDate(
                "dd/MM/yyyy hh:mm",
                wheel.createdAt,
              ),
              style: const TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w600),
            )
          ])),
          GestureDetector(
            onTap: () {
              /// Navigate to add page with wheel param
            },
            child: const Icon(Icons.edit, color: Colors.black,),
          ),
          SizedBox(width: 15.w,),
          GestureDetector(
            onTap: onDelete,
            child: const Icon(Icons.delete, color: Colors.black,),
          )
        ],
      ),
    );
  }
}
