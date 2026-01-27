
import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDropDown extends StatelessWidget {
  TextEditingController controller;
  IconData icon;
  String labelText;
  String hintText;
  List entries;
  Function(String?)? onSelected;
  MyDropDown({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.entries,
    required this.icon,
    this.onSelected
  });

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: MyText(labelText, fontSize: 13),
        ),
        MyContainer(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              DropdownMenu(
                onSelected: (val){
                  if(onSelected != null){
                    onSelected!(val);
                  }
                },
                inputDecorationTheme: InputDecorationTheme(
                  constraints: BoxConstraints(maxHeight: 50),
                  hintStyle: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.scrim,
                    fontSize: 12.5,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10),
                ),
                hintText: hintText,
                controller: controller,
                menuStyle: MenuStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.secondary,
                  ),
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                ),
                textStyle: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 12.5,
                ),
                width: (MediaQuery.sizeOf(context).width / 4) * 3.3,
                dropdownMenuEntries:
                    entries
                        .map(
                          (el) => DropdownMenuEntry(
                            value: el.toString().toLowerCase(),
                            label: el.toString(),
                            labelWidget: MyText(
                              el.toString(),
                              fontSize: 13,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
