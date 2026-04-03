import 'package:flutter/material.dart';
import 'package:frontend/screens/profile/user/widgets/app_settings_section.dart';
import 'package:frontend/screens/profile/user/widgets/legal_resources.dart';
import 'package:frontend/screens/profile/user/widgets/sub_profile.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_bottom_navigation_bar.dart';
import 'package:frontend/widgets/my_text.dart';

class UserProfile extends StatefulWidget {
  Function() reload;
  UserProfile(this.reload);

  State<UserProfile> createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(context, title: "Profile", titleSpacing: 15, fontSize: 18),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubProfile(),
              MyText(
                "My Legal Resources",
                fontSize: 16,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.left,
              ),
              LegalResources(),
              MyText(
                "App Settings",
                fontSize: 16,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.left,
              ),
              AppSettingsSection(widget.reload),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
