class AllLawsModel {
  String? sectionNo;
  String? sectionTitle;
  String? sectionContent;
  String? chapterNo;
  String? chapterTitle;
  AllLawsModel({
    this.chapterNo,
    this.chapterTitle,
    required this.sectionNo,
    required this.sectionTitle,
    required this.sectionContent,
  });

  factory AllLawsModel.fromJson(Map<String, dynamic> map) {
    return AllLawsModel(
      chapterNo: map["chapter"]?.toString() ?? "",
      chapterTitle: capitalize(map["chapter_title"].toString() ?? ""),
      sectionNo: map["section"].toString(),
      sectionTitle: map["title"],
      sectionContent: map["description"],
    );
  }
}

String capitalize(String text) {
  if (text.isEmpty) return text;
  String newText = text
      .trim()
      .replaceAll("  ", " ").toUpperCase()
      .split(" ")
      .toList()
      .map((el) {
        return el[0] + el.substring(1).toLowerCase();
      })
      .toList()
      .join(" ");
  return newText;
}

List allLaws = [];
