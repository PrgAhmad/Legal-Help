import 'package:flutter/material.dart';
import 'package:frontend/constants/test.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class DetailedJudgment extends StatelessWidget {
  const DetailedJudgment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context,title: "test"),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: MyContainer(child: MyText(judgment.replaceAll("\n", "").replaceAll("\t","").replaceAll("  ", "").replaceAll("Page", "\t\t\tPage"),textAlign: TextAlign.start,)),
        ),
      ),
    );
  }
}
