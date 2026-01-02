import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:google_fonts/google_fonts.dart';

class MyChatInputBox extends StatefulWidget {
  TextEditingController controller;
  Function()? onTap;
  bool isGenerating;
  MyChatInputBox({
    super.key,
    required this.controller,
    this.onTap,
    required this.isGenerating,
  });

  @override
  State<MyChatInputBox> createState() => _MyChatInputBoxState();
}

class _MyChatInputBoxState extends State<MyChatInputBox> {
  double height = 45;
  double? inputHeight;
  @override
  Widget build(BuildContext context) {
    return MyContainer(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          MyContainer(
            isShadow: false,
            height: height,
            padding: EdgeInsets.zero,
            border: Border.all(color: Colors.transparent),
            child: TextField(
              maxLines: null,
              controller: widget.controller,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              keyboardType: TextInputType.multiline,
              onChanged: (text) {
                double t = 0;
                for (String c in text.split("")) {
                  if (c == "\n") {
                    t += 1;
                  }
                }
                if (t < 6) {
                  height = (45 + (20 * t));
                  inputHeight = (45 + (20 * t));
                  setState(() {});
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                border: InputBorder.none,
                hintText: "Ask legal query?",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.scrim,
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 5,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: widget.onTap,
                child: MyContainer(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    false
                        ? Icons.square_rounded
                        : Icons.mic,
                    color: Theme.of(context).colorScheme.scrim,
                    size: 18,
                  ),
                ),
              ),
              // MyContainer(
              //   padding: EdgeInsets.symmetric(vertical: 6,horizontal: 10),
              //   borderRadius: BorderRadius.circular(5),
              //   child: MyText("default", fontSize: 11, color: Theme.of(context).colorScheme.scrim,),
              // ),
              Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: widget.onTap,
                child: MyContainer(
                  padding: EdgeInsets.all(10),
                  color: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    widget.isGenerating
                        ? Icons.square_rounded
                        : Icons.send_rounded,
                    color: Theme.of(context).colorScheme.tertiaryFixed,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
