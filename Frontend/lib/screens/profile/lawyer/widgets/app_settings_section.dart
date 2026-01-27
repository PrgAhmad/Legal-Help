import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/screens/profile/user/widgets/profile_menu_item.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsSection extends StatefulWidget {
  Function() reload;
  AppSettingsSection(this.reload);
  @override
  State<AppSettingsSection> createState() => _AppSettingsSectionState();
}

class _AppSettingsSectionState extends State<AppSettingsSection> {
  bool isLight = true;
  SharedPreferences? pref;

  void initSharedPref() async{
    pref = await SharedPreferences.getInstance();
    print("init");
    isLight = pref!.getBool(themeMode)!;
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    initSharedPref();
    // print("init");
  }

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          ProfileMenuItem(
            icon: Icons.notifications,
            title: "Notifications",
            onTap: () {},
          ),
          ProfileMenuItem(
            icon: Icons.language,
            title: "Language",
            trailing: MyText("English", color: Colors.grey),
            onTap: () {},
          ),
          ProfileMenuItem(
            icon: Icons.light_mode,
            title: "Theme",
            trailing: MyText(isLight ? "Light" : "Dark", color: Colors.grey),
            onTap: () {
              isLight = !isLight;
              widget.reload();
              setState(() {
                if(pref != null){
                  pref!.setBool(themeMode, isLight);
                  print(pref!.getBool(themeMode));
                }
              });
              // widget.setState();
            },
          ),
        ],
      ),
    );
  }
}