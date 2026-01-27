import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/all_laws_model.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class EachSection extends StatelessWidget {
  const EachSection({super.key});

  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    String lawName = data["lawName"];
    AllLawsModel eachSection = data["eachSection"];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(context, title: "Section ${eachSection.sectionNo!}"),
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
                    eachSection.sectionTitle!,
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.w600,
                    fontSize: 15
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
                eachSection.sectionContent!,
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
                "$lawName\nSection ${eachSection.sectionNo!}\n${eachSection.sectionTitle!}\n\n${eachSection.sectionContent!}",
          );
          await Clipboard.setData(data);
        },
        child: Icon(Icons.copy, color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
