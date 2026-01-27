import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

Widget MyIntro({
  String shortIntro = 'No intro provided',
  String detailedIntro = 'No detailed intro provided',
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 10,
    children: [
      MyContainer(
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 5,
              children: [
                Icon(
                  Icons.person,
                  size: 16,
                  color: Colors.blue,
                ),
                MyText(
                  'Short Intro',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            MyText(shortIntro, textAlign: TextAlign.left,),
          ],
        ),
      ),
      MyContainer(
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 5,
              children: [
                Icon(
                  Icons.person,
                  size: 16,
                  color: Colors.blue,
                ),
                MyText(
                  'Detailed Intro',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            MyText(detailedIntro, textAlign: TextAlign.left),
          ],
        ),
      ),
    ],
  );
}
