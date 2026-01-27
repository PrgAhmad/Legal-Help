import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class MyDobInput extends StatefulWidget {
  Function(DateTime) onDateSelected;
  MyDobInput({required this.onDateSelected});

  @override
  State<MyDobInput> createState() => _MyDobInputState();
}

class _MyDobInputState extends State<MyDobInput> {
  DateTime? dob;
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: MyText(
            "Date of Birth",
            fontSize: 13,
            textAlign: TextAlign.left,
          ),
        ),
        GestureDetector(
          onTap: () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1990),
              lastDate: DateTime.now(),
            );
            widget.onDateSelected(date!);
            dob = date!;
            print(dob.toString().split(" ")[0]);
            setState(() {});
          },
          child: MyContainer(
            width: double.infinity,
            height: 50,
            child: Row(
              spacing: 10,
              children: [
                Icon(
                  Icons.date_range_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                MyText(
                  dob != null
                      ? dob.toString().split(" ")[0]
                      : "Select date of birth",
                  color:
                      dob != null
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.scrim,
                  fontSize: 13,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
