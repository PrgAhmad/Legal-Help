import 'package:flutter/material.dart';

Widget MyScrollBar(
  context, {
  required ScrollController scrollCtrl,
  required Widget child,
}) {
  return ScrollbarTheme(
    data: ScrollbarThemeData(
      thumbColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
    ),
    child: Scrollbar(
      interactive: true,
      thickness: 6,
      thumbVisibility: true,
      radius: Radius.circular(5),
      controller: scrollCtrl,
      child: child,
    ),
  );
}
