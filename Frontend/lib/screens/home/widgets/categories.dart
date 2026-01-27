import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/constants/categories.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

Widget Categories(context) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      mainAxisExtent: 170,
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
              Image(
                image: AssetImage(categories[idx]["icon"]),
                width: 100,
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
