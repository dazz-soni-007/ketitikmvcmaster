import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Icon? icon;
  final FormFieldValidator<String>? validation;
  final TextInputType? keyboardType;

  // Icon icon = const Icon(Icons.account_circle_outlined);

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.validation,
    required this.icon,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        validator: validation,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(fontSize: 12),
          labelStyle: TextStyle(fontSize: 12),
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class CustomController extends TextEditingController {
  TextController({required String text}) {
    this.text = text;
  }

  set text(String newText) {
    value = value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
        composing: TextRange.empty);
  }
}

class CustomTextBlack extends StatelessWidget {
  final String? hintText;
  final Function(String?) onSaved;
  final CustomController? controller;
  final Icon? icon;
  final FormFieldValidator<String>? validation;
  final TextInputType? keyboardType;
  FocusNode focusNode = FocusNode();

  CustomTextBlack(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.validation,
      required this.icon,
      required this.keyboardType,
      required this.focusNode,
      required this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: onSaved,
        focusNode: focusNode,
        controller: controller,
        validator: validation,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          prefixIcon: icon,
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(fontSize: 12),
          labelStyle: TextStyle(fontSize: 12),
          contentPadding: const EdgeInsets.all(10),
          /* border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,*/
          //),
        ),
      ),
    );
  }
}
