import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

Widget Welcome(context){
  return InkWell(
    onTap: (){},
    borderRadius: BorderRadius.circular(10),
    child: MyContainer(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              MyText(
                "Hello,",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.left,
              ),
              MyText(
                "Ahmad!",
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(5),
                width: 150,
                child: MyText(
                  "\"Injustice anywhere is a threat to justice everywhere\"",
                  fontSize: 12.5,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          Image(
            image: AssetImage("assets/images/lawyer.png"),
            height: 170,
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    ),
  );
}