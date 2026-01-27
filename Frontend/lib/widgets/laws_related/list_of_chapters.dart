import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/all_laws_model.dart';
import 'package:frontend/widgets/bottom_details.dart';
import 'package:frontend/widgets/laws_related/list_of_section_after_chapter.dart';
import 'package:frontend/widgets/laws_related/my_search.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_scroll_bar.dart';
import 'package:frontend/widgets/my_text.dart';

class ListOfChapters extends StatefulWidget {
  String jsonPath = "";
  String lawName = "";
  ListOfChapters({required this.jsonPath, required this.lawName});
  @override
  State<ListOfChapters> createState() => _ListOfChaptersState();
}

class _ListOfChaptersState extends State<ListOfChapters> {
  List originalList = [];
  List chaptersNo = [];
  List chaptersTitle = [];
  TextEditingController searchSection = TextEditingController();
  ScrollController scrollCtrl = ScrollController();

  void loadData() async {
    String stringData = await rootBundle.loadString(widget.jsonPath);
    List jsonData = await jsonDecode(stringData);
    allLaws = jsonData.map((el) => AllLawsModel.fromJson(el)).toList();
    originalList = allLaws;
    chaptersNo =
        allLaws.map((el) => el.chapterNo.toString()).toList().toSet().toList();
    chaptersTitle =
        allLaws.map((el) => el.chapterTitle).toList().toSet().toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(context, title: widget.lawName, fontSize: 15),
      body: Expanded(
        child: MyScrollBar(
          context,
          scrollCtrl: scrollCtrl,
          child: ListView.builder(
            controller: scrollCtrl,
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            itemCount: chaptersTitle.length,
            itemBuilder: (context, idx) {
              List totalSections =
                  allLaws
                      .where((el) => el.chapterTitle == chaptersTitle[idx])
                      .toList();
              return Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ListOfSectionAfterChapter(
                              lawName: widget.lawName,
                              chapterName: chaptersTitle[idx],
                              sections: totalSections,
                              chapterNo: chaptersNo[idx],
                            ),
                      ),
                    );
                  },
                  child: MyContainer(
                    // width: MediaQuery.of(context).size.width,
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
                                chaptersTitle[idx],
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w500,
                              ),
                              BottomDetails(
                                leftText: "Chapter ${chaptersNo[idx]}",
                                rightText:
                                    "Total sections : ${totalSections.length}",
                              ),
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
    );
  }
}
