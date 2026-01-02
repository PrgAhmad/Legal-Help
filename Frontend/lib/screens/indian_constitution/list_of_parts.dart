import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/all_laws_model.dart';
import 'package:frontend/models/indian_constituiton_model.dart';
import 'package:frontend/screens/indian_constitution/list_of_articles_after_part.dart';
import 'package:frontend/widgets/laws_related/list_of_section_after_chapter.dart';
import 'package:frontend/widgets/laws_related/my_search.dart';
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
        indianConstitution.map((el) => el.partNo.toString()).toList().toSet().toList();
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
      appBar: MyAppBar(context, title: indianConstitutions["name"], fontSize: 14.5),
      body: Expanded(
        child: MyScrollBar(
          context,
          scrollCtrl: scrollCtrl,
          child: ListView.builder(
            controller: scrollCtrl,
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
            itemCount: partTitle.length,
            itemBuilder: (context, idx) {
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
                          articles:
                          indianConstitution
                              .where(
                                (el) =>
                            el.partTitle == partTitle[idx],
                          )
                              .toList(),
                        ),
                      ),
                    );
                  },
                  child: MyContainer(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(10, 15, 15, 15),
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
                            spacing: 5,
                            children: [
                              MyText(
                                "Part " + partNo[idx],
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                              MyText(
                                partTitle[idx],
                                textAlign: TextAlign.start,
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
