import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_text.dart';

class MyRadioButton extends StatefulWidget{
  bool isLawyer;
  void Function(bool) setIsLawyer;
  MyRadioButton({required this.isLawyer, required this.setIsLawyer});
  @override
  State<MyRadioButton> createState() => _MyRadioButtonState();
}

class _MyRadioButtonState extends State<MyRadioButton> {

  List opt = ["Yes", "No"];

  Widget build(BuildContext context){
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: MyText("Are you lawyer?", fontSize: 13),
        ),
        Row(
          children: [
            Radio(
              value: "Yes",
              groupValue: widget.isLawyer ? "Yes" : "No",

              onChanged: (val) {
                setState(() {
                  widget.setIsLawyer(true);
                });
              },
            ),
            MyText("Yes", textAlign: TextAlign.left, fontSize: 13),
          ],
        ),
        Row(
          children: [
            Radio(
              value: "No",
              groupValue: widget.isLawyer ? "Yes" : "No",
              onChanged: (val) {
                setState(() {
                  widget.setIsLawyer(false);
                });
              },
            ),
            MyText("No", textAlign: TextAlign.left, fontSize: 13),
          ],
        ),
      ],
    );
  }
}