import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/debouncer.dart';
import 'package:frontend/screens/chatbot/widgets/widgets/chat_input_options.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_icon.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class MyChatInputBox extends StatefulWidget {
  TextEditingController controller;
  Function()? onTap;
  bool isGenerating;
  Function(int, int) setApiUrl;
  MyChatInputBox({
    super.key,
    required this.controller,
    this.onTap,
    required this.isGenerating,
    required this.setApiUrl,
  });

  @override
  State<MyChatInputBox> createState() => _MyChatInputBoxState();
}

class _MyChatInputBoxState extends State<MyChatInputBox> {
  final debouncer = Debouncer(milliseconds: 500);
  double height = 45;
  double? inputHeight;

  List predictions = [];

  TextEditingController controller = TextEditingController();
  int typeIdx = 0;
  int styleIdx = 0;

  bool isOptimizing = false;

  Future<String> getOptimizedPrompt(String text) async {
    isOptimizing = true;
    setState(() {});
    final res = await http.get(
      Uri.parse("$LEGAL_HELP_BACKEND_URL/ai/optimize_prompt?prompt=$text"),
    );
    isOptimizing = false;
    setState(() {});
    return res.body.toString();
  }

  Future<List> getPredictions(String text) async {
    print(text);
    final res = await http.get(
      Uri.parse("$LEGAL_HELP_BACKEND_URL/ai/predict_prompts?prompt=$text"),
    );
    print(res.body);
    return [];
  }


  @override
  Widget build(BuildContext context) {
    return MyContainer(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          Row(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MyContainer(
                  isShadow: false,
                  padding: EdgeInsets.zero,
                  border: Border.all(color: Colors.transparent),
                  child: TextField(
                    minLines: 1,
                    maxLines: 8,
                    controller: widget.controller,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    keyboardType: TextInputType.multiline,
                    onChanged: (text) {
                      // increaseBox(text);
                      // if (text.length > 3) {
                      //   debouncer.run(() async {
                      //     await getPredictions(text);
                      //   });
                      // }
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () async {
                    widget.controller.text = await getOptimizedPrompt(
                      widget.controller.text,
                    );
                    setState(() {});
                  },
                  child:
                      isOptimizing
                          ? CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.tertiary,
                            strokeWidth: 2,
                            constraints: BoxConstraints(
                              maxHeight: 20,
                              maxWidth: 20,
                              minHeight: 20,
                              minWidth: 20,
                            ),
                          )
                          : MySmallIcon(
                            context,
                            icon: Icons.auto_awesome_rounded,
                            size: 20,
                          ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 10,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: MyContainer(
                  padding: EdgeInsets.all(10),
                  // border: Border.all(color: Theme.of(context).colorScheme.tertiary, width: 0.5),
                  color: Theme.of(context).colorScheme.primary,
                  child: Icon(
                    Icons.mic,
                    color: Theme.of(context).colorScheme.tertiaryFixed,
                    size: 18,
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  void onSelected(idx) {
                    typeIdx = idx;
                    setState(() {});
                    widget.setApiUrl(styleIdx, typeIdx);
                  }

                  showBottomSheet(
                    context: context,
                    builder: (context) {
                      return ChatInputOptions(
                        options: generateTypes,
                        onSelected: onSelected,
                        selectedIdx: typeIdx,
                      );
                    },
                  );
                },
                child: MyContainer(
                  padding: EdgeInsets.all(8),
                  child: MyText(generateTypes[typeIdx], fontSize: 10),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  void onSelected(idx) {
                    styleIdx = idx;
                    setState(() {});
                    widget.setApiUrl(styleIdx, typeIdx);
                  }

                  showBottomSheet(
                    context: context,
                    builder: (context) {
                      return ChatInputOptions(
                        options: generateStyles,
                        onSelected: onSelected,
                        selectedIdx: styleIdx,
                      );
                    },
                  );
                },
                child: MyContainer(
                  padding: EdgeInsets.all(8),
                  child: MyText(generateStyles[styleIdx], fontSize: 10),
                ),
              ),
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
