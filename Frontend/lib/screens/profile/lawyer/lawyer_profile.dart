import 'package:flutter/material.dart';
import 'package:frontend/screens/profile/user/widgets/app_settings_section.dart';
import 'package:frontend/screens/profile/user/widgets/my_legal_resources_section.dart';
import 'package:frontend/screens/profile/user/widgets/sub_profile.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_bottom_navigation_bar.dart';
import 'package:frontend/widgets/my_text.dart';

class LawyerProfile extends StatefulWidget {
  Function() reload;
  LawyerProfile(this.reload);

  State<LawyerProfile> createState() => LawyerProfileState();
}

class LawyerProfileState extends State<LawyerProfile> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(context, title: "Profile"),
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
              MyLegalResourcesSection(),
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
