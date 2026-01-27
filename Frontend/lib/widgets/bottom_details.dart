import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

Widget BottomDetails({required String leftText, String? rightText}){
  return Row(
    mainAxisAlignment:
    MainAxisAlignment.spaceBetween,
    children: [
      MyContainer(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: Colors.blue,
          width: 0.5,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 7,
        ),
        child: MyText(
          leftText,
          fontSize: 9.5,
          color: Colors.blue,
          fontWeight: FontWeight.w600,
        ),
      ),
      if(rightText != null)
      MyContainer(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: Colors.green,
          width: 0.5,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 7,
        ),
        child: MyText(
          rightText,
          fontSize: 9.5,
          color: Colors.green,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}