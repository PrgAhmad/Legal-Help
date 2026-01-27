import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextArea extends StatefulWidget {
  String? labelText;
  String? hintText;
  TextEditingController controller;
  IconData prefixIcon;
  IconData? suffixIcon;
  int maxLines;
  int minLines;
  MyTextArea({
    required this.hintText,
    required this.labelText,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines = 2,
  });

  @override
  State<MyTextArea> createState() => _MyTextAreaState();
}

class _MyTextAreaState extends State<MyTextArea> {
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: MyText(widget.labelText!, fontSize: 13),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow,
                spreadRadius: 1,
                blurRadius: 6,
              ),
            ],
            border: Border.all(color: Theme.of(context).colorScheme.outline),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(
                  widget.prefixIcon,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 13,
                  ),
                  minLines: widget.minLines,
                  maxLines: widget.maxLines,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    hintText: widget.hintText!,
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.scrim,
                      fontSize: 12.5,
                    ),
                  ),
                ),
              ),
              if (widget.suffixIcon != null)
                Padding(
                  padding: EdgeInsets.only(right: 10, top: 10),
                  child: Icon(widget.suffixIcon ?? Icons.e_mobiledata),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
