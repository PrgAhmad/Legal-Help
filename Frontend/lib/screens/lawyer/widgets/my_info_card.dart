import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

Widget MyInfoCard(BuildContext context, {
      required IconData icon,
      required String label,
      required String value,
      bool isSmall = false,
    }) {
  return MyContainer(
    padding: EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 7,
      children: [
        Row(
          spacing: 6,
          children: [
            Icon(
              icon,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
            Expanded(
              child: MyText(
                label,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                // color: Colors.grey[600],
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        MyContainer(
          border: Border.all(color: Colors.green, width: 0.5),
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 7),
          borderRadius: BorderRadius.circular(7),
          child: MyText(
            value,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.green,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    ),
  );
}