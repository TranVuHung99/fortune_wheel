import 'package:flutter/material.dart';
import 'package:lucid_decision/modules/main/app/ui/wheel_customize/wheel_slice_model.dart';

class WheelSliceItemWidget extends StatefulWidget {
  final WheelSliceModel wheelSliceModel;
  final VoidCallback onDeleteSlice;
  final VoidCallback onChooseColor;

  const WheelSliceItemWidget({
    super.key,
    required this.wheelSliceModel,
    required this.onDeleteSlice,
    required this.onChooseColor,
  });

  @override
  State<WheelSliceItemWidget> createState() => _WheelSliceItemWidgetState();
}

class _WheelSliceItemWidgetState extends State<WheelSliceItemWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.wheelSliceModel.sliceName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 21),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 13),
      color: Colors.grey.shade300,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: widget.onChooseColor,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.wheelSliceModel.color,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(
            width: 35,
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Hãy nhập tên lựa chọn....",
                border: InputBorder.none,
              ),
              controller: _textEditingController,
            ),
          ),
          const SizedBox(
            width: 41,
          ),
          GestureDetector(
            onTap: widget.onDeleteSlice,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red, width: 3),
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
