import 'package:flutter/material.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/screens/authentication/lawyer/introduction.dart';
import 'package:frontend/screens/authentication/lawyer/professional.dart';
import 'package:frontend/screens/authentication/widgets/my_button.dart';
import 'package:frontend/screens/authentication/widgets/my_input.dart';
import 'package:frontend/service/form_validation.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_text.dart';

class AddressDetails extends StatefulWidget {
  Map formData;
  AddressDetails(this.formData);
  @override
  State<AddressDetails> createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  final formKey = GlobalKey<FormState>();
  TextEditingController officeAddCtrl = TextEditingController();
  TextEditingController pincodeCtrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController stateCtrl = TextEditingController();
  TextEditingController practiceCourtCtrl = TextEditingController();

  String formatText(ctrl) {
    return ctrl.text.toString().trim();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        context,
        title: "Address",
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
                MyInput(
                  labelText: "Office Address",
                  hintText: "Where is your office located?",
                  controller: officeAddCtrl,
                  prefixIcon: Icons.business,
                  validator: validateAddress,
                ),
                MyInput(
                  labelText: "Pincode",
                  hintText: "Enter the pincode.",
                  controller: pincodeCtrl,
                  inputType: TextInputType.number,
                  prefixIcon: Icons.business,
                  validator: validatePincode,
                ),
                MyInput(
                  labelText: "City",
                  hintText: "Enter the name of city.",
                  controller: cityCtrl,
                  prefixIcon: Icons.business,
                  validator: validateCity,
                ),
                MyInput(
                  labelText: "State",
                  hintText: "Enter name of state.",
                  controller: stateCtrl,
                  prefixIcon: Icons.business,
                  validator: validateState,
                ),
                MyInput(
                  labelText: "Court of Practice",
                  hintText: "Where are you practice?",
                  controller: practiceCourtCtrl,
                  prefixIcon: Icons.place,
                  validator: validateCourt,
                ),
                SizedBox(),
                MyButton(
                  "Next",
                  icon: Icons.arrow_forward,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Map formData = {
                        ...widget.formData,
                        "address": {
                          "officeAddress": formatText(officeAddCtrl),
                          "pincode": formatText(pincodeCtrl),
                          "city": formatText(cityCtrl),
                          "state": formatText(stateCtrl),
                          "practiceCourt": formatText(practiceCourtCtrl),
                        },
                      };
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Professional(formData),
                        ),
                      );
                    }
                  },
                ),
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
