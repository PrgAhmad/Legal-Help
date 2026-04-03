import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_text.dart';

PreferredSizeWidget MyAppBar(
  BuildContext context, {
  String? title,
  double? fontSize,
  List<Widget>? actions,
  Widget? leading,
      double? titleSpacing,
}) {
  return AppBar(
    leading: leading,
    titleSpacing: titleSpacing ?? 0.0,
    backgroundColor: Theme.of(context).colorScheme.secondary,
    shadowColor: Theme.of(context).colorScheme.shadow,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(color: Theme.of(context).colorScheme.outline),
    ),
    title: MyText(
      title!,
      fontSize: fontSize ?? 16,
      fontWeight: FontWeight.w700,
      color: Theme.of(context).colorScheme.tertiary,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
    ),
    actionsPadding: EdgeInsets.only(right: 15),
    actions: actions,
  );
}
