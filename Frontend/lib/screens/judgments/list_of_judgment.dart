import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/screens/judgments/widget/filter_judgment.dart';
import 'package:frontend/widgets/bottom_details.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ListOfJudgment extends StatefulWidget {
  String courtName = "";
  ListOfJudgment({super.key, required this.courtName});

  @override
  State<ListOfJudgment> createState() => _ListOfJudgmentState();
}

class _ListOfJudgmentState extends State<ListOfJudgment> {
  ScrollController scrollCtrl = ScrollController();
  TextEditingController judgmentCtrl = TextEditingController();
  TextEditingController others = TextEditingController(text: "Most Recent");
  String fromDate = "";
  String toDate = "";
  List judgmentData = [];
  int pageIdx = 0;

  void loadJudgmentData(otherPart, {bool isFilter = false}) async {
    if (isFilter) {
      judgmentData = [];
      setState(() {});
    }
    String baseUrl =
        "$LEGAL_HELP_BACKEND_URL2/judgment/get_by_court?court_name=${widget.courtName}&";
    final url = Uri.parse(baseUrl + otherPart);
    final res = await http.get(url);
    print(res);
    final data = jsonDecode(res.body);
    judgmentData = judgmentData + data["judgements"];
    print(judgmentData);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadJudgmentData("page_idx=${pageIdx}");
    scrollCtrl.addListener(() {
      if (scrollCtrl.position.pixels >=
              scrollCtrl.position.maxScrollExtent - 120 &&
          pageIdx < 40) {
        pageIdx++;
        setState(() {});
        loadJudgmentData("page_idx=${pageIdx}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context,
        title: "Court Judgments",
        actions: [
          FilterJudgment(
            fromDate: fromDate,
            toDate: toDate,
            others: others,
            setData: loadJudgmentData,
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          spacing: 10,
          children: [
            // MyContainer(
            //   padding: EdgeInsets.only(left: 10, right: 10),
            //   height: 50,
            //   child: Theme(
            //     data: ThemeData(
            //       textSelectionTheme: TextSelectionThemeData(
            //         selectionColor: Colors.blue.shade100,
            //         cursorColor: Theme.of(context).colorScheme.primary,
            //         selectionHandleColor: Theme.of(context).colorScheme.primary,
            //       ),
            //     ),
            //     child: TextField(
            //       controller: judgmentCtrl,
            //       onChanged: (text) {},
            //       autocorrect: true,
            //       style: GoogleFonts.poppins(
            //         color: Theme.of(context).colorScheme.tertiary,
            //         fontSize: 12.5,
            //       ),
            //       decoration: InputDecoration(
            //         suffix: GestureDetector(
            //           onTap: () {},
            //           child: Icon(
            //             CupertinoIcons.multiply,
            //             color: Theme.of(context).colorScheme.tertiary,
            //           ),
            //         ),
            //         iconColor: Theme.of(context).colorScheme.tertiary,
            //         icon: Icon(Icons.search),
            //         hintText: "Search judgments",
            //         border: InputBorder.none,
            //         hintStyle: GoogleFonts.poppins(
            //           color: Theme.of(context).colorScheme.tertiary,
            //           fontSize: 12.5,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            judgmentData.isEmpty
                ? Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height / 2 - 50,
                  ),
                  child: Center(child: CircularProgressIndicator()),
                )
                : Expanded(
                  child: ListView.builder(
                    itemCount: judgmentData.length + 1,
                    controller: scrollCtrl,
                    itemBuilder: (context, idx) {
                      if (judgmentData.length == idx && pageIdx < 40) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () async {
                              final url = Uri.parse(judgmentData[idx]["detailedUrl"] ?? "");

                              if (await canLaunchUrl(url)) {
                                await launchUrl(url, mode: LaunchMode.inAppWebView);
                              } else {
                                print("Cannot launch");
                              }
                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (context) => DetailedJudgment(),
                              // ));
                            },
                            child: MyContainer(
                              child: Row(
                                spacing: 10,
                                children: [
                                  MyContainer(
                                    width: 4,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    height: 70,
                                  ),
                                  Expanded(
                                    child: Column(
                                      spacing: 10,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          judgmentData[idx]["title"] ?? "test",
                                          textAlign: TextAlign.start,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        BottomDetails(
                                          leftText:
                                              judgmentData[idx]["courtName"] ??
                                              "",
                                          rightText:
                                              judgmentData[idx]["date"] ?? "",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
