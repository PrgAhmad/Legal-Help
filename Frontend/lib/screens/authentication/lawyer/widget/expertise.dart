import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/constants/experties_speciization.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class Expertise extends StatefulWidget {
  List expertise;
  Expertise({super.key, required this.expertise});

  @override
  State<Expertise> createState() => _ExpertiseState();
}

class _ExpertiseState extends State<Expertise> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: MyText("Expertise and Knowledge"),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children:
                lawyerExpertises.map((special) {
                  bool isSelected = widget.expertise
                      .contains(special);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          widget.expertise.remove(
                            special,
                          );
                        } else {
                          widget.expertise.add(special);
                        }
                      });
                    },
                    child: MyContainer(
                      borderRadius: BorderRadius.circular(8),
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 8,
                      ),
                      border: Border.all(
                        color:
                        isSelected
                            ? Colors.green
                            : Theme.of(
                          context,
                        ).colorScheme.outline,
                        width: isSelected ? 0.5 : 1.0,
                      ),
                      child: MyText(
                        special,
                        fontSize: 11,
                        color:
                        isSelected
                            ? Colors.green
                            : Theme.of(
                          context,
                        ).colorScheme.tertiary,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
