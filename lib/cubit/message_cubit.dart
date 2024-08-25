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

    emit(state.copyWith(messages: groupedMessages));
  }

  // add message
  void addMessage(String message) {
    final timeStamp = DateTime.now().millisecondsSinceEpoch;

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
    final sortedMessage = _sortMessagesByDate(updatedMessages);

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

    updatedMessages.putIfAbsent(date, () => []).add(message);
    return updatedMessages;
  }
}



// void addMessage(String message) {
  //   debugPrint("Add Message from Cubit");

  //   final timeStamp =
  //       DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch;

  //   // constructing the model
  //   final chatModel = ChatModel(
  //     id: const Uuid().v4(),
  //     sender: 'User A',
  //     message: message,
  //     timeStamp: timeStamp,
  //     isSentByMe: true,
  //   );

  //   debugPrint('$chatModel');

  //   // get the date of the message
  //   final date = DateTimeFormatService.formatDate(timeStamp);
  //   debugPrint(date);

  //   // Copy current state messages and update with the new message
  //   // the state should be immutable that is why we create new Map
  //   // this is a shallow copy will not emit the new state
  //   // final updatedMessages = Map<String, List<ChatModel>>.from(state.messages);
  //   // deep copy
  //   final updatedMessages = <String, List<ChatModel>>{};

  //   state.messages.forEach((key, value) {
  //     updatedMessages[key] = List.from(value);
  //   });

  //   if (!updatedMessages.containsKey(date)) {
  //     updatedMessages[date] = [];
  //   }

  //   updatedMessages[date]!.add(chatModel);

  //   emit(state.copyWith(messages: updatedMessages));
  // }

  /**
   * 
   * Map<String, List<ChatModel>> _formatChatMessagesWithDates(
      List<ChatModel> messages) {
    final Map<String, List<ChatModel>> groupedMessages = {};
    final dateFormat = DateFormat('MMMM d, yyyy');

    for (final message in messages) {
      final date = DateTimeFormatService.formatDate(message.timeStamp);
      // checking if the key exist or not
      // if the key is not exist we create a key with that
      if (!groupedMessages.containsKey(date)) {
        groupedMessages[date] = [];
      }

      groupedMessages[date]!.add(message);
    }

    // Extract and sort the dates in reverse order
    final sortedDates = groupedMessages.keys.toList()
      ..sort((a, b) => dateFormat.parse(b).compareTo(dateFormat.parse(a)));

    // Create a new map with sorted dates
    final sortedGroupedMessages = <String, List<ChatModel>>{};
    for (final date in sortedDates) {
      sortedGroupedMessages[date] = groupedMessages[date]!;
    }

    return sortedGroupedMessages;
  }
   */