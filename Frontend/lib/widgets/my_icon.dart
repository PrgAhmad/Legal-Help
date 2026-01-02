import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget MySmallIcon(context, {required IconData icon, Function()? onTap, double size = 16}) {
  return GestureDetector(
    onTap: onTap,
    child: Icon(icon, size: size, color: Theme.of(context).colorScheme.tertiary),
  );
}
