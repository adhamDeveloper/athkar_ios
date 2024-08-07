import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String text;
  final IconData? icons;
  final Color color;
  final Color colorBorder;
  final Color colorIcons;
  final Color colorText;
  final TextInputType keyType;
  final TextEditingController controller;
  final bool isObscureText;
  final bool isIgnore;
  final bool enabled;
  final Function? function;
  final Function(String value)? onChangedT;

  const MyTextField({
    required this.text,
    required this.colorText,
    this.icons,
    required this.color,
    required this.colorIcons,
    required this.colorBorder,
    this.function,
    required this.keyType,
    required this.controller,
    this.isObscureText = false,
    this.isIgnore = true,
    this.enabled = true,
    this.onChangedT,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.right,
        enabled: enabled,
        onChanged: (value) {
          if (onChangedT != null) {
            onChangedT!(value.toString());
          }
        },
        style: TextStyle(fontSize: 15, color: colorText),
        controller: controller,
        obscureText: isObscureText,
        keyboardType: keyType,

        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: text,
          // labelText: text,
          alignLabelWithHint: true,
          labelStyle: TextStyle(color: color),
          hintStyle: TextStyle(color: color),
          enabledBorder: border(borderColors: Colors.grey.shade600),
          focusedBorder: border(
            borderColors: colorBorder,
          ),
          prefixIcon: IgnorePointer(
            ignoring: isIgnore,
            child: IconButton(
              onPressed: () => function!(),
              icon: Icon(icons),
              color: colorIcons,
            ),
          ),
          prefixStyle: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  OutlineInputBorder border({required Color borderColors}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColors, width: 1),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
