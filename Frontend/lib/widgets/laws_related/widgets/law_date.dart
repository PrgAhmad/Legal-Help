import 'package:flutter/cupertino.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class LawDate extends StatelessWidget {
  String text;
  String date;
  Color color;
  LawDate({required this.text, required this.date, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        MyText(text, fontSize: 10,fontWeight: FontWeight.w500,),
        MyContainer(
          padding: EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 5,
          ),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: color, width: 0.4),
          child: MyText(
            date,
            fontSize: 10,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    )
    ;
  }
}
