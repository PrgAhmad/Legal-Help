import 'package:flutter/cupertino.dart';
import 'package:frontend/screens/authentication/login.dart';
import 'package:frontend/screens/authentication/register.dart';
import 'package:frontend/screens/chatbot/chatbot.dart';
import 'package:frontend/screens/bare_laws/list_of_civil_laws.dart';
import 'package:frontend/screens/constitution/articles_and_parts.dart';
import 'package:frontend/screens/bare_laws/list_of_other_laws.dart';
import 'package:frontend/screens/judgments/judgements.dart';
import 'package:frontend/screens/lawyer/lawyer.dart';
import 'package:frontend/widgets/laws_related/each_section.dart';
import 'package:frontend/screens/bare_laws/list_of_criminal_laws.dart';
import 'package:frontend/screens/home/home.dart';
import 'package:frontend/screens/constitution/each_article.dart';

class MyRoutes{
  static String home = "/";
  static String judgements = "/judgements";
  static String chatbot = "/chatbot";
  static String lawyer = "/lawyer";
  static String lawyerDetail  = "/lawyer/detail";
  static String client = "/client";
  static String userProfile="/user/profile";
  static String lawyerProfile="/lawyer/profile";

  static String register = "/register";
  static String login = "/login";

  static String articlesAndParts = "/articles_and_parts";
  static String eachArticle = "/each_article";

  static String listOfCriminalLaws = "/list_of_criminal_laws";
  static String listOfCivilLaws = "/list_of_civil_laws";
  static String listOfOtherLaws = "/list_of_other_laws";
  static String eachSection = "/each_section";
}

Map<String, Widget Function(BuildContext)> routes = {
  MyRoutes.home: (context) => Home(),
  MyRoutes.judgements: (context) => Judgements(),
  MyRoutes.chatbot: (context) => Chatbot(),
  MyRoutes.lawyer: (context) => Lawyer(),
  // MyRoutes.lawyerDetail: (context) => LawyerDetail(),

  MyRoutes.register: (context) => Register(),
  MyRoutes.login: (context) => Login(),

  MyRoutes.articlesAndParts: (context) => ArticlesAndParts(),
  MyRoutes.eachArticle: (context) => EachArticle(),

  MyRoutes.listOfCriminalLaws: (context) => ListOfCriminalLaws(),
  MyRoutes.listOfCivilLaws: (context) => ListOfCivilLaws(),
  MyRoutes.listOfOtherLaws: (context) => ListOfOtherLaws(),
  MyRoutes.eachSection: (context) => EachSection(),
};