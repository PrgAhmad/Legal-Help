import 'package:flutter/material.dart';
import 'package:frontend/models/indian_constituiton_model.dart';
import 'package:frontend/widgets/bottom_details.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_scroll_bar.dart';
import 'package:frontend/widgets/my_text.dart';

class ListOfArticlesAfterPart extends StatefulWidget {
  String partName = "";
  String partNo = "";
  List articles = [];
  ListOfArticlesAfterPart({
    required this.partName,
    required this.articles,
    required this.partNo,
  });
  @override
  State<ListOfArticlesAfterPart> createState() =>
      _ListOfArticlesAfterPartState();
}

class _ListOfArticlesAfterPartState extends State<ListOfArticlesAfterPart> {
  TextEditingController searchSection = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(context, title: "Indian Constitution", fontSize: 14.5),
      body: Column(
        children: [
          Expanded(
            child: MyScrollBar(
              context,
              scrollCtrl: scrollCtrl,
              child: ListView.builder(
                controller: scrollCtrl,
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10,
                  top: 10,
                ),
                itemCount: widget.articles.length,
                itemBuilder: (context, idx) {
                  IndianConstitutionModel eachArticle = widget.articles[idx];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Future.delayed(Duration(seconds: 1));
                        Navigator.pushNamed(
                          context,
                          "/each_article",
                          arguments: eachArticle,
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
                                    widget.articles[idx].articleTitle,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  BottomDetails(
                                    leftText:
                                        "Article ${widget.articles[idx].articleNo}",
                                    rightText: "Part ${widget.partNo}",
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
        ],
      ),
    );
  }
}
