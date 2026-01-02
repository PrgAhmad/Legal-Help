import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatDrawer extends StatefulWidget {
  const ChatDrawer({super.key});

  @override
  State<ChatDrawer> createState() => _ChatDrawerState();
}

class _ChatDrawerState extends State<ChatDrawer> {
  @override
  List<String> chatHistoryTitles = [
    "IPC Section 420 – Cheating Case",
    "BNS Explained in Simple Language",
    "FIR Filing Procedure in India",
    "Rights After Arrest",
    "Cyber Crime Complaint Process",
    "Domestic Violence Law (DV Act)",
    "Bail Rules in Criminal Cases",
    "Consumer Protection Act Query",
    "Article 21 – Right to Life",
    "Property Dispute Legal Advice",
  ];

  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            spacing: 10,
            children: [
              SearchBar(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.secondary,
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
                hintText: "Search",
                constraints: BoxConstraints(maxHeight: 50, minHeight: 50),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
                leading: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 20,
                ),
                textStyle: WidgetStatePropertyAll(
                  GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: chatHistoryTitles.length,
                  itemBuilder: (context, idx) {
                    return InkWell(
                      onTap: (){},
                      child: Container(
                          height: 55,
                          padding: EdgeInsets.only(left: 5),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.outline, width: 0.5))
                          ),
                          child: MyText(chatHistoryTitles[idx])
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
