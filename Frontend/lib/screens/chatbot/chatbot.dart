import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/screens/authentication/widgets/my_input.dart';
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
  bool isGenerating = false;

  int random(){
    final random = Random();
    return random.nextInt(10000);
  }

  Future<String> getAI(String text) async {
    final res = await http.get(
      Uri.parse("https://text.pollinations.ai/${SYSTEM_PROMPT}\n\n${text}?seed=${random()}&model=openai"),
    );
    print("${text}\n${random()}");
    print(res.body);
    return res.body.toString();
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

  List<Map> conversations = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
            child: Icon(Icons.clear),
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
                ),
            MyChatInputBox(
              controller: chatInputCtrl,
              isGenerating: isGenerating,
              onTap: () async {
                if (isGenerating) {
                  conversations.removeLast();
                  conversations.removeLast();
                  isGenerating = false;
                  setState(() {});
                }
                if (chatInputCtrl.text.isEmpty) return;

                FocusManager.instance.primaryFocus?.unfocus();
                isGenerating = true;

                conversations.add({"type": "user", "msg": chatInputCtrl.text});
                conversations.add({"type": "ai", "msg": "loading..."});

                String text = chatInputCtrl.text;
                chatInputCtrl.text = "";
                setState(() {});
                // scroll();

                String ai = await getAI(text);
                if (ai.isNotEmpty) {
                  isGenerating = false;
                  conversations.removeLast();
                  conversations.add({"type": "ai", "msg": ai});
                  setState(() {});
                  // scroll();
                }
              },
            ),
          ],
        ),
      ),
      drawer: ChatDrawer(),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
