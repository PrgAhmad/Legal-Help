import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/screens/chatbot/widgets/chat_drawer.dart';
import 'package:frontend/screens/chatbot/widgets/chat_window.dart';
import 'package:frontend/screens/chatbot/widgets/chat_input_box.dart';
import 'package:frontend/screens/chatbot/widgets/welcome_msg.dart';
import 'package:frontend/service/chatbot_service.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_bottom_navigation_bar.dart';

class Chatbot extends StatefulWidget {
  List? chats = [];
  Chatbot({super.key, this.chats});
  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  List? chats = [];
  TextEditingController chatInputCtrl = TextEditingController();
  ScrollController scrollCtrl = ScrollController();
  ChatbotService chatbotService = ChatbotService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String style = "simple";
  String type = "normal";

  bool isVisual = false;
  bool isGenerating = false;
  bool isEdit = false;
  int editIndex = 0;
  bool isGenerated = false;

  void setApiUrl(styleIdx, typeIdx) {
    style = generateStyles[styleIdx];
    type = generateTypes[typeIdx];
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

  void onEdit(bool val) {
    isEdit = val;
    reload();
  }

  void handleChatbot() async {
    String text = chatInputCtrl.text;
    isGenerated = false;
    if(text.isNotEmpty){
      chatInputCtrl.text = "";
      String chatId = await chatbotService.getChatId();
      print(chatId);
      print(widget.chats);
      Map formData = {
        "question": text,
        "style": style,
        "type": type,
        "chatId": chatId,
      };
      chats!.add({"user": text, "ai": "Loading..."});
      isGenerating = true;
      setState(() {});
      Map? data = await chatbotService.generateChat(formData);
      if (data != null && data.containsKey("error")) {
        chats!.removeLast();
        chats!.add({"user": text, "ai": data["error"]});
      }
      if (data != null && data.containsKey("content")) {
        chats = jsonDecode(data["content"]);
      }
      isGenerating = false;
      setState(() {
      });
    }
  }

  @override
  void initState() {
    super.initState();
    chats = widget.chats ?? chats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(
        context,
        title: "Legal AI",
        fontSize: 18,
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
            onTap: () async{
              chats = [];
              String chatId = await chatbotService.getChatId();
              chatbotService.deleteChat(chatId);
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
             (chats == null || chats!.isEmpty)
                ? WelcomeMsg(addText: addText)
                : ChatWindow(
                  chats: chats!,
                  scrollCtrl: scrollCtrl,
                  chatInputCtrl: chatInputCtrl,
                  onEdit: onEdit,
                  editIndex: editIndex,
                  reload: reload,
                  isGenerated: isGenerated,
                  isVisual: isVisual,
                ),
            ChatInputBox(
              controller: chatInputCtrl,
              isGenerating: isGenerating,
              setApiUrl: setApiUrl,
              onTap: handleChatbot,
            ),
          ],
        ),
      ),
      drawer: ChatDrawer(),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
