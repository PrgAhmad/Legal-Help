import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

Widget Address(BuildContext context, {required Map lawyer}) {
  return MyContainer(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Row(
          spacing: 5,
          children: [
            Icon(
              Icons.location_on_rounded,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
            MyText(
              'Office Address',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              textAlign: TextAlign.left,
            ),
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 6,
          children: [
            MyText(
              lawyer['officeAddress'] ??
                  'Bhartiya Kamla Nagar Salt Pen Road Wadala',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.left,
            ),
            Row(
              spacing: 4,
              children: [
                MyText(
                  '${lawyer["district"] ?? 'Mumbai'}',
                  fontSize: 11,
                  textAlign: TextAlign.left,
                ),
                MyText(',', fontSize: 11),
                MyText(
                  '${lawyer["state"] ?? 'Maharashtra'}',
                  fontSize: 11,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
