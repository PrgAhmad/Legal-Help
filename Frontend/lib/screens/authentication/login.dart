import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/screens/authentication/widgets/my_button.dart';
import 'package:frontend/screens/authentication/widgets/my_input.dart';
import 'package:frontend/screens/authentication/widgets/my_radio_button.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:frontend/service/form_validation.dart';
import 'package:frontend/service/person_data.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLogining = false;
  TextEditingController emailIdCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  Map formData = {"emailId": "", "password": ""};
  bool isHide = true;
  bool isLaywer = false;
  SharedPreferences? pref;
  AuthService authService = AuthService();
  PersonData personData = PersonData();
  String msgOrErr = "";
  final formKey = GlobalKey<FormState>();

  void setIsLawyer(bool val) async {
    pref = await SharedPreferences.getInstance();
    pref!.setBool(lawyerMode, val);
    setState(() {
      isLaywer = val;
    });
  }

  void initState() {
    super.initState();
    initPref();
  }

  void initPref() async {
    pref = await SharedPreferences.getInstance();
    pref!.setBool(lawyerMode, false);
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      formData = {
        "emailId": emailIdCtrl.text.trim(),
        "password": passwordCtrl.text.trim(),
      };
      setState(() {
        isLogining = true;
      });
      if (isLaywer) {
        final data = await authService.lawyerLogin(formData);
        if (data!.containsKey("message")) {
          msgOrErr = data["message"];
          print(data["message"]);
        } else if (data!.containsKey("error")) {
          msgOrErr = data["error"];
          print(data["error"]);
        } else if (data!.containsKey("_id")) {
          personData.setIsLawyer(true);
          personData.savePersonData(data);
          Navigator.pushNamed(context, MyRoutes.home);
        }
        setState(() {
          isLogining = false;
        });
      } else {
        final data = await authService.userLogin(formData);
        if (data!.containsKey("message")) {
          msgOrErr = data["message"];
          print("test");
          print(msgOrErr);
        } else if (data!.containsKey("error")) {
          msgOrErr = data["error"];
          print(msgOrErr);
        } else if (data!.containsKey("_id")) {
          personData.setIsLawyer(false);
          personData.savePersonData(data);
          Navigator.pushNamed(context, MyRoutes.home);
        }
        setState(() {
          isLogining = false;
        });
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(context, title: "Login", titleSpacing: 15, fontSize: 18),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              spacing: 10,
              children: [
                MyInput(
                  labelText: "Email Id",
                  hintText: "Enter your email id",
                  inputType: TextInputType.emailAddress,
                  controller: emailIdCtrl,
                  prefixIcon: Icons.person,
                  validator: validateEmail,
                ),
                MyInput(
                  labelText: "Password",
                  hintText: "Enter your password",
                  controller: passwordCtrl,
                  prefixIcon: Icons.lock,
                  obscureText: isHide,
                  validator: validatePassword,
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
                MyButton("Login", icon: Icons.login, onTap: login),
                if (msgOrErr.isNotEmpty)
                  MyText(msgOrErr, color: Colors.red, fontSize: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, MyRoutes.register);
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
