import 'package:flutter/material.dart';
import 'package:yuppo_chat_app/constants/color_constants.dart';

class DateContainerWidget extends StatelessWidget {
  const DateContainerWidget({super.key, required this.date});
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.greyColor,
      ),
      child: Text(date),
    );
  }
}
