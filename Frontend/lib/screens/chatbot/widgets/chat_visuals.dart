import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class ChatVisuals extends StatelessWidget {
  final Map data;

  const ChatVisuals({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final laws = (data["applicable_laws"] as List<dynamic>?) ?? [];
    final title = data["title"]?.toString() ?? "Untitled";
    final introduction =
        data["introduction"]?.toString() ?? "No introduction available";
    final example = data["example"]?.toString() ?? "";
    final punishment = data["punishment"]?.toString() ?? "";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: MyContainer(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            // Header
            MyContainer(
              padding: const EdgeInsets.all(12),
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              child: Row(
                spacing: 12,
                children: [
                  Icon(
                    Icons.balance,
                    size: 28,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    child: MyText(
                      title,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Introduction
            MyContainer(
              padding: const EdgeInsets.all(12),
              borderRadius: BorderRadius.circular(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  MyText(
                    "Introduction",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  MyText(
                    introduction,
                    textAlign: TextAlign.start,
                    fontSize: 13,
                  ),
                ],
              ),
            ),

            // Applicable Laws
            if (laws.isNotEmpty)
              MyContainer(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                borderRadius: BorderRadius.circular(12),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  childrenPadding: const EdgeInsets.only(top: 8, bottom: 4),
                  iconColor: Theme.of(context).colorScheme.tertiary,
                  collapsedIconColor: Theme.of(context).colorScheme.tertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: MyText(
                    "Applicable Law",
                    textAlign: TextAlign.start,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  children:
                      laws.map((law) {
                        final sectionOrArticle =
                            law["section_or_article"]?.toString() ??
                            "Unknown Section";
                        final act = law["act"]?.toString() ?? "Unknown Act";
                        final summary =
                            law["summary"]?.toString() ??
                            "No summary available";
                        return MyContainer(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.only(bottom: 10),
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 6,
                            children: [
                              MyText(
                                "$sectionOrArticle – $act",
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              MyText(
                                summary,
                                textAlign: TextAlign.start,
                                fontSize: 13,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ),

            // Example
            if (example.trim().isNotEmpty)
              MyContainer(
                padding: const EdgeInsets.all(12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green, width: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        const Icon(
                          Icons.menu_book,
                          size: 20,
                          color: Colors.green,
                        ),
                        MyText(
                          "Example",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    MyText(example, textAlign: TextAlign.start, fontSize: 13),
                  ],
                ),
              ),

            // Punishment
            if (punishment.trim().isNotEmpty)
              MyContainer(
                padding: const EdgeInsets.all(12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red, width: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          size: 20,
                          color: Colors.red,
                        ),
                        MyText(
                          "Punishment",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    MyText(
                      punishment,
                      textAlign: TextAlign.start,
                      fontSize: 13,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
