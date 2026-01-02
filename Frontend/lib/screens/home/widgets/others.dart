import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

Widget Others(BuildContext context){
  return GridView(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      mainAxisExtent: 60,
    ),
    shrinkWrap: true,
    children: [
      InkWell(
        onTap: (){},
        borderRadius: BorderRadius.circular(10),
        child: MyContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 15,
            children: [
              Icon(Icons.gavel_rounded, color: Theme.of(context).colorScheme.primary),
              MyText(
                "Judgment",
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
      InkWell(
        onTap: (){},
        borderRadius: BorderRadius.circular(10),
        child: MyContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 15,
            children: [
              Icon(CupertinoIcons.book_fill, color: Theme.of(context).colorScheme.primary),
              MyText(
                "Legal Terms",
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}