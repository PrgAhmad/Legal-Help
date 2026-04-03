class JudgmentModel {
  String? title;
  String? date;
  String? courtName;

  JudgmentModel({
    required this.title,
    required this.date,
    required this.courtName,
  });

  factory JudgmentModel.fromJson(Map data) {
    return JudgmentModel(
      title: data["title"],
      date: data["date"],
      courtName: data["courtName"],
    );
  }
}

List judgments = [];