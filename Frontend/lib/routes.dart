import 'package:flutter/cupertino.dart';
import 'package:frontend/screens/authentication/login.dart';
import 'package:frontend/screens/authentication/register.dart';
import 'package:frontend/screens/chatbot/chatbot.dart';
import 'package:frontend/screens/civil_laws/list_of_civil_laws.dart';
import 'package:frontend/screens/indian_constitution/articles_and_parts.dart';
import 'package:frontend/screens/other_laws/list_of_other_laws.dart';
import 'package:frontend/widgets/laws_related/each_section.dart';
import 'package:frontend/screens/criminal_laws/list_of_criminal_laws.dart';
import 'package:frontend/screens/home/home.dart';
import 'package:frontend/screens/indian_constitution/each_article.dart';

class MyRoutes{
  static String home = "/";
  static String chatbot = "/chatbot";
  static String userRegister = "/user/register";
  static String userLogin = "/user/login";
  static String userProfile="/user/profile";
  static String articlesAndParts = "/articles_and_parts";
  static String eachArticle = "/each_article";
  static String listOfCriminalLaws = "/list_of_criminal_laws";
  static String listOfCivilLaws = "/list_of_civil_laws";
  static String listOfOtherLaws = "/list_of_other_laws";
  static String eachSection = "/each_section";
}

Map<String, Widget Function(BuildContext)> routes = {
  MyRoutes.home: (context) => Home(),
  MyRoutes.chatbot: (context) => Chatbot(),
  MyRoutes.userRegister: (context) => UserRegister(),
  MyRoutes.userLogin: (context) => UserLogin(),
  MyRoutes.articlesAndParts: (context) => ArticlesAndParts(),
  MyRoutes.eachArticle: (context) => EachArticle(),
  MyRoutes.listOfCriminalLaws: (context) => ListOfCriminalLaws(),
  MyRoutes.listOfCivilLaws: (context) => ListOfCivilLaws(),
  MyRoutes.listOfOtherLaws: (context) => ListOfOtherLaws(),
  MyRoutes.eachSection: (context) => EachSection(),
};