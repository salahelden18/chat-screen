import 'package:flutter/material.dart';
import '../models/chat_model.dart';
import 'date_container_widget.dart';
import 'message_widget.dart';

class DateMessagesSectionWidget extends StatefulWidget {
  const DateMessagesSectionWidget(
      {super.key, required this.date, required this.messages});
  final String date;
  final List<ChatModel> messages;

  @override
  State<DateMessagesSectionWidget> createState() =>
      _DateMessagesSectionWidgetState();
}

class _DateMessagesSectionWidgetState extends State<DateMessagesSectionWidget> {
  final GlobalKey<AnimatedListState> animationListKey =
      GlobalKey<AnimatedListState>();

  @override
  void didUpdateWidget(DateMessagesSectionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.length > oldWidget.messages.length) {
      // Ensure index is within bounds
      int index = widget.messages.length - 1;
      if (index >= 0 && index < widget.messages.length) {
        animationListKey.currentState
            ?.insertItem(index, duration: const Duration(milliseconds: 500));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Rebuild for ${widget.date}');
    debugPrint('Messages length: ${widget.messages.length}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // display the date category
        DateContainerWidget(date: widget.date),
        const SizedBox(height: 20),
        // display the list of the messages
        AnimatedList(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          key: animationListKey,
          initialItemCount: widget.messages.length,
          itemBuilder: (context, index, animation) {
            // wired case happens unexpectly so we handled it in this way
            // it is happens randomly
            if (index < 0 || index >= widget.messages.length) {
              debugPrint(
                  'Index $index is out of bounds for messages list of length ${widget.messages.length}');
              return const SizedBox.shrink();
            }
            return MessageWidget(
              message: widget.messages[index],
              isPreviousSameUser: isPreviousBySameUser(index),
              isAfterSameuser: isAfterSameuser(index),
              animation: animation,
            );
          },
        ),
      ],
    );
  }

  bool isPreviousBySameUser(int index) {
    if (index == 0) return false;

    return widget.messages[index].sender == widget.messages[index - 1].sender;
  }

  // decreasing the space between messages from the same user
  bool isAfterSameuser(int index) {
    // for the last message we add space 20 pixels
    if (widget.messages.length - 1 == index) return false;

    return widget.messages[index].sender == widget.messages[index + 1].sender;
  }
}

// slide transition
// Widget _buildMessageItem(int index, Animation<double> animation) {
//   final message = widget.messages[index];

//   // Define the starting and ending offset for the slide transition
//   final slideOffset = Tween<Offset>(
//     begin: const Offset(1, 0), // Start off-screen to the right
//     end: Offset.zero, // Slide to its final position
//   ).animate(animation);

//   return SlideTransition(
//     position: slideOffset,
//     child: MessageWidget(
//       message: message,
//       isPreviousSameUser: isPreviousBySameUser(index),
//       isAfterSameuser: isAfterSameuser(index),
//     ),
//   );
// }

// fade with slide transition
// Widget _buildMessageItem(int index, Animation<double> animation) {
//   final message = widget.messages[index];

//   // Define the starting and ending offset for the slide transition
//   final slideOffset = Tween<Offset>(
//     begin: const Offset(0, 1), // Start off-screen at the bottom
//     end: Offset.zero, // Slide to its final position
//   ).animate(animation);

//   return FadeTransition(
//     opacity: animation,
//     child: SlideTransition(
//       position: slideOffset,
//       child: MessageWidget(
//         message: message,
//         isPreviousSameUser: isPreviousBySameUser(index),
//         isAfterSameuser: isAfterSameuser(index),
//       ),
//     ),
//   );
// }
