import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/widgets/laws_related/widgets/law_date.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LawDetailInfo extends StatefulWidget {
  Map lawData;
  LawDetailInfo({super.key, required this.lawData});

  @override
  State<LawDetailInfo> createState() => _LawDetailInfoState();
}

class _LawDetailInfoState extends State<LawDetailInfo> {
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

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      margin: EdgeInsets.only(top: 10),
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 20,
            children: [
              Image(
                image: AssetImage(
                  pref.getBool(themeMode)!
                      ? "assets/images/ashok_stambh_light.png"
                      : "assets/images/ashok_stambh_dark.png",
                ),
                height: 120,
              ),
              SizedBox(
                width: (MediaQuery.sizeOf(context).width / 4) * 2.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 10,
                  children: [
                    MyText(
                      widget.lawData["description"],
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        LawDate(
                          text: "Bill Pass At ",
                          date: widget.lawData["billPassedDate"],
                          color: Colors.blue,
                        ),
                        MyContainer(
                          height: 40,
                          width: 3,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        LawDate(
                          text: "Applicable From",
                          date: widget.lawData["applicableFrom"],
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          MyContainer(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
            borderRadius: BorderRadius.circular(7),
            color: Theme.of(context).colorScheme.primary,
            child: MyText(
              widget.lawData["ministry"],
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.tertiaryFixed,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
