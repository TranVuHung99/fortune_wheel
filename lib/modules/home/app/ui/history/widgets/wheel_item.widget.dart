import 'package:flutter/material.dart';
import 'package:lucid_decision/core/helper/format_helper.dart';
import 'package:lucid_decision/modules/home/domain/models/wheel_model.dart';

class WheelItemWidget extends StatelessWidget {
  final Function() onDelete;
  final Wheel wheel;

  const WheelItemWidget({super.key, required this.wheel, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              wheel.name ?? "",
              style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              FormatHelper.formatDate(
                "dd/MM/yyyy hh:mm",
                wheel.createdAt,
              ),
              style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w600),
            )
          ])),
          GestureDetector(
            onTap: () {
              /// Navigate to add page with wheel param
            },
            child: Icon(Icons.edit, color: Colors.black,),
          ),
          SizedBox(width: 15,),
          GestureDetector(
            onTap: onDelete,
            child: Icon(Icons.delete, color: Colors.black,),
          )
        ],
      ),
    );
  }
}
