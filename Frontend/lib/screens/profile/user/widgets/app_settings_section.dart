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
  List<bool> isSelected = [true,false];

  void initSharedPref() async{
    pref = await SharedPreferences.getInstance();
    isLight = pref!.getBool(themeMode)!;
    if(isLight){
      isSelected = [true,false];
    }else{
      isSelected = [false,true];
    }
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
        // spacing: 12,
        children: [
          ProfileMenuItem(
            icon: Icons.language,
            title: "Language",
            trailing: MyText("English", color: Colors.grey),
            onTap: () {},
          ),
          ProfileMenuItem(
            icon: Icons.light_mode,
            title: "Theme",
            trailing: ToggleButtons(
              isSelected: isSelected,
              color: Theme.of(context).colorScheme.scrim,
              borderColor: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.circular(10),
              onPressed: (int idx) {
                widget.reload();
                setState(() {
                    if(pref != null){
                      if (0 == idx) {
                        isSelected[0] = true;
                        isSelected[1] = false;
                        pref!.setBool(themeMode, true);
                      } else {
                        isSelected[1] = true;
                        isSelected[0] = false;
                        pref!.setBool(themeMode, false);
                      }
                    }
                });
              },
              children:[
                Icon(Icons.light_mode_rounded),
                Icon(Icons.dark_mode_rounded),
              ],
            ),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}