import 'package:flutter/material.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/screens/authentication/widgets/my_button.dart';
import 'package:frontend/screens/authentication/widgets/my_drop_down.dart';
import 'package:frontend/screens/authentication/widgets/my_input.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_text.dart';

class UserNextRegister extends StatefulWidget {
  Map formData;
  UserNextRegister(this.formData);
  @override
  State<UserNextRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserNextRegister> {
  TextEditingController professionCtrl = TextEditingController();
  TextEditingController fieldCtrl = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(context, title: "Addition Details"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            child: Column(
              spacing: 10,
              children: [
                MyDropDown(
                  labelText: "Profession",
                  hintText: "What's your profession?",
                  controller: professionCtrl,
                  icon: Icons.person,
                  entries: [
                    "Student",
                    "Engineer",
                    "Teacher",
                    "Worker",
                    "Other",
                  ],
                ),
                MyInput(
                  labelText: "Field",
                  hintText: "What's your field?",
                  controller: fieldCtrl,
                  prefixIcon: Icons.person,
                ),
                SizedBox(),
                MyButton(
                  "Register",
                  icon: Icons.person_add_alt_rounded,
                  onTap: () {
                    Map formData = {
                      ...widget.formData,
                      "profession": professionCtrl.text.toString(),
                      "field": fieldCtrl.text.toString(),
                    };
                    print(formData);
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.userLogin);
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
