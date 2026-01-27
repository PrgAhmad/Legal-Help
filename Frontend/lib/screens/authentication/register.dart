import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/authentication/lawyer/address_details.dart';
import 'package:frontend/screens/authentication/user/next_register.dart';
import 'package:frontend/screens/authentication/widgets/my_button.dart';
import 'package:frontend/screens/authentication/widgets/my_dob_input.dart';
import 'package:frontend/screens/authentication/widgets/my_drop_down.dart';
import 'package:frontend/screens/authentication/widgets/my_input.dart';
import 'package:frontend/screens/authentication/widgets/my_radio_button.dart';
import 'package:frontend/widgets/my_app_bar.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController emailIdCtrl = TextEditingController();
  TextEditingController mobileNoCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPassCtrl = TextEditingController();
  DateTime? dobCtrl;
  TextEditingController genderCtrl = TextEditingController();

  Map formData = {
    "fullName": "",
    "emailId": "",
    "mobileNumber": "",
    "password": "",
    "dateOfBirth": DateTime.now(),
    "gender": "",
  };

  bool isLaywer = false;

  void setIsLawyer(bool val) {
    setState(() {
      isLaywer = val;
    });
  }

  bool isHide = true;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(context, title: "Registration"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            // key: ,
            child: Column(
              spacing: 10,
              children: [
                MyInput(
                  labelText: "Full Name",
                  hintText: "Enter your full name",
                  controller: fullNameCtrl,
                  prefixIcon: Icons.person,
                ),
                MyInput(
                  labelText: "Email Id",
                  hintText: "Enter your email id",
                  inputType: TextInputType.emailAddress,
                  controller: emailIdCtrl,
                  prefixIcon: Icons.email,
                ),
                MyInput(
                  labelText: "Mobile Number",
                  hintText: "Enter your mobile number",
                  inputType: TextInputType.number,
                  controller: mobileNoCtrl,
                  prefixIcon: Icons.phone,
                ),
                MyInput(
                  labelText: "Password",
                  hintText: "Enter your password",
                  controller: passwordCtrl,
                  prefixIcon: Icons.lock,
                  obscureText: isHide,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isHide = !isHide;
                      });
                    },
                    child: Icon(
                      isHide
                          ? CupertinoIcons.eye_fill
                          : CupertinoIcons.eye_slash_fill,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                MyInput(
                  labelText: "Confirm Password",
                  hintText: "Confirm your password",
                  obscureText: true,
                  controller: confirmPassCtrl,
                  prefixIcon: Icons.lock,
                ),
                MyDobInput(
                  onDateSelected: (date) {
                    dobCtrl = date;
                    setState(() {});
                  },
                ),
                MyDropDown(
                  controller: genderCtrl,
                  labelText: "Gender",
                  hintText: "Select you gender",
                  icon: Icons.group,
                  entries: ["Male", "Female", "Others"],
                ),
                MyRadioButton(isLawyer: isLaywer, setIsLawyer: setIsLawyer),
                MyButton(
                  "Next",
                  icon: Icons.arrow_forward,
                  onTap: () {
                    formData = {
                      "fullName": fullNameCtrl.text.trim(),
                      "emailId": emailIdCtrl.text.trim(),
                      "mobileNumber": mobileNoCtrl.text.trim(),
                      "password": passwordCtrl.text.trim(),
                      "dateOfBirth": dobCtrl.toString().split(" ")[0],
                      "gender": genderCtrl.text.trim(),
                    };
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          if (isLaywer) {
                            return AddressDetails(formData);
                          } else {
                            return UserNextRegister(formData);
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
