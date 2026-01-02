import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/widgets/laws_related/list_of_chapters.dart';
import 'package:frontend/widgets/laws_related/list_of_sections.dart';
import 'package:frontend/widgets/laws_related/section_and_chapters.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListOfCriminalLaws extends StatefulWidget {
  const ListOfCriminalLaws({super.key});

  @override
  State<ListOfCriminalLaws> createState() => _ListOfCriminalLawsState();
}

class _ListOfCriminalLawsState extends State<ListOfCriminalLaws> {
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
      appBar: MyAppBar(context, title: "Criminal Laws"),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 180,
        ),
        itemCount: criminalLaws.length,
        itemBuilder: (context, idx) {
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SectionAndChapters(lawData: criminalLaws[idx],);
                  },
                ),
              );
            },
            child: MyContainer(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  Image(
                    image: AssetImage(pref.getBool(themeMode)! ? "assets/images/ashok_stambh_light.png" : "assets/images/ashok_stambh_dark.png"),
                    height: 75,
                  ),
                  MyText(
                    criminalLaws[idx]["name"],
                    fontSize: 14,
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
