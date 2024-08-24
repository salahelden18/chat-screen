import 'package:flutter/material.dart';
import 'package:yuppo_chat_app/models/chat_model.dart';
import 'package:yuppo_chat_app/widgets/date_container_widget.dart';
import 'package:yuppo_chat_app/widgets/message_widget.dart';

class DateMessagesSectionWidget extends StatelessWidget {
  const DateMessagesSectionWidget(
      {super.key, required this.date, required this.messages});
  final String date;
  final List<ChatModel> messages;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // display the date category
        DateContainerWidget(date: date),
        const SizedBox(height: 20),
        // display the list of the messages
        ...List.generate(
            messages.length,
            (index) => MessageWidget(
                  message: messages[index],
                  isPreviousSameUser: isPreviousBySameUser(index),
                  isAfterSameuser: isAfterSameuser(index),
                )),
      ],
    );
  }

  bool isPreviousBySameUser(int index) {
    if (index == 0) return false;

    return messages[index].sender == messages[index - 1].sender;
  }

  bool isAfterSameuser(int index) {
    // for the last message we add space 20 pixels
    if (messages.length - 1 == index) return false;

    return messages[index].sender == messages[index + 1].sender;
  }
}
