import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_streaming_text_markdown/flutter_streaming_text_markdown.dart';
import 'package:frontend/screens/chatbot/widgets/chat_visuals.dart';
import 'package:frontend/screens/chatbot/widgets/widgets/chat_other_thing.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatWindow extends StatefulWidget {
  List chats = [];
  ScrollController scrollCtrl;
  Function(bool) onEdit;
  TextEditingController chatInputCtrl;
  int editIndex;
  Function() reload;
  bool isGenerated;
  bool isVisual;

  ChatWindow({
    super.key,
    required this.chats,
    required this.scrollCtrl,
    required this.onEdit,
    required this.chatInputCtrl,
    required this.editIndex,
    required this.reload,
    required this.isGenerated,
    required this.isVisual,
  });

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
  bool isAnimation(isUser, idx) {
    bool isAnimate = !isUser && idx == widget.chats.length - 1 && !widget.isGenerated;
    print(isAnimate);
    return isAnimate;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: ListView.builder(
        itemCount: widget.chats.length,
        controller: widget.scrollCtrl,
        itemBuilder: (context, idx) {
          Map data = widget.chats[idx];
          bool isVisual = data["isVisual"] ?? false;
          Map jsonData = {};
          if (isVisual) {
            print(data["ai"]);
            jsonData = jsonDecode(data["ai"]);
            print(jsonData);
          }
          return Column(
            spacing: 10,
            children: [
              particularChat(
                isUser: true,
                text: data["user"],
                isVisual: isVisual,
                jsonData: jsonData,
                idx: idx,
              ),
              particularChat(
                isUser: false,
                text: data["ai"] ?? "Loading...",
                isVisual: isVisual,
                jsonData: jsonData,
                idx: idx,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget particularChat({
    required bool isUser,
    required String text,
    bool isVisual = false,
    Map? jsonData,
    required int idx,
  }) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        spacing: 2,
        children: [
          isVisual
              ? ChatVisuals(data: jsonData!)
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
                      isUser
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  border:
                      isUser
                          ? Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          )
                          : Border(),
                ),
                child: IntrinsicWidth(
                  child: StreamingTextMarkdown.claude(
                    padding: EdgeInsets.all(10),
                    autoScroll: true,
                    text: text,
                    textAlign: TextAlign.left,
                    markdownEnabled: true,
                    animationsEnabled: isAnimation(isUser, idx),
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
            chats: widget.chats,
            index: idx,
            chatInputCtrl: widget.chatInputCtrl,
            onEdit: widget.onEdit,
            editIndex: widget.editIndex,
            reload: widget.reload,
            isVisual: widget.isVisual,
          ),
        ],
      ),
    );
  }
}
