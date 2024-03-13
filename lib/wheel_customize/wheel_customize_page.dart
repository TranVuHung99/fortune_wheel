import 'dart:math';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:lucid_decision/wheel_customize/wheel_slice_model.dart';
import 'package:lucid_decision/wheel_customize/widgets/wheel_slice_item_widget.dart';

class WheelCustomizePage extends StatefulWidget {
  const WheelCustomizePage({super.key});

  @override
  State<WheelCustomizePage> createState() => _WheelCustomizePageState();
}

class _WheelCustomizePageState extends State<WheelCustomizePage> {
  List<WheelSliceModel> wheelSlices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () => addWheelSlice(Color(Random().nextInt(0xffffffff)), ""),
            child: const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: const Text("What should i do today?"),
          ),
          const SizedBox(
            height: 27,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => WheelSliceItemWidget(
                wheelSliceModel: wheelSlices.elementAt(index),
                onDeleteSlice: () => onDeleteSlice(index),
                onChooseColor: () => onChooseColor(wheelSlices.elementAt(index)),
              ),
              itemCount: wheelSlices.length,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 27),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: const Center(
              child: Text(
                "DONE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addWheelSlice(Color color, String sliceName) {
    setState(() {
      wheelSlices.add(WheelSliceModel(color: color, sliceName: sliceName));
    });
  }

  void onDeleteSlice(index) {
    setState(() {
      wheelSlices.removeAt(index);
    });
  }

  onChooseColor(WheelSliceModel wheelSliceModel) async {
    final Color newColor = await showColorPickerDialog(
      context,
      wheelSliceModel.color,
      title: Text('ColorPicker', style: Theme.of(context).textTheme.titleLarge),
      width: 40,
      height: 40,
      spacing: 0,
      runSpacing: 0,
      borderRadius: 0,
      wheelDiameter: 165,
      enableOpacity: true,
      colorCodeHasColor: true,
      pickersEnabled: <ColorPickerType, bool>{
        ColorPickerType.wheel: true,
      },
      actionButtons: const ColorPickerActionButtons(
        okButton: true,
        closeButton: true,
        dialogActionButtons: false,
      ),
      constraints: const BoxConstraints(minHeight: 480, minWidth: 320, maxWidth: 480),
    );
    setState(() {
      wheelSliceModel.color = newColor;
    });
  }
}
