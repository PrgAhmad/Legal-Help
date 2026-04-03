import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class FilterJudgment extends StatefulWidget {
  TextEditingController others;
  String fromDate;
  String toDate;
  Function(String, {bool isFilter}) setData;
  FilterJudgment({
    super.key,
    required this.others,
    required this.fromDate,
    required this.toDate,
    required this.setData,
  });

  @override
  State<FilterJudgment> createState() => _FilterJudgmentState();
}

class _FilterJudgmentState extends State<FilterJudgment> {
  DateTime? from;
  DateTime? to;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setDateState) {
                return Dialog(
                  child: MyContainer(
                    color: Theme.of(context).colorScheme.surface,
                    width: 120,
                    height: 250,
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
                            hintText: widget.others.text,
                            controller: widget.others,
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
                              padding: WidgetStatePropertyAll(EdgeInsets.zero),
                            ),
                            textStyle: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 12.5,
                            ),
                            width: (MediaQuery.sizeOf(context).width / 4) * 3.3,
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
                            setDateState(() {
                              from = date!;
                              widget.fromDate = from
                                  .toString()
                                  .split(" ")[0]
                                  .split("-")
                                  .reversed
                                  .join("-");
                            });
                          },
                          child: MyContainer(
                            width: double.infinity,
                            height: 50,
                            child: Row(
                              spacing: 10,
                              children: [
                                Icon(
                                  Icons.date_range_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                MyText(
                                  from != null
                                      ? widget.fromDate
                                      : "Select start date",
                                  color:
                                      from != null
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.tertiary
                                          : Theme.of(context).colorScheme.scrim,
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
                              initialDate: DateTime(
                                DateTime.now().year,
                                DateTime.now().month - 2,
                                DateTime.now().day,
                              ),
                              firstDate: DateTime(1990),
                              lastDate: DateTime.now(),
                            );
                            setDateState(() {
                              to = date!;
                              widget.toDate = to
                                  .toString()
                                  .split(" ")[0]
                                  .split("-")
                                  .reversed
                                  .join("-");
                            });
                          },
                          child: MyContainer(
                            width: double.infinity,
                            height: 50,
                            child: Row(
                              spacing: 10,
                              children: [
                                Icon(
                                  Icons.date_range_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                MyText(
                                  to != null
                                      ? widget.toDate
                                      : "Select from date",
                                  color:
                                      to != null
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.tertiary
                                          : Theme.of(context).colorScheme.scrim,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            widget.setData(
                              "${widget.fromDate.isEmpty || widget.toDate.isEmpty ? "" : "&from_date=${widget.fromDate}" + "&to_date=${widget.toDate}"}&options=${widget.others.text.toLowerCase()}",
                              isFilter: true,
                            );
                            // showDialog(
                            //   context: context,
                            //   builder: (context) {
                            //     return Dialog(
                            //       child: LinearProgressIndicator(
                            //         color:
                            //             Theme.of(context).colorScheme.primary,
                            //       ),
                            //     );
                            //   },
                            // );
                            // Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: MyContainer(
                            height: 45,
                            width: double.infinity,
                            color: Theme.of(context).colorScheme.primary,
                            child: MyText(
                              "Search",
                              fontWeight: FontWeight.w600,
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
        );
      },
      child: Icon(Icons.filter_alt_rounded),
    );
  }
}
