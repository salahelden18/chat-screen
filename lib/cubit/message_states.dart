import 'package:equatable/equatable.dart';
import 'package:yuppo_chat_app/models/chat_model.dart';

class MessageState extends Equatable {
  final Map<String, List<ChatModel>> messages;

  const MessageState({this.messages = const {}});

  MessageState copyWith({Map<String, List<ChatModel>>? messages}) {
    return MessageState(
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props => [messages];
}
