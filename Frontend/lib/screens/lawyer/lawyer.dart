import 'package:flutter/material.dart';
import 'package:frontend/screens/lawyer/lawyer_detail.dart';
import 'package:frontend/service/lawyer_service.dart';
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
  LawyerService lawyerService = LawyerService();
  List lawyers = [];
  @override
  void initState() {
    super.initState();
    initLawyersList();
  }

  void initLawyersList() async {
    print("init lawyer");
    lawyers = await lawyerService.getLawyersList();
    print(lawyers);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context,
        title: "Lawyers",
        titleSpacing: 15,
        fontSize: 18,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(children: []),
            lawyers.isEmpty
                ? Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Center(child: CircularProgressIndicator()),
                )
                : buildGrid(),
          ],
        ),
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LawyerDetail(lawyer: lawyers[idx]),
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
                    width: 75,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Image(
                      image:
                          lawyers[idx]["introduction"]["profilePhoto"]
                                  .toString()
                                  .isNotEmpty
                              ? NetworkImage(
                                lawyers[idx]["introduction"]["profilePhoto"],
                              )
                              : AssetImage("assets/images/lawyers.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  MyText(lawyers[idx]["fullName"], fontWeight: FontWeight.w700),
                  MyContainer(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 7),
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.blue, width: 0.5),
                    child: MyText(
                      "${lawyers[idx]["professional"]["specialization"]} Lawyer",
                      fontSize: 9.5,
                      color: Colors.blue,
                    ),
                  ),
                  MyText(
                    lawyers[idx]["address"]["practiceCourt"],
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    spacing: 10,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_city_rounded, size: 20),
                      MyText(
                        lawyers[idx]["address"]["city"],
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
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
