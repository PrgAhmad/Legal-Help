import 'package:flutter/material.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/screens/authentication/widgets/my_button.dart';
import 'package:frontend/screens/authentication/widgets/my_drop_down.dart';
import 'package:frontend/screens/authentication/widgets/my_input.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:frontend/service/form_validation.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_text.dart';

class UserNextRegister extends StatefulWidget {
  Map formData;
  UserNextRegister(this.formData);
  @override
  State<UserNextRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserNextRegister> {
  final formKey = GlobalKey<FormState>();
  TextEditingController professionCtrl = TextEditingController();
  TextEditingController fieldCtrl = TextEditingController();
  AuthService authService = AuthService();
  String msgOrErr = "";
  void register() async{
    if (formKey.currentState!.validate()) {
      Map formData = {
        ...widget.formData,
        "profession": professionCtrl.text.toString(),
        "field": fieldCtrl.text.toString(),
      };
      print(formData);
      final data = await authService.userRegister(formData);
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        context,
        title: "Addition Details",
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
                  validator: validateField,
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
