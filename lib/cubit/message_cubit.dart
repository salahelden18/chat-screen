import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../services/date_time_service.dart';
import 'message_states.dart';
import '../models/chat_model.dart';
import '../services/messages_generation_service.dart';

class MessageCubit extends Cubit<MessageState> {
  final DateFormat _dateFormat = DateFormat('MMMM d, yyyy');

  MessageCubit() : super(const MessageState());

  void init() {
    final List<ChatModel> initialChatMessage =
        MessagesGenerationService.generateIntialMessage();

    final groupedMessages = _groupAndSortMessagesByDate(initialChatMessage);

    debugPrint('We have ${groupedMessages.keys.length}');

    emit(state.copyWith(messages: groupedMessages));
  }

  // add message
  void addMessage(String message) {
    // final timeStamp = DateTime.now().millisecondsSinceEpoch;
    final timeStamp =
        DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch;

    // constructing the model
    final chatModel = ChatModel(
      id: const Uuid().v4(),
      sender: 'User A',
      message: message,
      timeStamp: timeStamp,
      isSentByMe: true,
    );

    final date = DateTimeService.formatDate(timeStamp);
    // add message to a group
    final updatedMessages = _addMessageToGroup(state.messages, date, chatModel);
    // sort the keys so the latest date appears first
    // we need the sort because if the message sended at another day will be in the top and we want that to be at the bottom
    final sortedMessage = _sortMessagesByDate(updatedMessages);

    debugPrint('Now we have ${sortedMessage.keys.length} number of keys');

    emit(state.copyWith(messages: sortedMessage));
  }

  Map<String, List<ChatModel>> _groupAndSortMessagesByDate(
      List<ChatModel> messages) {
    final groupedMessages = _groupMessagesByDate(messages);
    return _sortMessagesByDate(groupedMessages);
  }

  Map<String, List<ChatModel>> _groupMessagesByDate(List<ChatModel> messages) {
    final groupedMessages = <String, List<ChatModel>>{};

    for (final message in messages) {
      final date = DateTimeService.formatDate(message.timeStamp);
      groupedMessages.putIfAbsent(date, () => []).add(message);
    }

    return groupedMessages;
  }

  Map<String, List<ChatModel>> _sortMessagesByDate(
      Map<String, List<ChatModel>> groupedMessages) {
    final sortedDates = groupedMessages.keys.toList()
      ..sort((a, b) => _dateFormat.parse(b).compareTo(_dateFormat.parse(a)));

    final sortedGroupedMessages = <String, List<ChatModel>>{};
    for (final date in sortedDates) {
      sortedGroupedMessages[date] = groupedMessages[date]!;
    }

    return sortedGroupedMessages;
  }

  Map<String, List<ChatModel>> _addMessageToGroup(
      Map<String, List<ChatModel>> messages, String date, ChatModel message) {
    final updatedMessages = <String, List<ChatModel>>{};

    state.messages.forEach((key, value) {
      updatedMessages[key] = List.from(value);
    });
    debugPrint('${updatedMessages.length}');

    updatedMessages.putIfAbsent(date, () => []).add(message);
    debugPrint('${updatedMessages.length}');
    return updatedMessages;
  }
}
