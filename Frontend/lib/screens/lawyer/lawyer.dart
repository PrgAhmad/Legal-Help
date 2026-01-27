import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/constants/lawyers.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/screens/lawyer/lawyer_detail.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_bottom_navigation_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class Lawyer extends StatefulWidget {
  const Lawyer({super.key});

  @override
  State<Lawyer> createState() => _LawyerState();
}

class _LawyerState extends State<Lawyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context, title: "Lawyers"),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [Row(children: []), buildGrid()]),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }

  Widget buildGrid() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 210,
        ),
        itemCount: lawyers.length,
        itemBuilder: (context, idx) {
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LawyerDetail(
                    lawyer: lawyers[idx],
                  ),
                ),
              );
            },
            child: MyContainer(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  Container(
                    height: 75,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Image(image: AssetImage("assets/images/lawyers.png")),
                  ),
                  MyText(lawyers[idx]["name"], fontWeight: FontWeight.w700),
                  MyContainer(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.blue, width: 0.5),
                    child: MyText(
                      lawyers[idx]["type"],
                      fontSize: 9.5,
                      color: Colors.blue,
                    ),
                  ),
                  MyText(
                    lawyers[idx]["court"],
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    spacing: 10,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_city_rounded, size: 20),
                      MyText(
                        lawyers[idx]["district"],
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  // GestureDetector(
                  //   onTap: (){
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => LawyerDetail(
                  //           lawyer: lawyers[idx],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   child: MyContainer(
                  //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  //     borderRadius: BorderRadius.circular(8),
                  //     color: Theme.of(context).colorScheme.primary,
                  //     width: double.infinity,
                  //     child: Row(
                  //       spacing: 5,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         MyText(
                  //           "View Profile",
                  //           fontSize: 11,
                  //           color: Theme.of(context).colorScheme.tertiaryFixed,
                  //           fontWeight: FontWeight.w700,
                  //         ),
                  //         Icon(
                  //           Icons.arrow_forward,
                  //           size: 16,
                  //           color: Theme.of(context).colorScheme.tertiaryFixed,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, idx) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: MyContainer(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MyContainer(
                    width: 4,
                    color: Theme.of(context).colorScheme.primary,
                    height: 85,
                  ),
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 15,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 75,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Image(
                              image: AssetImage("assets/images/lawyers.png"),
                            ),
                          ),
                          Column(
                            spacing: 5,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                "Shahid Ansari",
                                fontWeight: FontWeight.w700,
                              ),
                              Row(
                                spacing: 10,
                                children: [
                                  MyText("Corporate Lawyer", fontSize: 11),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    spacing: 10,
                                    children: [
                                      MyContainer(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 3,
                                          horizontal: 5,
                                        ),
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 0.5,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                        child: MyText(
                                          "3 yrs",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      MyContainer(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 3,
                                          horizontal: 5,
                                        ),
                                        border: Border.all(
                                          color: Colors.green,
                                          width: 0.5,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          spacing: 3,
                                          children: [
                                            MyText(
                                              "4.5",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.green,
                                            ),
                                            Icon(
                                              Icons.star_rate_rounded,
                                              size: 14,
                                              color: Colors.green,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(),
                              Row(
                                spacing: 10,
                                children: [
                                  MyContainer(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 5,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    child: MyText(
                                      "Supreme Court",
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            spacing: 10,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.location_city_rounded, size: 20),
                              MyText(
                                "Mumbai",
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          MyContainer(
                            padding: EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 5,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).colorScheme.primary,
                            child: MyText(
                              "view profile",
                              fontSize: 11,
                              color:
                                  Theme.of(context).colorScheme.tertiaryFixed,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
