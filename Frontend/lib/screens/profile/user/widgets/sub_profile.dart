import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/screens/profile/user/widgets/my_button.dart';
import 'package:frontend/service/person_data.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class SubProfile extends StatefulWidget {
  const SubProfile({super.key});

  @override
  State<SubProfile> createState() => _SubProfileState();
}

class _SubProfileState extends State<SubProfile> {
  PersonData personData = PersonData();
  String fullName = "";
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData()async{
    final data = await personData.getPersonData();
    fullName = data!["fullName"];
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      // height: double.,
      padding: EdgeInsets.symmetric(vertical: 18),
      margin: EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(
              Icons.person,
              size: 60,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          MyText(fullName , fontWeight: FontWeight.w600, fontSize: 15),
          Row(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                "Edit Profile",
                textColor:Theme.of(context).colorScheme.tertiaryFixed,
                icon: Icons.edit_rounded,
                iconColor: Theme.of(context).colorScheme.tertiaryFixed,
                width: (MediaQuery.sizeOf(context).width / 4) * 1.7,
                onTap: (){
                  Navigator.pushReplacementNamed(context, MyRoutes.register);
                },
              ),
              MyButton(
                "Logout",
                textColor:Theme.of(context).colorScheme.tertiaryFixed,
                icon: Icons.logout,
                iconColor: Theme.of(context).colorScheme.tertiaryFixed,
                width: (MediaQuery.sizeOf(context).width / 4) * 1.7,
                onTap: (){
                  personData.removePersonData();
                  Navigator.pushReplacementNamed(context, MyRoutes.login);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
