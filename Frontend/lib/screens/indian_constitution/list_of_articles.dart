import 'dart:convert';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/indian_constituiton_model.dart';
import 'package:frontend/screens/indian_constitution/widgets/my_search.dart';
import 'package:frontend/widgets//my_text.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_scroll_bar.dart';

class ListOfArticles extends StatefulWidget {
  const ListOfArticles({super.key});

  @override
  State<ListOfArticles> createState() => _ListOfArticlesState();
}

class _ListOfArticlesState extends State<ListOfArticles> {
  List originalList = [];
  TextEditingController searchArticle = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  void loadData() async {
    String stringData = await rootBundle.loadString(
      indianConstitutions["jsonPath"],
    );
    List jsonData = await jsonDecode(stringData);
    indianConstitution =
        jsonData.map((el) => IndianConstitutionModel.fromJson(el)).toList();
    originalList = indianConstitution;
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
      appBar: MyAppBar(context, title: indianConstitutions["name"]),
      body: Column(
        children: [
          MySearch(context, setState, originalList, searchArticle),
          indianConstitution.isNotEmpty
              ? Expanded(
                child: MyScrollBar(
                  context,
                  scrollCtrl: scrollCtrl,
                  child: ListView.builder(
                    controller: scrollCtrl,
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    itemCount: indianConstitution.length,
                    itemBuilder: (context, idx) {
                      IndianConstitutionModel article = indianConstitution[idx];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            IndianConstitutionModel eachArticle =
                                IndianConstitutionModel(
                                  articleNo: article.articleNo,
                                  articleTitle: article.articleTitle,
                                  articleContent: article.articleContent,
                                );
                            Future.delayed(Duration(seconds: 1));
                            Navigator.pushNamed(
                              context,
                              "/each_article",
                              arguments: eachArticle,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 5,
                                    children: [
                                      MyText(
                                        "Article ${article.articleNo!}",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                      MyText(
                                        article.articleTitle!,
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
              )
              : Center(child: CircularProgressIndicator(color: Colors.blue)),
        ],
      ),
    );
  }
}
