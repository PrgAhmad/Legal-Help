import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/indian_constituiton_model.dart';
import 'package:google_fonts/google_fonts.dart';

Widget MySearch(BuildContext context, Function setState, List originalList, TextEditingController searchSection) {
  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.only(left: 10, right: 10),
    height: 50,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(),
    ),
    child: Theme(
      data: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.blue.shade100,
            cursorColor: Theme.of(context).colorScheme.primary,
            selectionHandleColor: Theme.of(context).colorScheme.primary
        ),
      ),
      child: TextField(
        controller: searchSection,
        onChanged: (text) {
            indianConstitution = originalList;
          indianConstitution =
              indianConstitution.where((el) {
                if (el.articleTitle.toString().toLowerCase().contains(
                      text.toLowerCase(),
                    ) ||
                    el.articleNo.toString().contains(text)) {
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
              searchSection.text = "";
              setState(() {
                indianConstitution = originalList;
              });
            },
            child: Icon(CupertinoIcons.multiply, color:  Theme.of(context).colorScheme.tertiary),
          ),
          iconColor: Theme.of(context).colorScheme.tertiary,
          icon: Icon(Icons.search),
          hintText: "Search article",
          border: InputBorder.none,
          hintStyle: GoogleFonts.poppins(color: Theme.of(context).colorScheme.tertiary, fontSize: 14),
        ),
      ),
    ),
  );
}
