import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/all_laws_model.dart';
import 'package:google_fonts/google_fonts.dart';

Widget MySearch(BuildContext context, Function setState, List originalList, TextEditingController searchArticle, ScrollController scrollCtrl) {
  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.only(left: 10, right: 10),
    height: 50,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Theme.of(context).colorScheme.outline),
    ),
    child: Theme(
      data: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.blue.shade100,
            cursorColor: Theme.of(context).colorScheme.primary,
            selectionHandleColor: Colors.blue
        ),
      ),
      child: TextField(
        controller: searchArticle,
        onChanged: (text) {
          allLaws = originalList;
          allLaws =
              allLaws.where((el) {
                if (el.sectionTitle.toString().toLowerCase().contains(
                  text.toLowerCase(),
                ) ||
                    el.sectionNo.toString().contains(text)) {
                  return true;
                } else {
                  return false;
                }
              }).toList();
          setState(() {});
        },
        autocorrect: true,
        style: GoogleFonts.poppins(color: Theme.of(context).colorScheme.tertiary),
        decoration: InputDecoration(
          suffix: GestureDetector(
            onTap: (){
              searchArticle.text = "";
              setState(() {
                allLaws = originalList;
              });
            },
            child: Icon(CupertinoIcons.multiply, color: Theme.of(context).colorScheme.tertiary,),
          ),
          iconColor: Theme.of(context).colorScheme.tertiary,
          icon: Icon(Icons.search),
          hintText: "Search sections",
          border: InputBorder.none,
          hintStyle: GoogleFonts.poppins(color: Theme.of(context).colorScheme.tertiary, fontSize: 14),
        ),
      ),
    ),
  );
}
