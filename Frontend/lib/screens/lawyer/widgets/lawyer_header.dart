import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

Widget LawyerHeader(BuildContext context, {required Map lawyer}) {
  return MyContainer(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.all(16),
    child: Row(
      spacing: 16,
      children: [
        Container(
          width: 75,
          height: 75,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Image.asset('assets/images/lawyers.png', fit: BoxFit.cover),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              MyText(
                lawyer['name'] ?? '',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.left,
              ),

              MyContainer(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: Colors.blue, width: 0.5),
                child: MyText(
                  lawyer['type'] ?? '',
                  fontSize: 11,
                  color: Colors.blue,
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.w500,
                ),
              ),
              MyText(lawyer["court"], fontSize: 12, fontWeight: FontWeight.w600,),
            ],
          ),
        ),
      ],
    ),
  );
}
