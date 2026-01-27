import 'package:flutter/material.dart';
import 'package:frontend/widgets/laws_related/widgets/browse_container.dart';
import 'package:frontend/widgets/laws_related/list_of_chapters.dart';
import 'package:frontend/widgets/laws_related/list_of_sections.dart';
import 'package:frontend/widgets/laws_related/widgets/law_detail_info.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SectionAndChapters extends StatefulWidget {
  Map lawData = {};
  SectionAndChapters({required this.lawData});
  @override
  State<SectionAndChapters> createState() => _SectionAndChaptersState();
}

class _SectionAndChaptersState extends State<SectionAndChapters> {
  late SharedPreferences pref;
  @override
  void initState() {
    initPref();
    super.initState();
  }

  void initPref() async {
    pref = await SharedPreferences.getInstance();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context, title: widget.lawData["name"].toString().replaceAll("\n", ""), fontSize: 15),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            LawDetailInfo(lawData: widget.lawData),
            BrowseContainer(
              text: "Chapters",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ListOfChapters(
                          jsonPath: widget.lawData["jsonPath"],
                          lawName: widget.lawData["name"].toString().replaceAll("\n", ""),
                        ),
                  ),
                );
              },
              total: widget.lawData["totalChapters"].toString(),
            ),
            BrowseContainer(
              text: "Sections",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ListOfSections(
                          jsonPath: widget.lawData["jsonPath"],
                          lawName: widget.lawData["name"].toString().replaceAll("\n", ""),
                        ),
                  ),
                );
              },
              total: widget.lawData["totalSections"].toString(),
            ),
          ],
        ),
      ),
    );
  }
}
