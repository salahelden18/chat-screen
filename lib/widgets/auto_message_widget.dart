import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuppo_chat_app/constants/color_constants.dart';
import 'package:yuppo_chat_app/cubit/message_cubit.dart';

class AutoMessageWidget extends StatelessWidget {
  const AutoMessageWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MessageCubit>().addMessage(message);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: ColorConstants.primaryColor),
        ),
        child: Text(message),
      ),
    );
  }
}
