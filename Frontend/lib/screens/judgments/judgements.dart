import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/constants/courts.dart';
import 'package:frontend/constants/judgments.dart';
import 'package:frontend/screens/judgments/list_of_judgment.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class Judgements extends StatefulWidget {
  const Judgements({super.key});

  @override
  State<Judgements> createState() => _JudgmentsState();
}

class _JudgmentsState extends State<Judgements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context, title: "Court Judgments"),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 165,
          ),
          itemCount: courts.length,
          itemBuilder: (context, idx) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListOfJudgment()),
                );
              },
              child: MyContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        height: 90,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/courts_images/${courts[idx]["courtNick"]}.jpg",
                        ),
                      ),
                    ),
                    MyText(
                      courts[idx]["courtName"].toString().replaceAll(
                        " High",
                        "\nHigh",
                      ),
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
