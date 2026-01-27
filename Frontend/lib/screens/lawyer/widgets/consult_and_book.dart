import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class ConsultAndBook extends StatefulWidget {
  const ConsultAndBook({super.key});

  @override
  State<ConsultAndBook> createState() => _ConsultAndBookState();
}

class _ConsultAndBookState extends State<ConsultAndBook> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        spacing: 10,
        children: [
          MyContainer(
            height: 45,
            color: Theme.of(context).colorScheme.primary,
            child: Row(
              spacing: 6,
              children: [
                MyText(
                  'Consult',
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.tertiaryFixed,
                ),
                Icon(
                  Icons.phone_rounded,
                  size: 18,
                  color: Theme.of(context).colorScheme.tertiaryFixed,
                ),
              ],
            ),
          ),
          Expanded(
            child: MyContainer(
              height: 45,
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    'Book Appointment',
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.tertiaryFixed,
                  ),
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 18,
                    color: Theme.of(context).colorScheme.tertiaryFixed,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
