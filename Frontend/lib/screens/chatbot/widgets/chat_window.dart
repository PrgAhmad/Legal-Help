import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_streaming_text_markdown/flutter_streaming_text_markdown.dart';
import 'package:frontend/screens/chatbot/widgets/chat_visuals.dart';
import 'package:frontend/screens/chatbot/widgets/widgets/chat_other_thing.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatWindow extends StatefulWidget {
  List<Map> conversations = [];
  ScrollController scrollCtrl;
  Function(bool) onEdit;
  TextEditingController chatInputCtrl;
  int editIndex;
  Function() reload;
  bool isGenerated;
  String apiUrl;
  bool isVisual;

  ChatWindow({
    super.key,
    required this.conversations,
    required this.scrollCtrl,
    required this.onEdit,
    required this.chatInputCtrl,
    required this.editIndex,
    required this.reload,
    required this.isGenerated,
    required this.apiUrl,
    required this.isVisual,
  });

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {

  bool isAnimation(data, idx) {
    return data["type"] == "user"
        ? false
        : data["type"] == "ai" &&
            (widget.conversations.length - 1) == idx &&
            !widget.isGenerated
        ? true
        : false;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: ListView.builder(
        itemCount: widget.conversations.length,
        controller: widget.scrollCtrl,
        itemBuilder: (context, idx) {
          Map data = widget.conversations[idx];
          bool isUser = data["type"] == "user";
          bool temp = data["isVisual"] ?? false;
          bool isVisual = !isUser && data["isVisual"] && data["msg"] != "loading...";
          Map jsonData = {};
          if(isVisual){
            print(data["msg"]);
            jsonData = jsonDecode(data["msg"]);
            print(jsonData);
          }
          return Align(
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              spacing: 2,
              children: [
                isVisual
                    ? ChatVisuals(data: jsonData)
                    : Container(
                      constraints: BoxConstraints(
                        minWidth: 0,
                        maxWidth:
                            isUser
                                ? MediaQuery.sizeOf(context).width * 0.75
                                : MediaQuery.sizeOf(context).width,
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color:
                            data["type"] == "user"
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                        border:
                            data["type"] == "user"
                                ? Border.all(
                                  color: Theme.of(context).colorScheme.outline,
                                )
                                : Border(),
                      ),
                      child: IntrinsicWidth(
                        child: StreamingTextMarkdown.claude(
                          padding: EdgeInsets.all(10),
                          autoScroll: true,
                          text: data["msg"],
                          textAlign: TextAlign.left,
                          markdownEnabled: true,
                          animationsEnabled: isAnimation(data, idx),
                          onComplete: () {
                            widget.isGenerated = true;
                          },
                          theme: StreamingTextTheme(
                            textStyle: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                ChatOtherThing(
                  isUser: isUser,
                  conversations: widget.conversations,
                  index: idx,
                  chatInputCtrl: widget.chatInputCtrl,
                  onEdit: widget.onEdit,
                  editIndex: widget.editIndex,
                  reload: widget.reload,
                  apiUrl: widget.apiUrl,
                  isVisual: widget.isVisual,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
