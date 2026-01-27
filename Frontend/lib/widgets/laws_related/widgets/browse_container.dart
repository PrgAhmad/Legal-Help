
import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class BrowseContainer extends StatelessWidget{
  String text;
  String total;
  Function() onTap;
  BrowseContainer({required this.text, required this.onTap, required this.total});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: MyContainer(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            MyText("Browse with ${text}", fontSize: 13, fontWeight: FontWeight.w600,),
            MyContainer(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Colors.blue, width: 0.5),
              child: MyText(
                "Total ${text} : ${total}",
                fontSize: 11,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
