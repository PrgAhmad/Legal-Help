import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_streaming_text_markdown/flutter_streaming_text_markdown.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:frontend/service/local_database.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class LawOptions extends StatefulWidget {
  String secArtTitle;
  String secArtContent;
  String secArtNo;
  String lawName;
  bool isAccessFromBookmark;
  WidgetsToImageController imageCtrl;

  LawOptions({
    required this.lawName,
    required this.secArtContent,
    required this.secArtTitle,
    required this.secArtNo,
    required this.imageCtrl,
    this.isAccessFromBookmark = false,
  });

  @override
  State<LawOptions> createState() => _LawOptionsState();
}

class _LawOptionsState extends State<LawOptions> {
  bool isSpeaking = false;
  bool isGenerating = false;
  bool isCopied = false;
  bool isBookmarked = false;
  LawBookmark lawBookmark = LawBookmark();

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();

    Future<void> speak(text) async {
      await flutterTts.setLanguage("en-US"); // Set language
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(1.0); // Set pitch
      await flutterTts.speak(text); // Speak the text
    }

    flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });

    Future<void> stop() async {
      await flutterTts.stop();
    }

    void copyText() async {
      setState(() {
        isCopied = true;
      });
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        isCopied = false;
      });
      ClipboardData data = ClipboardData(
        text:
            "${widget.lawName}\n\n${widget.lawName == "Indian Constitution" ? "Article" : "Section"} ${widget.secArtNo}\n\n${widget.secArtTitle}\n\n${widget.secArtContent}",
      );
      await Clipboard.setData(data);
    }

    void speakText() async {
      if (isSpeaking) {
        stop();
      } else {
        speak(widget.secArtContent);
      }
      setState(() {
        isSpeaking = !isSpeaking;
      });
    }

    void aiExplain() async {
      print("click");
      setState(() {
        isGenerating = true;
      });
      final url = Uri.parse(
        "https://text.pollinations.ai/Assume you are a legal expert and explain this in easy and simple way with example in short and give response in point wise not in table. here is :-  ${widget.secArtContent}",
      );
      print("fetching");
      final res = await http.get(url);
      print(res.body);
      setState(() {
        isGenerating = false;
      });
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        useSafeArea: true,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height - 180,
        ),
        builder: (context) {
          return MyContainer(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 100),
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  "AI Explanation",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: StreamingTextMarkdown.claude(
                      text: res.body,
                      padding: EdgeInsets.all(10),
                      theme: StreamingTextTheme(
                        textStyle: GoogleFonts.poppins(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    void shareLaw() async {
      Uint8List? bytes = await widget.imageCtrl.capturePng(
        pixelRatio: 3.0,
        waitForAnimations: true,
      );
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/shared_image.png';
      final file = File(filePath);
      await file.writeAsBytes(bytes!);
      SharePlus sharePlus = SharePlus.instance;
      await sharePlus.share(ShareParams(files: [XFile(file.path)]));
    }

    void bookMark() async {
      if (widget.isAccessFromBookmark) {
        int isDeleted = await lawBookmark.delete(widget.secArtNo, widget.lawName);
        if(isDeleted != 0){
          isBookmarked = true;
          setState(() {

          });
          await Future.delayed(Duration(seconds: 1));
          isBookmarked = false;
          setState(() {

          });
        }
      } else {
        int isAdded = await lawBookmark.add(
          actName: widget.lawName,
          number: widget.secArtNo,
          title: widget.secArtTitle,
          content: widget.secArtContent,
        );
        if(isAdded != 0){
          isBookmarked = true;
          setState(() {

          });
          await Future.delayed(Duration(seconds: 1));
          isBookmarked = false;
          setState(() {

          });
        }
      }
    }

    return Row(
      spacing: 15,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: copyText,
          child: Icon(
            isCopied ? Icons.done_outline_rounded : Icons.copy_rounded,
            size: 20,
          ),
        ),
        GestureDetector(
          onTap: speakText,
          child: Icon(
            isSpeaking ? Icons.square_rounded : Icons.volume_up_rounded,
            size: 20,
          ),
        ),
        GestureDetector(
          onTap: bookMark,
          child: Icon(
           widget.isAccessFromBookmark
                ? Icons.bookmark_remove_rounded
                : Icons.bookmark_add_rounded,
            size: 20,
            color: isBookmarked ? Colors.blue : Theme.of(context).colorScheme.tertiary,
          ),
        ),
        GestureDetector(
          onTap: shareLaw,
          child: Icon(Icons.share_rounded, size: 18),
        ),
        GestureDetector(
          onTap: aiExplain,
          child: MyContainer(
            color: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.all(8),
            child:
                isGenerating
                    ? CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.tertiary,
                      strokeWidth: 2,
                      constraints: BoxConstraints(
                        maxHeight: 17,
                        maxWidth: 17,
                        minWidth: 17,
                        minHeight: 17,
                      ),
                    )
                    : Icon(Icons.auto_awesome_rounded, size: 18, color: Theme.of(context).colorScheme.tertiaryFixed,),
          ),
        ),
      ],
    );
  }
}
