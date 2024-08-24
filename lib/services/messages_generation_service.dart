import 'package:uuid/uuid.dart';
import 'package:yuppo_chat_app/models/chat_model.dart';

class MessagesGenerationService {
  static List<ChatModel> generateIntialMessage() {
    const Uuid uuid = Uuid();
    final List<ChatModel> messages = [];
    final DateTime now = DateTime.now();

    // generate 20 messages
    for (int i = 0; i < 20; i++) {
      messages.add(
        ChatModel(
          id: uuid.v4(),
          sender: i % 2 == 0 ? 'User A' : 'User B',
          message: 'Message ${i + 1} from ${i % 2 == 0 ? 'User A' : 'User B'}',
          timeStamp: now.subtract(Duration(hours: i)).millisecondsSinceEpoch,
          isSentByMe: i % 2 == 0,
        ),
      );
    }

    // sorting the messages
    messages.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));

    return messages;
  }
}
