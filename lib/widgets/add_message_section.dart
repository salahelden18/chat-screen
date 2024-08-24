import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yuppo_chat_app/constants/color_constants.dart';
import 'package:yuppo_chat_app/constants/string_constants.dart';
import 'package:yuppo_chat_app/cubit/message_cubit.dart';
import 'package:yuppo_chat_app/widgets/custom_text_field.dart';

class AddMessageSection extends StatefulWidget {
  const AddMessageSection({super.key});

  @override
  State<AddMessageSection> createState() => _AddMessageSectionState();
}

class _AddMessageSectionState extends State<AddMessageSection> {
  String message = '';
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: messageController,
              hint: StringConstants.hintText,
              onChanged: (value) {
                setState(() {
                  message = value;
                });
              },
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.image),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: message.isEmpty
                ? null
                : () {
                    debugPrint("Executing Add Message $message");
                    // send the message to the cubit
                    context.read<MessageCubit>().addMessage(message);

                    setState(() {
                      message = '';
                      messageController.text = '';
                    });
                  },
            icon: Icon(
              Icons.send,
              color: message.isEmpty
                  ? ColorConstants.greyColor
                  : ColorConstants.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
