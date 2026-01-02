import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/screens/authentication/widgets/my_button.dart';
import 'package:frontend/screens/authentication/widgets/my_drop_down.dart';
import 'package:frontend/screens/authentication/widgets/my_input.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_text.dart';

class LawyerNextRegister extends StatefulWidget {
  Map formData;
  LawyerNextRegister(this.formData);
  @override
  State<LawyerNextRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<LawyerNextRegister> {
  TextEditingController barRegistrationNoCtrl = TextEditingController();
  TextEditingController yearOfExperienceCtrl = TextEditingController();
  TextEditingController specializationCtrl = TextEditingController();
  TextEditingController officeAddCtrl = TextEditingController();
  TextEditingController practiceCourtCtrl = TextEditingController();
  TextEditingController feesCtrl = TextEditingController();

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
                MyInput(
                  labelText: "Bar Registration Number",
                  hintText: "Enter your bar registration number",
                  controller: barRegistrationNoCtrl,
                  prefixIcon: Icons.numbers,
                ),
                MyInput(
                  labelText: "Year of Experience",
                  hintText: "Whats your experience?",
                  controller: yearOfExperienceCtrl,
                  inputType: TextInputType.number,
                  prefixIcon: Icons.work,
                ),
                MyDropDown(
                  labelText: "Specialization",
                  hintText: "What's your specialization?",
                  controller: specializationCtrl,
                  icon: Icons.balance,
                  entries: lawyerSpecializations,
                ),
                MyInput(
                  labelText: "Office Address",
                  hintText: "Where is your office located?",
                  controller: officeAddCtrl,
                  prefixIcon: Icons.business,
                ),
                MyInput(
                  labelText: "Court of Practice",
                  hintText: "Where are you practice?",
                  controller: practiceCourtCtrl,
                  prefixIcon: Icons.place,
                ),
                MyInput(
                  labelText: "Fees",
                  hintText: "How much do you charge?",
                  controller: feesCtrl,
                  inputType: TextInputType.number,
                  prefixIcon: Icons.currency_rupee_rounded,
                ),
                SizedBox(),
                MyButton(
                  "Register",
                  icon: Icons.person_add_alt_rounded,
                  onTap: () {
                    Map formData = {
                      ...widget.formData,
                      "barRegistrationNumber":
                          barRegistrationNoCtrl.text.toString(),
                      "yearOfExperience": yearOfExperienceCtrl.text.toString(),
                      "specialization": specializationCtrl.text.toString(),
                      "officeAddress": officeAddCtrl.text.toString(),
                      "practiceCourt": practiceCourtCtrl.text.toString(),
                      "fees": feesCtrl.text.toString(),
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
