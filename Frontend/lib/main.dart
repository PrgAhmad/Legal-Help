import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/screens/profile/user/user_profile.dart';
import 'package:frontend/service/person_data.dart';
import 'package:frontend/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/screens/profile/lawyer/lawyer_profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(LegalHelp());
}

class LegalHelp extends StatefulWidget {
  const LegalHelp({super.key});
  @override
  State<LegalHelp> createState() => _LegalHelpState();
}

class _LegalHelpState extends State<LegalHelp> {
  SharedPreferences? pref;
  PersonData personData = PersonData();
  String initialRoute = MyRoutes.home;

  @override
  void initState() {
    super.initState();
    initPref();
    initCheck();
  }

  void initPref() async {
    pref = await SharedPreferences.getInstance();
    if (pref!.getBool(themeMode) == null) {
      pref!.setBool(themeMode, true);
    }
    setState(() {});
  }

  void initCheck() async{
    final data = await personData.getPersonData();
    if(data == null){
      initialRoute = MyRoutes.login;
    }else{
      initialRoute = MyRoutes.home;
    }
    setState(() {
      print(initialRoute);
    });
    print("Data : ");
    print(data);
  }

  void reload() {
    print("reloading");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      themeMode:
          pref != null
              ? (pref!.getBool(themeMode)! ? ThemeMode.light : ThemeMode.dark)
              : ThemeMode.system,
      darkTheme: darkTheme,
      title: projectName,
      routes: {
        ...routes,
        MyRoutes.userProfile: (context) => UserProfile(reload),
        MyRoutes.lawyerProfile: (context) => LawyerProfile(reload),
      },
      initialRoute: initialRoute,
      color: Theme.of(context).colorScheme.secondary,
    );
  }
}
