// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final bool obsecuretext = false;

  const CustomTextfield({
    Key? key,
    required this.controller,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscuringCharacter: "*",
      obscureText: obsecuretext,
      decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hint';
        }
        return null;
      },
    );
  }
}
