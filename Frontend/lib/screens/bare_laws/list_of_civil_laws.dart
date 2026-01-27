import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/constants/civils.dart';
import 'package:frontend/widgets/laws_related/list_of_sections.dart';
import 'package:frontend/widgets/laws_related/section_and_chapters.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListOfCivilLaws extends StatefulWidget {
  @override
  State<ListOfCivilLaws> createState() => _ListOfCivilLawsState();
}

class _ListOfCivilLawsState extends State<ListOfCivilLaws> {
  late SharedPreferences pref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPref();
  }

  void initPref() async{
    pref = await SharedPreferences.getInstance();
    setState(() {

    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(context, title: "Civil Laws"),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 190,
        ),
        itemCount: civilLaws.length,
        itemBuilder: (context, idx) {
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SectionAndChapters(lawData: civilLaws[idx]);
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
                    image: AssetImage(pref.getBool(themeMode)! ? "assets/images/ashok_stambh_light.png" : "assets/images/ashok_stambh_dark.png"),
                    height: 95,
                  ),
                  MyText(
                    civilLaws[idx]["name"],
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
