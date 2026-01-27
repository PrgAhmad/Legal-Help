import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/all_laws_model.dart';
import 'package:frontend/widgets/bottom_details.dart';
import 'package:frontend/widgets/laws_related/my_search.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_scroll_bar.dart';
import 'package:frontend/widgets/my_text.dart';

class ListOfSections extends StatefulWidget {
  String jsonPath = "";
  String lawName = "";
  ListOfSections({super.key, required this.jsonPath, required this.lawName});
  @override
  State<ListOfSections> createState() => _ListOfSectionsState();
}

class _ListOfSectionsState extends State<ListOfSections> {
  List originalList = [];
  TextEditingController searchSection = TextEditingController();
  ScrollController scrollCtrl = ScrollController();

  void loadData() async {
    String stringData = await rootBundle.loadString(widget.jsonPath);
    List jsonData = await jsonDecode(stringData);
    allLaws = jsonData.map((el) => AllLawsModel.fromJson(el)).toList();
    originalList = allLaws;
    setState(() {});
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(context, title: widget.lawName, fontSize: 15),
      body: Column(
        children: [
          MySearch(context, setState, originalList, searchSection, scrollCtrl),
          Expanded(
            child: MyScrollBar(
              context,
              scrollCtrl: scrollCtrl,
              child: ListView.builder(
                controller: scrollCtrl,
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                itemCount: allLaws.length,
                itemBuilder: (context, idx) {
                  AllLawsModel eachSection = allLaws[idx];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Future.delayed(Duration(seconds: 1));
                        Navigator.pushNamed(
                          context,
                          "/each_section",
                          arguments: {
                            "lawName": widget.lawName,
                            "eachSection": eachSection,
                          },
                        );
                      },
                      child: MyContainer(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          spacing: 10,
                          children: [
                            MyContainer(
                              width: 4,
                              color: Theme.of(context).colorScheme.primary,
                              height: 70,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 10,
                                children: [
                                 MyText(
                                    allLaws[idx].sectionTitle,
                                    textAlign: TextAlign.start,
                                   fontWeight: FontWeight.w500,
                                  ),
                                  BottomDetails(leftText: "Section ${allLaws[idx].sectionNo}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
