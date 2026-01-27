import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/widgets/my_icon.dart';
import 'package:http/http.dart' as http;

class ChatOtherThing extends StatefulWidget {
  List<Map> conversations = [];
  int index;
  bool isUser;
  Function(bool) onEdit;
  Function() reload;
  TextEditingController chatInputCtrl;
  int editIndex;
  String apiUrl;
  bool isVisual;
  ChatOtherThing({
    super.key,
    required this.isUser,
    required this.conversations,
    required this.index,
    required this.onEdit,
    required this.chatInputCtrl,
    required this.reload,
    required this.editIndex,
    required this.apiUrl,
    required this.isVisual,
  });

  @override
  State<ChatOtherThing> createState() => _ChatOtherThingState();
}

class _ChatOtherThingState extends State<ChatOtherThing> {
  bool isSpeaking = false;
  FlutterTts flutterTts = FlutterTts();

  Future<void> speak(text) async {
    await flutterTts.setLanguage("en-US"); // Set language
    await flutterTts.setPitch(1.0);
    await flutterTts.setVolume(1.0); // Set pitch
    await flutterTts.speak(text); // Speak the text
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }

  Future<String> getAI(String text) async {
    final res = await http.get(
      Uri.parse("$LEGAL_HELP_BACKEND_URL${widget.apiUrl}&question=$text"),
    );
    return res.body.toString();
  }

  Widget build(BuildContext context) {
    return widget.isUser
        ? Padding(
          padding: EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 5,
            children: [
              MySmallIcon(
                context,
                icon: Icons.edit,
                onTap: () {
                  Map data = widget.conversations[widget.index];
                  widget.chatInputCtrl.text = data["msg"];
                  widget.editIndex = widget.index;
                  widget.onEdit(true);
                },
              ),
            ],
          ),
        )
        : Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 15),
          child: Row(
            spacing: 8,
            children: [
              MySmallIcon(context, icon: Icons.share),
              MySmallIcon(
                context,
                icon: Icons.copy,
                onTap: () {
                  Map data = widget.conversations[widget.index];
                  ClipboardData text = ClipboardData(text: data["msg"]);
                  Clipboard.setData(text);
                },
              ),
              MySmallIcon(
                context,
                icon: isSpeaking ? Icons.stop : Icons.volume_up,
                size: 19,
                onTap: () async {
                  if (isSpeaking) {
                    setState(() {
                      isSpeaking = false;
                    });
                    await stop();
                  } else {
                    Map data = widget.conversations[widget.index];
                    setState(() {
                      isSpeaking = true;
                    });
                    await speak(
                      data["msg"]
                          .toString()
                          .replaceAll("-", "")
                          .replaceAll("|", "")
                          .replaceAll("}", "")
                          .replaceAll("{", "")
                          .replaceAll(":", "")
                      ,
                    );
                  }
                },
              ),
              MySmallIcon(
                context,
                icon: Icons.refresh,
                size: 19,
                onTap: () async {
                  String text = widget.conversations[widget.index - 1]["msg"];
                  widget.conversations.replaceRange(
                    widget.index,
                    widget.index + 1,
                    [
                      {
                        "type": "ai",
                        "msg": "loading...",
                        "isVisual": widget.isVisual,
                      },
                    ],
                  );

                  widget.reload();
                  String aiText = await getAI(text);
                  widget.conversations.replaceRange(
                    widget.index,
                    widget.index + 1,
                    [
                      {
                        "type": "ai",
                        "msg": aiText,
                        "isVisual": widget.isVisual,
                      },
                    ],
                  );
                  widget.reload();
                },
              ),
            ],
          ),
        );
  }
}
