import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';


class MyButton extends StatelessWidget {
  String text;
  Function()? onTap;
  IconData? icon;
  double? width;
  Color? textColor;
  Color? iconColor;
  MyButton(this.text, {this.onTap, this.icon, this.width, this.textColor, this.iconColor});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: MyContainer(
        height: 45,
        color: Theme.of(context).colorScheme.primary,
        width: width ?? MediaQuery.of(context).size.width,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(text, fontWeight: FontWeight.w700, color: textColor ?? Theme.of(context).colorScheme.tertiary),
              Icon(icon, color: iconColor ?? Theme.of(context).colorScheme.tertiary, size: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
