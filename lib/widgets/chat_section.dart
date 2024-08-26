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
    print('Here from the build ${groupedMessages.keys.length}');
    return Expanded(
      child: groupedMessages.values.isEmpty
          ? const Center(
              child: Text('No Chat messages added yet'),
            )
          : ListView(
              reverse: true,
              padding: const EdgeInsets.all(10),
              children: groupedMessages.entries.map((entry) {
                final date = entry.key;
                final messages = entry.value;
                print('=================');
                print(date);
                print(messages.length);
                print('=================');

                return DateMessagesSectionWidget(
                    date: date, messages: messages);
              }).toList(),
            ),
    );
  }
}
