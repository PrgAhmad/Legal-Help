import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/constants/experties_speciization.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/screens/authentication/lawyer/introduction.dart';
import 'package:frontend/screens/authentication/lawyer/widget/expertise.dart';
import 'package:frontend/screens/authentication/widgets/my_button.dart';
import 'package:frontend/screens/authentication/widgets/my_drop_down.dart';
import 'package:frontend/screens/authentication/widgets/my_input.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class Professional extends StatefulWidget {
  Map formData;
  Professional(this.formData);

  @override
  State<Professional> createState() => _ProfessionalState();
}

class _ProfessionalState extends State<Professional> {
  TextEditingController barCouncilIdCtrl = TextEditingController();
  TextEditingController specializationCtrl = TextEditingController();
  TextEditingController otherSpecializationCtrl = TextEditingController();
  List expertise = [];
  TextEditingController feesCtrl = TextEditingController();
  bool isOtherSpecialization = false;

  String formatText(ctrl) {
    return ctrl.text.toString().trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(context, title: "Professional"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            child: Column(
              spacing: 10,
              children: [
                MyInput(
                  labelText: "Bar Council Id",
                  hintText: "Enter your bar council id",
                  controller: barCouncilIdCtrl,
                  prefixIcon: Icons.numbers,
                ),
                MyInput(
                  labelText: "Fees",
                  hintText: "How much do you charge?",
                  controller: feesCtrl,
                  inputType: TextInputType.number,
                  prefixIcon: Icons.currency_rupee_rounded,
                ),
                MyDropDown(
                  labelText: "Specialization",
                  hintText: "Select the main area of practice",
                  controller: specializationCtrl,
                  icon: Icons.balance,
                  entries: lawyerSpecializations,
                  onSelected: (text) {
                    if (text == "other") {
                      isOtherSpecialization = true;
                    } else {
                      isOtherSpecialization = false;
                    }
                    setState(() {});
                  },
                ),
                if (isOtherSpecialization)
                  MyInput(
                    labelText: "Other",
                    hintText: "Enter your specialization.",
                    controller: otherSpecializationCtrl,
                    prefixIcon: Icons.balance,
                  ),
                Expertise(expertise: expertise),
                SizedBox(),
                MyButton(
                  "Next",
                  icon: Icons.arrow_forward,
                  onTap: () {
                    Map formData = {
                      ...widget.formData,
                      "barCouncilId": formatText(barCouncilIdCtrl),
                      "specialization": formatText(
                        isOtherSpecialization
                            ? otherSpecializationCtrl
                            : specializationCtrl,
                      ),
                      "experties": expertise,
                      "fees": formatText(feesCtrl),
                    };
                    print(formData);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Introduction(formData),
                      ),
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
