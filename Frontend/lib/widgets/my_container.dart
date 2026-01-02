import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  Color? color;
  double? height;
  double? width;
  BorderRadius? borderRadius;
  Widget? child;
  EdgeInsets? padding;
  EdgeInsets? margin;
  Border? border;
  bool? isShadow;

  MyContainer({
    this.color,
    this.height,
    this.width,
    this.borderRadius,
    this.child,
    this.padding,
    this.margin,
    this.border,
    this.isShadow = true,
  });

  Widget build(BuildContext context) {
    return Ink(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.secondary,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        border:
            border ?? Border.all(color: Theme.of(context).colorScheme.outline),
        boxShadow: [
          isShadow == true
              ? BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                spreadRadius: 1,
                blurRadius: 6,
              )
              : BoxShadow(color: Colors.transparent),
        ],
      ),
      child: child,
    );
  }
}
