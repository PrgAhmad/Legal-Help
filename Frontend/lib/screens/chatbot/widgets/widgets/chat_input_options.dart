import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class ChatInputOptions extends StatefulWidget {
  List options;
  Function(int) onSelected;
  int selectedIdx;
  ChatInputOptions({super.key, required this.options, required this.onSelected, required this.selectedIdx});

  @override
  State<ChatInputOptions> createState() => _ChatInputOptionsState();
}

class _ChatInputOptionsState extends State<ChatInputOptions> {
  @override
  Widget build(BuildContext context) {
    return MyContainer(
      width: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: List.generate(widget.options.length, (idx) {
          return MyContainer(
            width: double.infinity,
            color:
            idx == widget.selectedIdx
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
            isShadow: false,
            child: GestureDetector(
              onTap: (){
                widget.onSelected(idx);
                Navigator.pop(context);
              },
              child: MyText(
                widget.options[idx],
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color:
                idx == 0
                    ? Theme.of(
                  context,
                ).colorScheme.tertiaryFixed
                    : Theme.of(
                  context,
                ).colorScheme.tertiary,
              ),
            ),
          );
        }),
      ),
    );
  }
}
