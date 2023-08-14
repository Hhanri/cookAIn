import 'package:cookain/chatbot/data/data_sources/chat_bot_remote_data_source.dart';
import 'package:cookain/chatbot/data/models/chat_bot_message_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_firebase.dart';

void main() {

  final fai = mockFAI;
  final fsi = mockFSI;

  const message1 = ChatBotMessageModel(
    prompt: 'message 1',
    response: null,
    createTime: null,
    status: null
  );

  const message2 = ChatBotMessageModel(
    prompt: 'message 2',
    response: null,
    createTime: null,
    status: null
  );

  const emptyChat = '''{
  "ingredients": {
    "uuid123456789": {
      "chat": {}
    }
  }
}''';

  final dataSource = ChatBotRemoteDataSource(fsi: fsi, fai: fai);

  group('chat bot data source test', () {

    test('send message', () async {

      await dataSource.sendMessage(message1.prompt);

      final docs = await dataSource.messagesQuery().get();

      expect(docs.docs.length, 1);
      expect(docs.docs.first.data(), message1);

    });

    test('delete message', () async {
      final docs = await dataSource.messagesQuery().get();
      final doc = docs.docs.first;

      await dataSource.deleteMessage(doc.id);

      final newDocs = await dataSource.messagesQuery().get();

      expect(newDocs.docs.length, 0);
      expect(fsi.dump(), emptyChat);
    });

    test('send multiple messages', () async {
      await dataSource.sendMessage(message1.prompt);
      await dataSource.sendMessage(message2.prompt);

      final docs = await dataSource.messagesQuery().get();

      expect(docs.docs.length, 2);
      expect(docs.docs[0].data(), message1);
      expect(docs.docs[1].data(), message2);
    });

    test('delete all mssages', () async {
      await dataSource.deleteConversation();
      final docs = await dataSource.messagesQuery().get();

      expect(docs.docs.length, 0);
      expect(fsi.dump(), emptyChat);
    });

  });

}