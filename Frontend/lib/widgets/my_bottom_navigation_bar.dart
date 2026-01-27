import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int? navIdx;
  SharedPreferences? pref;
  bool isLawyer = false;
  @override
  void initState() {
    super.initState();
    initPref();
  }

  void initPref() async {
    pref = await SharedPreferences.getInstance();
    isLawyer = pref!.getBool(lawyerMode) ?? false;
    navIdx = pref!.getInt("navIdx") ?? 0;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            spreadRadius: 1,
            blurRadius: 6,
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.tertiary,
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        currentIndex: navIdx ?? 0,
        onTap: (int idx) {
          switch (idx) {
            case 0:
              Navigator.pushReplacementNamed(context, MyRoutes.home);
              break;
            case 1:
              Navigator.pushReplacementNamed(context, MyRoutes.chatbot);
              break;
            case 2:
              Navigator.pushReplacementNamed(context, MyRoutes.lawyer);
              break;
            case 3:
              Navigator.pushReplacementNamed(
                context,
                isLawyer ? MyRoutes.lawyerProfile : MyRoutes.userProfile,
              );
              break;
          }
          print(idx);
          setState(() {
            navIdx = idx;
            pref!.setInt("navIdx", idx);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chatbot"),
          BottomNavigationBarItem(
            icon: Icon(Icons.group, size: 26.5),
            label: "Lawyers",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 27),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
