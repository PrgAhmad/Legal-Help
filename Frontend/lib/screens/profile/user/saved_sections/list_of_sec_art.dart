import 'package:flutter/material.dart';
import 'package:frontend/screens/profile/user/saved_sections/each_sec_art.dart';
import 'package:frontend/widgets/bottom_details.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_scroll_bar.dart';
import 'package:frontend/widgets/my_text.dart';

class ListOfSecArt extends StatefulWidget {
  List savedData = [];
  String actName = "";
  ListOfSecArt({super.key, required this.savedData, required this.actName});

  @override
  State<ListOfSecArt> createState() => _ListOfSecArtState();
}

class _ListOfSecArtState extends State<ListOfSecArt> {
  ScrollController scrollCtrl = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context, title: widget.actName, fontSize: 13),
      body: MyScrollBar(
        context,
        scrollCtrl: scrollCtrl,
        child: ListView.builder(
          controller: scrollCtrl,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          itemCount: widget.savedData.length,
          itemBuilder: (context, idx) {
            bool isArticle =
                widget.savedData[idx]["actName"] == "Indian Constitution";
            Map lawData = widget.savedData[idx];
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => EachSecArt(
                            lawData: widget.savedData[idx],
                            isArticle: isArticle,
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
                              widget.savedData[idx]["secArtTitle"],
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w500,
                            ),
                            BottomDetails(
                              leftText:
                                  "${isArticle ? "Article" : "Section"} ${lawData["secArtNo"]}",
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
    );
  }
}
