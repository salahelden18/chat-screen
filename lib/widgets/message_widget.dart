import 'package:flutter/material.dart';
import 'package:yuppo_chat_app/models/chat_model.dart';
import 'package:yuppo_chat_app/widgets/avatar_widget.dart';
import 'package:yuppo_chat_app/widgets/message_bubble.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {super.key,
      required this.message,
      required this.isPreviousSameUser,
      required this.isAfterSameuser});
  final ChatModel message;
  final bool isPreviousSameUser;
  final bool isAfterSameuser;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: message.isSentByMe ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // avatar
              AvatarWidget(
                name: message.sender,
                isByMe: message.isSentByMe,
                isPreviousBySameUser: isPreviousSameUser,
              ),
              const SizedBox(width: 10),
              // the message bubble part
              MessageBubble(message: message),
            ],
          ),
          SizedBox(height: isAfterSameuser ? 5 : 20),
        ],
      ),
    );
  }
}
