import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String id;
  final String sender;
  final String message;
  final int timeStamp;
  final bool isSentByMe;

  const ChatModel({
    required this.id,
    required this.sender,
    required this.message,
    required this.timeStamp,
    required this.isSentByMe,
  });

  @override
  List<Object?> get props => [
        id,
        sender,
        message,
        timeStamp,
        isSentByMe,
      ];
}
