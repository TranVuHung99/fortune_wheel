import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucid_decision/modules/main/domain/models/wheel_option_model.dart';

class WheelSliceItemWidget extends StatefulWidget {
  final WheelOption wheelOption;
  final VoidCallback onDeleteSlice;
  final VoidCallback onChooseColor;
  final Function(String) onEditingText;

  const WheelSliceItemWidget({
    super.key,
    required this.wheelOption,
    required this.onDeleteSlice,
    required this.onChooseColor,
    required this.onEditingText,
  });

  @override
  State<WheelSliceItemWidget> createState() => _WheelSliceItemWidgetState();
}

class _WheelSliceItemWidgetState extends State<WheelSliceItemWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.wheelOption.content;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 21.h),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 13.w),
      color: Colors.grey.shade300,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: widget.onChooseColor,
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Color(widget.wheelOption.color),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(
            width: 35.w,
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Hãy nhập tên lựa chọn....",
                border: InputBorder.none,
              ),
              controller: _textEditingController,
              onChanged: widget.onEditingText,
            ),
          ),
          SizedBox(
            width: 41.w,
          ),
          GestureDetector(
            onTap: widget.onDeleteSlice,
            child: Container(
              width: 38.w,
              height: 38.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red, width: 3.sp),
              ),
              child: const Icon(
                Icons.remove,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
