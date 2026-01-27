import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/judgments.dart';
import 'package:frontend/screens/constitution/widgets/my_search.dart';
import 'package:frontend/widgets/bottom_details.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:google_fonts/google_fonts.dart';

class ListOfJudgment extends StatefulWidget {
  const ListOfJudgment({super.key});

  @override
  State<ListOfJudgment> createState() => _ListOfJudgmentState();
}

class _ListOfJudgmentState extends State<ListOfJudgment> {
  TextEditingController judgmentCtrl = TextEditingController();
  TextEditingController others = TextEditingController(text: "Most Recent");
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  DateTime? from;
  DateTime? to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context,
        title: "Court Judgments",
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    insetPadding: EdgeInsets.symmetric(
                      // vertical: 200,
                      // horizontal: 100
                    ),
                    child: MyContainer(
                      color: Theme.of(context).colorScheme.surface,
                      width: 120,
                      height: 200,
                      child: Column(
                        spacing: 10,
                        children: [
                          MyContainer(
                            padding: EdgeInsets.zero,
                            child: DropdownMenu(
                              // onSelected: (val){
                              //   selectedVal = val.toString();
                              // },
                              inputDecorationTheme: InputDecorationTheme(
                                constraints: BoxConstraints(maxHeight: 50),
                                hintStyle: GoogleFonts.poppins(
                                  color: Theme.of(context).colorScheme.scrim,
                                  fontSize: 12.5,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10),
                              ),
                              hintText: others.text,
                              controller: others,
                              menuStyle: MenuStyle(
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                  ),
                                ),
                                backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context).colorScheme.secondary,
                                ),
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.zero,
                                ),
                              ),
                              textStyle: GoogleFonts.poppins(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 12.5,
                              ),
                              width:
                                  (MediaQuery.sizeOf(context).width / 4) * 3.3,
                              dropdownMenuEntries: [
                                DropdownMenuEntry(
                                  value: "mostrecent",
                                  label: "Most Recent",
                                  labelWidget: MyText(
                                    "Most Recent",
                                    fontSize: 13,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                DropdownMenuEntry(
                                  value: "relavance",
                                  label: "Relavance",
                                  labelWidget: MyText(
                                    "Relavance",
                                    fontSize: 13,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now(),
                              );
                              from = date!;
                              print(from.toString().split(" ")[0]);
                              setState(() {});
                            },
                            child: MyContainer(
                              width: double.infinity,
                              height: 50,
                              child: Row(
                                spacing: 10,
                                children: [
                                  Icon(
                                    Icons.date_range_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  MyText(
                                    from != null
                                        ? from.toString().split(" ")[0]
                                        : "Select start date",
                                    color:
                                        from != null
                                            ? Theme.of(
                                              context,
                                            ).colorScheme.tertiary
                                            : Theme.of(
                                              context,
                                            ).colorScheme.scrim,
                                    fontSize: 13,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1990),
                                lastDate: DateTime.now(),
                              );
                              to = date!;
                              print(to.toString().split(" ")[0]);
                              setState(() {});
                            },
                            child: MyContainer(
                              width: double.infinity,
                              height: 50,
                              child: Row(
                                spacing: 10,
                                children: [
                                  Icon(
                                    Icons.date_range_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  MyText(
                                    to != null
                                        ? to.toString().split(" ")[0]
                                        : "Select from date",
                                    color:
                                        to != null
                                            ? Theme.of(
                                              context,
                                            ).colorScheme.tertiary
                                            : Theme.of(
                                              context,
                                            ).colorScheme.scrim,
                                    fontSize: 13,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.filter_alt_rounded),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          spacing: 10,
          children: [
            MyContainer(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 50,
              child: Theme(
                data: ThemeData(
                  textSelectionTheme: TextSelectionThemeData(
                    selectionColor: Colors.blue.shade100,
                    cursorColor: Theme.of(context).colorScheme.primary,
                    selectionHandleColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                child: TextField(
                  controller: judgmentCtrl,
                  onChanged: (text) {},
                  autocorrect: true,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 12.5,
                  ),
                  decoration: InputDecoration(
                    suffix: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        CupertinoIcons.multiply,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    iconColor: Theme.of(context).colorScheme.tertiary,
                    icon: Icon(Icons.search),
                    hintText: "Search judgments",
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 12.5,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: judgments.length,
                itemBuilder: (context, idx) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: MyContainer(
                      child: Row(
                        spacing: 10,
                        children: [
                          MyContainer(
                            width: 4,
                            color: Theme.of(context).colorScheme.primary,
                            height: 70,
                          ),
                          Expanded(
                            child: Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  judgments[idx]["title"],
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w500,
                                ),
                                BottomDetails(
                                  leftText: judgments[idx]["courtName"],
                                  rightText: judgments[idx]["date"],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
