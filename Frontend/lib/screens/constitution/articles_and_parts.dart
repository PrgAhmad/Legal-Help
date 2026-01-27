import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/screens/constitution/list_of_articles.dart';
import 'package:frontend/screens/constitution/list_of_parts.dart';
import 'package:frontend/widgets/laws_related/widgets/browse_container.dart';
import 'package:frontend/widgets/laws_related/widgets/law_detail_info.dart';
import 'package:frontend/widgets/my_app_bar.dart';

class ArticlesAndParts extends StatefulWidget {
  @override
  State<ArticlesAndParts> createState() => _ArticlesAndPartsState();
}

class _ArticlesAndPartsState extends State<ArticlesAndParts> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context, title: indianConstitutions["name"], fontSize: 15),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            LawDetailInfo(lawData: indianConstitutions),
            BrowseContainer(
              text: "Parts",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListOfParts(),
                  ),
                );
              },
              total: indianConstitutions["totalParts"].toString(),
            ),
            BrowseContainer(
              text: "Articles",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListOfArticles(),
                  ),
                );
              },
              total: indianConstitutions["totalArticles"].toString(),
            ),
          ],
        ),
      ),
    );
  }
}
