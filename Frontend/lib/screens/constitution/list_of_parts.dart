import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/indian_constituiton_model.dart';
import 'package:frontend/screens/constitution/list_of_articles_after_part.dart';
import 'package:frontend/widgets/bottom_details.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_scroll_bar.dart';
import 'package:frontend/widgets/my_text.dart';

class ListOfParts extends StatefulWidget {
  ListOfParts();
  @override
  State<ListOfParts> createState() => _ListOfPartsState();
}

class _ListOfPartsState extends State<ListOfParts> {
  List originalList = [];
  List partNo = [];
  List partTitle = [];
  TextEditingController searchSection = TextEditingController();
  ScrollController scrollCtrl = ScrollController();

  void loadData() async {
    String stringData = await rootBundle.loadString(
      indianConstitutions["jsonPath"],
    );
    List jsonData = await jsonDecode(stringData);
    indianConstitution =
        jsonData.map((el) => IndianConstitutionModel.fromJson(el)).toList();
    originalList = indianConstitution;
    partNo =
        indianConstitution
            .map((el) => el.partNo.toString())
            .toList()
            .toSet()
            .toList();
    partTitle =
        indianConstitution.map((el) => el.partTitle).toList().toSet().toList();
    setState(() {});
  }

  @override
  void initState() {
    loadData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        context,
        title: indianConstitutions["name"],
        fontSize: 14.5,
      ),
      body: Expanded(
        child: MyScrollBar(
          context,
          scrollCtrl: scrollCtrl,
          child: ListView.builder(
            controller: scrollCtrl,
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            itemCount: partTitle.length,
            itemBuilder: (context, idx) {
              List totalArticles =
                  indianConstitution
                      .where((el) => el.partTitle == partTitle[idx])
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
                            (context) => ListOfArticlesAfterPart(
                              partName: partTitle[idx],
                              articles: totalArticles,
                              partNo: partNo[idx],
                            ),
                      ),
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
                                partTitle[idx],
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w500,
                              ),
                              BottomDetails(
                                leftText: "Part ${partNo[idx]}",
                                rightText:
                                    "Total articles : ${totalArticles.length}",
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
