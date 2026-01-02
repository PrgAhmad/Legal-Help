import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_text.dart';

PreferredSizeWidget MyAppBar(BuildContext context,{String? title,double? fontSize, List<Widget>? actions, Widget? leading}){
  return AppBar(
    leading: leading,
    backgroundColor: Theme.of(context).colorScheme.secondary,
    shadowColor: Theme.of(context).colorScheme.shadow,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: Theme.of(context).colorScheme.tertiary,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(color: Theme.of(context).colorScheme.outline)
    ),
    title: MyText(title!, fontSize: fontSize ?? 18, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.tertiary,),
    actionsPadding: EdgeInsets.only(right: 15),
    actions: actions,
  );
}