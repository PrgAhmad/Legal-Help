import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_text.dart';

class MyProfileInput extends StatefulWidget {
  const MyProfileInput({super.key});

  @override
  State<MyProfileInput> createState() => _MyProfileInputState();
}

class _MyProfileInputState extends State<MyProfileInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: MyText("Profile Photo", textAlign: TextAlign.start),
          ),
        ),
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.add_a_photo_rounded, color: Theme.of(context).colorScheme.tertiaryFixed,),
        ),
      ],
    );
  }
}
