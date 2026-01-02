import 'package:flutter/material.dart';
import 'package:flutter_streaming_text_markdown/flutter_streaming_text_markdown.dart';
import 'package:frontend/widgets/my_icon.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatWindow extends StatefulWidget {
  List<Map> conversations = [];
  ScrollController scrollCtrl;
  ChatWindow({
    super.key,
    required this.conversations,
    required this.scrollCtrl,
  });

  @override
  State<ChatWindow> createState() => _ChatWindowState();
}

class _ChatWindowState extends State<ChatWindow> {
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
          return Align(
            alignment:
                isUser
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
            child: Column(
              crossAxisAlignment:
                  isUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Container(
                  constraints: BoxConstraints(
                    minWidth: 0,
                    maxWidth:
                        data["type"] == "user"
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
                      animationsEnabled:
                          data["type"] == "user"
                              ? false
                              : data["type"] == "ai" &&
                                  (widget.conversations.length - 1) == idx
                              ? true
                              : false,
                      theme: StreamingTextTheme(
                        textStyle: GoogleFonts.poppins(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
                isUser ?
                Padding(padding: EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 5,
                    children: [
                      MySmallIcon(context, icon: Icons.edit)
                    ],
                  ),
                ) : Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 15),
                  child: Row(
                    spacing: 8,
                    children: [
                      MySmallIcon(context, icon: Icons.share),
                      MySmallIcon(context, icon: Icons.copy),
                      MySmallIcon(context, icon: Icons.volume_up, size: 19),
                      MySmallIcon(context, icon: Icons.refresh, size: 19)
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

}
