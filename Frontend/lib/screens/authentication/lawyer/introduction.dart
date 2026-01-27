import 'package:flutter/material.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/screens/authentication/lawyer/widget/my_profile_input.dart';
import 'package:frontend/screens/authentication/widgets/my_button.dart';
import 'package:frontend/screens/authentication/widgets/my_input.dart';
import 'package:frontend/screens/authentication/widgets/my_text_area.dart';
import 'package:frontend/screens/home/home.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_text.dart';

class Introduction extends StatefulWidget {
  Map formData;
  Introduction(this.formData);
  @override
  State<Introduction> createState() => IntroductionState();
}

class IntroductionState extends State<Introduction> {
  TextEditingController yearOfExperienceCtrl = TextEditingController();
  TextEditingController shortIntroCtrl = TextEditingController();
  TextEditingController detailedIntroCtrl = TextEditingController();

  String formatText(ctrl) {
    return ctrl.text.toString().trim().replaceAll("  ", " ");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(context, title: "Introduction"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            child: Column(
              spacing: 10,
              children: [
                MyProfileInput(),

                MyInput(
                  labelText: "Year of Experience",
                  hintText: "Whats your experience?",
                  controller: yearOfExperienceCtrl,
                  inputType: TextInputType.number,
                  prefixIcon: Icons.work,
                ),

                MyTextArea(
                  hintText: "Introduce yourself in one line",
                  labelText: "Short Intro",
                  maxLines: 6,
                  controller: shortIntroCtrl,
                  prefixIcon: Icons.ac_unit,
                ),

                MyTextArea(
                  hintText: "Describe yourself in detail",
                  labelText: "Detailed Intro",
                  minLines: 7,
                  maxLines: 10,
                  controller: detailedIntroCtrl,
                  prefixIcon: Icons.ac_unit,
                  suffixIcon: Icons.auto_awesome_rounded,
                ),

                SizedBox(),

                MyButton(
                  "Register",
                  icon: Icons.person_add_alt_rounded,
                  onTap: () {
                    Map formData = {
                      ...widget.formData,
                      "yearOfExperience": formatText(yearOfExperienceCtrl),
                      "shortIntro": formatText(shortIntroCtrl),
                      "detailedIntro": formatText(detailedIntroCtrl),
                    };
                    print(formData);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.login);
                  },
                  child: MyText("Already have an account? Login", fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
