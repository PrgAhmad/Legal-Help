import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<bool> hasInternet() async {
  return await InternetConnectionChecker.instance.hasConnection;
}

Widget NoInternet() {
  return MyContainer(child: MyText("No Internet"));
}
