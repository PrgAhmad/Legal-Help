import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

Widget PracticeArea(BuildContext context, {required List otherAreas}) {
  return MyContainer(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Row(
          spacing: 5,
          children: [
            Icon(
              Icons.account_balance_rounded,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
            MyText(
              'Practice Areas',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              textAlign: TextAlign.left,
            ),
          ],
        ),
        MyContainer(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Colors.blue, width: 0.5),
          child: MyText(
            "Criminal law",
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              otherAreas.map((a) {
                return MyContainer(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.green, width: 0.5),
                  child: MyText(
                    a.toString(),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                );
              }).toList(),
        ),
      ],
    ),
  );
}
