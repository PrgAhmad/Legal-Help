import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/screens/profile/user/saved_sections/list_of_sec_art.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
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


