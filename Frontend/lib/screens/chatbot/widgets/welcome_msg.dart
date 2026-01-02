import 'package:flutter/cupertino.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class WelcomeMsg extends StatefulWidget {
  Function(String) addText;
  WelcomeMsg({super.key, required this.addText});
  @override
  State<WelcomeMsg> createState() => _WelcomeMsgState();
}

class _WelcomeMsgState extends State<WelcomeMsg> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText(
              "How can I help you today?",
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
            GestureDetector(
              onTap: () {
                widget.addText("What if someone hits me?");
              },
              child: MyContainer(
                child: MyText("What if someone hits me?", fontSize: 12),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.addText("What is section 20?");
              },
              child: MyContainer(
                child: MyText("What is section 20?", fontSize: 12),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.addText("Explain FIR in easy words.");
              },
              child: MyContainer(child: MyText("Explain FIR in easy words.", fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
