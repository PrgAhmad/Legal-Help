import 'package:flutter/material.dart';
import 'package:frontend/models/all_laws_model.dart';
import 'package:frontend/widgets/laws_related/law_options.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class EachSecArt extends StatefulWidget {
  Map lawData;
  bool isArticle;
  EachSecArt({super.key, required this.lawData, required this.isArticle});

  @override
  State<EachSecArt> createState() => _EachSecArtState();
}

class _EachSecArtState extends State<EachSecArt> {
  WidgetsToImageController widgetsToImageController = WidgetsToImageController();
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        context,
        title: "${widget.isArticle ? "Article" : "Section"} ${widget.lawData["secArtNo"]}",
        fontSize: 14,
        actions: [LawOptions(
          lawName: widget.lawData["actName"],
          secArtNo: widget.lawData["secArtNo"]!,
          secArtTitle: widget.lawData["secArtTitle"]!,
          secArtContent: widget.lawData["secArtContent"]!,
          imageCtrl: widgetsToImageController,
          isAccessFromBookmark: true,
        ),],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ActualContent(context, widget.lawData["actName"]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ActualContent(context, lawName) {
    return WidgetsToImage(
      controller: widgetsToImageController,
      child: Column(
        spacing: 10,
        children: [
          MyContainer(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                MyText(
                  widget.lawData["secArtTitle"]!,
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                MyContainer(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.blue, width: 0.5),
                  child: MyText(
                    lawName,
                    fontSize: 12,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          MyContainer(
            padding: EdgeInsets.all(10),
            child: MyText(
              widget.lawData["secArtContent"]!,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

}
