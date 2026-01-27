import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/screens/home/widgets/categories.dart';
import 'package:frontend/screens/home/widgets/others.dart';
import 'package:frontend/screens/home/widgets/welcome.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_bottom_navigation_bar.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  SharedPreferences? pref;
  @override
  void initState() {
    super.initState();
    initPref();
  }

  void initPref() async{
    pref = await SharedPreferences.getInstance();
    pref!.setInt("navIdx", 0);
    setState(() {

    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(context, title: projectName, fontSize: 20),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Welcome(context),
            MyText(
              "Categories",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.left,
            ),
            Categories(context),
            MyText(
              "Others",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.left,
            ),
            Others(context)
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar()
    );
  }
}
