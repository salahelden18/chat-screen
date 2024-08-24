import 'package:flutter/material.dart';
import 'package:yuppo_chat_app/constants/color_constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, this.onChanged, required this.hint, this.controller});
  final void Function(String)? onChanged;
  final String hint;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: ColorConstants.grey2Color,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
