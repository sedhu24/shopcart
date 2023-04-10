// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shopcart/constants/global_variables.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final int maxLines;
  final TextInputType inputType;
  const CustomTextfield({
    Key? key,
    required this.controller,
    this.hint,
    this.maxLines = 1,
    this.inputType = TextInputType.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: GlobalVariables.secondaryColor)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: GlobalVariables.secondaryColor))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hint';
        }
        return null;
      },
    );
  }
}
