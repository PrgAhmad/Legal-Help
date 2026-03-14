class IndianConstitutionModel {
  String? partNo;
  String? partTitle;
  String? articleNo;
  String? articleTitle;
  String? articleContent;
  IndianConstitutionModel({
    this.partNo,
    this.partTitle,
    required this.articleNo,
    required this.articleTitle,
    required this.articleContent,
  });

  factory IndianConstitutionModel.fromJson(Map<String, dynamic> map) {
    return IndianConstitutionModel(
      partNo: map["part"].toString() ?? "",
      partTitle: capitalize(map["part_title"].toString()) ?? "",
      articleNo: map["article"].toString(),
      articleTitle: map["title"],
      articleContent: map["description"],
    );
  }
}
String capitalize(String text) {
  if (text.isEmpty) return text;
  String newText = text.trim().replaceAll("  ", " ")
      .split(" ")
      .toList()
      .map((el) => el[0].toUpperCase() + el.substring(1).toLowerCase())
      .toList()
      .join(" ");
  return newText;
}


List indianConstitution = [];