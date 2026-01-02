import 'package:flutter/material.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:google_fonts/google_fonts.dart';

class MyInput extends StatefulWidget {
  String? labelText;
  String? hintText;
  TextInputType? inputType;
  double? width;
  TextEditingController controller;
  IconData prefixIcon;
  Widget? suffixIcon;
  bool? obscureText;
  MyInput({
    required this.hintText,
    required this.labelText,
    this.inputType,
    this.width,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
  });

  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
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
          padding: EdgeInsets.symmetric(horizontal: 0),
          width: widget.width ?? double.infinity,
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
          child: TextFormField(
            controller: widget.controller,
            style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 13,
            ),
            keyboardType: widget.inputType ?? widget.inputType,
            obscureText:
                widget.obscureText == null ? false : widget.obscureText!,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 12),
              hintText: widget.hintText!,
              suffixIcon:
                  widget.suffixIcon != null
                      ? widget.suffixIcon
                      : SizedBox.shrink(),
              prefixIcon: Icon(
                widget.prefixIcon,
                color: Theme.of(context).colorScheme.primary,
              ),
              border: InputBorder.none,
              hintStyle: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.scrim,
                fontSize: 12.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
