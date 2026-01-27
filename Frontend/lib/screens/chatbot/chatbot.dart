import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/screens/chatbot/widgets/chat_drawer.dart';
import 'package:frontend/screens/chatbot/widgets/chat_window.dart';
import 'package:frontend/screens/chatbot/widgets/my_chat_input_box.dart';
import 'package:frontend/screens/chatbot/widgets/welcome_msg.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});
  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  TextEditingController chatInputCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  List<Map> conversations = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isVisual = false;
  bool isGenerating = false;
  bool isEdit = false;
  int editIndex = 0;
  bool isGenerated = false;

  String apiUrl = "/chat/generate?style=simple&type=normal";

  Future<String> getAI(String text) async {
    print("fetching...");
    final res = await http.get(
      Uri.parse("${LEGAL_HELP_BACKEND_URL}${apiUrl}&question=${text}"),
    );
    print("data...");
    print(res.body.toString());
    return res.body.toString();
  }

  void setApiUrl(styleIdx, typeIdx) {
    apiUrl =
        "/chat/generate?style=${generateStyles[styleIdx]}&type=${generateTypes[typeIdx]}";
    if (generateTypes[typeIdx] == "interactive") {
      isVisual = true;
    } else {
      isVisual = false;
    }
    reload();
  }

  void scroll() {
    scrollCtrl.animateTo(
      scrollCtrl.position.maxScrollExtent,
      curve: Curves.linear,
      duration: Duration(milliseconds: 500),
    );
  }

  void addText(String text) {
    chatInputCtrl.text = text;
    setState(() {});
  }

  void reload() {
    setState(() {});
  }

  Map test = {
    "title": "Inducement of Suicide of Another",
    "introduction":
        "Section 120 of the Indian Penal Code deals with individuals who, with a purpose as a means, deliberately encourage another person to commit suicide. It is a serious offence aimed at preventing malicious acts that lead to self‑harm under coercion or undue influence.",
    "applicable_laws": [
      {
        "section_or_article": "Section 120",
        "act": "Indian Penal Code (IPC)",
        "summary":
            "Whoever, as a means or purpose, willfully encourages another to commit suicide shall be punished with imprisonment of up to three years and a fine.",
      },
    ],
    "example":
        "Sunder knows his sister suffers from depression and repeatedly tells her that suicide is the only way out. She later attempts suicide, ultimately ending her life. Sunder can be prosecuted under Section 120 IPC for inducing her to commit suicide.",
    "punishment": "Imprisonment for a term of up to three years, and a fine.",
  };

  void onEdit(bool val) {
    isEdit = val;
    reload();
  }

  void handleChatbotInput() async {
    if (isGenerating) {
      isGenerating = false;
      conversations.removeLast();
      conversations.removeLast();
      setState(() {});
    }
    if (chatInputCtrl.text.isEmpty) return;

    FocusManager.instance.primaryFocus?.unfocus();
    isGenerating = true;
    isGenerated = false;

    if (isEdit) {
      conversations.replaceRange(editIndex, editIndex + 2, [
        {"type": "user", "msg": chatInputCtrl.text,"isVisual": isVisual},
        {"type": "ai", "msg": "loading...", "isVisual": isVisual,},
      ]);
    } else {
      conversations.add({"type": "user", "msg": chatInputCtrl.text,"isVisual": isVisual});
      conversations.add({
        "type": "ai",
        "msg": "loading...",
        "isVisual": isVisual,
      });
    }
    String text = chatInputCtrl.text;
    chatInputCtrl.text = "";
    setState(() {});

    String ai = await getAI(text);
    if (ai.isNotEmpty) {
      isGenerating = false;
      if (isEdit) {
        conversations.replaceRange(editIndex + 1, editIndex + 2, [
          {"type": "ai", "msg": ai, "isVisual": isVisual},
        ]);
        onEdit(false);
      } else {
        conversations.removeLast();
        conversations.add({"type": "ai", "msg": ai, "isVisual": isVisual});
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(
        context,
        title: "Legal Help AI",
        leading: GestureDetector(
          onTap: () => _scaffoldKey.currentState?.openDrawer(),
          child: Icon(
            Icons.menu_rounded,
            size: 30,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              conversations = [];
              isGenerating = false;
              setState(() {});
            },
            child: Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            conversations.isEmpty
                ? WelcomeMsg(addText: addText)
                : ChatWindow(
                  conversations: conversations,
                  scrollCtrl: scrollCtrl,
                  chatInputCtrl: chatInputCtrl,
                  onEdit: onEdit,
                  editIndex: editIndex,
                  reload: reload,
                  isGenerated: isGenerated,
                  apiUrl: apiUrl,
                  isVisual: isVisual,
                ),
            MyChatInputBox(
              controller: chatInputCtrl,
              isGenerating: isGenerating,
              setApiUrl: setApiUrl,
              onTap: handleChatbotInput,
            ),
          ],
        ),
      ),
      drawer: ChatDrawer(),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
