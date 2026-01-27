import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/screens/authentication/widgets/my_button.dart';
import 'package:frontend/screens/authentication/widgets/my_input.dart';
import 'package:frontend/screens/authentication/widgets/my_radio_button.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailIdCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  Map formData = {"emailId": "", "password": ""};
  bool isHide = true;
  bool isLaywer = false;
  SharedPreferences? pref;

  void setIsLawyer(bool val) async {
    pref = await SharedPreferences.getInstance();
    pref!.setBool(lawyerMode, val);
    setState(() {
      isLaywer = val;
    });
  }

  void initState(){
    super.initState();
    initPref();
  }

  void initPref()async{
    pref = await SharedPreferences.getInstance();
    pref!.setBool(lawyerMode, false);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(context, title: "Login"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            // key: ,
            child: Column(
              spacing: 10,
              children: [
                MyInput(
                  labelText: "Email Id",
                  hintText: "Enter your email id",
                  inputType: TextInputType.emailAddress,
                  controller: emailIdCtrl,
                  prefixIcon: Icons.person,
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
                MyRadioButton(isLawyer: isLaywer, setIsLawyer: setIsLawyer),
                MyButton(
                  "Login",
                  icon: Icons.login,
                  onTap: () {
                    formData = {
                      "emailId": emailIdCtrl.text.trim(),
                      "password": passwordCtrl.text.trim(),
                    };
                    Navigator.pushNamed(context, MyRoutes.home);
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, MyRoutes.login);
                  },
                  child: MyText("Not have account? Register", fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
