import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/message_cubit.dart';
import 'date_messages_section_widget.dart';

class ChatSection extends StatelessWidget {
  const ChatSection({super.key});

  @override
  Widget build(BuildContext context) {
    final messageCubit = context.watch<MessageCubit>();
    final groupedMessages = messageCubit.state.messages;
    return Expanded(
      child: ListView(
        reverse: true,
        padding: const EdgeInsets.all(10),
        children: groupedMessages.entries.map((entry) {
          final date = entry.key;
          final messages = entry.value;

          return DateMessagesSectionWidget(date: date, messages: messages);
        }).toList(),
      ),
    );
  }
}
