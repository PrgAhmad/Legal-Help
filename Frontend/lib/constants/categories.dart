import 'package:frontend/routes.dart';

List<Map> categories = [
  {
    "text": "Indian Constitution",
    "icon": "assets/logos/indian_constitution.png",
    "navigation": MyRoutes.articlesAndParts,
  },
  {
    "text": "Criminal Laws",
    "icon": "assets/logos/criminal_law.png",
    "navigation": MyRoutes.listOfCriminalLaws,
  },
  {
    "text": "Civil Laws",
    "icon": "assets/logos/civil_law.png",
    "navigation": MyRoutes.listOfCivilLaws,
  },
  {
    "text": "Other Laws",
    "icon": "assets/logos/other_law.png",
    "navigation": MyRoutes.listOfOtherLaws,
  },
];