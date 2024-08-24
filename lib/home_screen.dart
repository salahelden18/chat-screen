import 'package:flutter/material.dart';
import 'constants/color_constants.dart';
import 'widgets/add_message_section.dart';
import 'widgets/chat_section.dart';

import 'widgets/auto_generated_replay_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yuppo App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: ColorConstants.primaryColor,
      ),
      body: Column(
        children: [
          const ChatSection(),
          Column(
            children: [
              if (MediaQuery.of(context).viewInsets.bottom > 0)
                const AutoGeneratedReplySection(),
              if (MediaQuery.of(context).viewInsets.bottom > 0)
                const SizedBox(height: 5),
              const AddMessageSection(),
            ],
          ),
        ],
      ),
    );
  }
}
