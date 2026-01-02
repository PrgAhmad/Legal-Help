import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

Widget Categories(context) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      mainAxisExtent: 140,
    ),
    itemCount: 4,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, idx) {
      return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(categories[idx]["navigation"]);
        },
        borderRadius: BorderRadius.circular(10),
        child: MyContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 15,
            children: [
              Icon(
                categories[idx]["icon"],
                size: 45,
                color: Theme.of(context).colorScheme.primary,
              ),
              MyText(
                categories[idx]["text"],
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ],
          ),
        ),
      );
    },
  );
}
