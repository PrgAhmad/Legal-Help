import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/indian_constituiton_model.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class EachArticle extends StatelessWidget {
  Widget build(BuildContext context) {
    IndianConstitutionModel eachArticle =
        ModalRoute.of(context)!.settings.arguments as IndianConstitutionModel;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(context, title: "Article " + eachArticle.articleNo!),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
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
                    eachArticle.articleTitle!,
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
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
                eachArticle.articleContent!,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () async {
          ClipboardData data = ClipboardData(
            text:
                "Indian Constitution\nSection ${eachArticle.articleNo!}\n${eachArticle.articleTitle!}\n\n${eachArticle.articleContent!}",
          );
          await Clipboard.setData(data);
        },
        child: Icon(Icons.copy, color: Theme.of(context).colorScheme.tertiaryFixed),
      ),
    );
  }
}
