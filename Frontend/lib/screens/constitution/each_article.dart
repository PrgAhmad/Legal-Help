import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/constitution_model.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:frontend/widgets/laws_related/law_options.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class EachArticle extends StatefulWidget {
  @override
  State<EachArticle> createState() => _EachArticleState();
}

class _EachArticleState extends State<EachArticle> {
  ConstitutionModel? eachArticle;
  WidgetsToImageController widgetsToImageController = WidgetsToImageController();

  Widget build(BuildContext context) {
    eachArticle =
        ModalRoute.of(context)!.settings.arguments as ConstitutionModel;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        context,
        title: "Article ${eachArticle!.articleNo}",
        fontSize: 14,
        actions: [
          LawOptions(
            lawName: indianConstitutions["name"],
            secArtNo: eachArticle!.articleNo!,
            secArtTitle: eachArticle!.articleTitle!,
            secArtContent: eachArticle!.articleContent!,
            imageCtrl: widgetsToImageController
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [
            Expanded(
              child: SingleChildScrollView(child: ActualContent(context)),
            ),
          ],
        ),
      ),
    );
  }


  Widget ActualContent(context) {
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
                  eachArticle!.articleTitle!,
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                MyContainer(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.blue, width: 0.5),
                  child: MyText(
                    indianConstitutions["name"],
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
              eachArticle!.articleContent!,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
