import 'package:flutter/material.dart';
import '../constants/color_constants.dart';
import '../models/chat_model.dart';
import '../services/date_time_service.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});
  final ChatModel message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 0, maxWidth: size.width * 0.70),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: message.isSentByMe
                ? ColorConstants.primaryColor
                : ColorConstants.greyColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // message text
              Text(
                message.message,
                style: TextStyle(
                    color: message.isSentByMe ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 5),
              // time text
              Text(
                DateTimeService.formatTime(message.timeStamp),
                style: TextStyle(
                    color: message.isSentByMe ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
