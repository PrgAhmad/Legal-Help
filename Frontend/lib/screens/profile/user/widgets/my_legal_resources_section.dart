import 'package:flutter/material.dart';
import 'package:frontend/screens/profile/user/widgets/profile_menu_item.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class MyLegalResourcesSection extends StatelessWidget {
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
            icon: Icons.bookmark,
            title: "Saved Sections",
            onTap: () {},
          ),
          ProfileMenuItem(
            icon: Icons.article,
            title: "Saved Legal Terms",
            onTap: () {},
          ),
          ProfileMenuItem(
            icon: Icons.gavel_rounded,
            title: "Saved Judgments",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}