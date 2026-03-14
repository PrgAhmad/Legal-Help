import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/widgets/bottom_details.dart';
import 'package:frontend/widgets/laws_related/each_section.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_scroll_bar.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedSections extends StatefulWidget {
  List savedData = [];
  SavedSections({super.key, required this.savedData});

  @override
  State<SavedSections> createState() => _SavedSectionsState();
}

class _SavedSectionsState extends State<SavedSections> {

  late SharedPreferences pref;

  void initPref() async {
    pref = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPref();
  }

  @override
  Widget build(BuildContext context) {
    List laws =
        widget.savedData.map((el) => el["actName"]).toList().toSet().toList();
    return Scaffold(
      appBar: MyAppBar(context, title: "Saved Sections"),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 190,
        ),
        itemCount: laws.length,
        itemBuilder: (context, idx) {
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ListOfSecArt(
                      savedData: widget.savedData.where((el) => el["actName"] == laws[idx]).toList(),
                      actName: laws[idx],
                    );
                  },
                ),
              );
            },
            child: MyContainer(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Image(
                    image: AssetImage(
                      pref.getBool(themeMode)!
                          ? "assets/images/ashok_stambh_light.png"
                          : "assets/images/ashok_stambh_dark.png",
                    ),
                    height: 95,
                  ),
                  MyText(laws[idx], fontWeight: FontWeight.w700),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
//
// Widget ListOfSecArt(context, scrollCtrl, savedData, actName) {
//   List newData = savedData.where((el) => el["actName"] == actName).toList();
// }

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
            bool isArticle = widget.savedData[idx]["actName"] == "Indian Constitution";
            Map lawData = widget.savedData[idx];
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
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
