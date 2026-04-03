import 'package:flutter/material.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/screens/authentication/lawyer/widget/profile_input.dart';
import 'package:frontend/screens/authentication/widgets/my_button.dart';
import 'package:frontend/screens/authentication/widgets/my_input.dart';
import 'package:frontend/screens/authentication/widgets/my_text_area.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:frontend/service/form_validation.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_text.dart';

class Introduction extends StatefulWidget {
  Map formData;
  Introduction(this.formData);
  @override
  State<Introduction> createState() => IntroductionState();
}

class IntroductionState extends State<Introduction> {
  final formKey = GlobalKey<FormState>();
  TextEditingController yearOfExperienceCtrl = TextEditingController();
  TextEditingController shortIntroCtrl = TextEditingController();
  TextEditingController detailedIntroCtrl = TextEditingController();
  String profilePhotoUrl = "";

  String formatText(ctrl) {
    return ctrl.text.toString().trim().replaceAll("  ", " ");
  }

  AuthService authService = AuthService();
  String msgOrErr = "";

  void register() async {
    if (formKey.currentState!.validate()) {
      Map formData = {
        ...widget.formData,
        "introduction": {
          "profilePhoto": profilePhotoUrl,
          "yearOfExperience": formatText(yearOfExperienceCtrl),
          "shortIntro": formatText(shortIntroCtrl),
          "detailedIntro": formatText(detailedIntroCtrl),
        }
      };
      print(formData);
      final data = await authService.lawyerRegister(formData);
      if (data!.containsKey("message")) {
        msgOrErr = data["message"];
        print(data["message"]);
      } else if (data!.containsKey("error")) {
        msgOrErr = data["message"];
        print(data["error"]);
      } else if (data!.containsKey("_id")) {
        Navigator.pushNamed(context, MyRoutes.login);
      }
      setState(() {

      });
    }
  }

  void setImage(String imageUrl){
    profilePhotoUrl = imageUrl;
    setState(() {

    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        context,
        title: "Introduction",
        titleSpacing: 15,
        fontSize: 18,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              spacing: 10,
              children: [
                ProfileInput(setImage: setImage,),
                MyInput(
                  labelText: "Year of Experience",
                  hintText: "Whats your experience?",
                  controller: yearOfExperienceCtrl,
                  inputType: TextInputType.number,
                  prefixIcon: Icons.work,
                  validator: validateExperience,
                ),

                MyTextArea(
                  hintText: "Introduce yourself in one line",
                  labelText: "Short Intro",
                  maxLines: 6,
                  controller: shortIntroCtrl,
                  prefixIcon: Icons.ac_unit,
                  validator: validateShortIntro,
                ),

                MyTextArea(
                  hintText: "Describe yourself in detail",
                  labelText: "Detailed Intro",
                  minLines: 7,
                  maxLines: 10,
                  controller: detailedIntroCtrl,
                  prefixIcon: Icons.ac_unit,
                  suffixIcon: Icons.auto_awesome_rounded,
                  validator: validateDetailedIntro,
                ),

                SizedBox(),

                MyButton(
                  "Register",
                  icon: Icons.person_add_alt_rounded,
                  onTap: register,
                ),
                if(msgOrErr.isNotEmpty) MyText(msgOrErr,color: Colors.red,fontSize: 12,),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, MyRoutes.login);
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
