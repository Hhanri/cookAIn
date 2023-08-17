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
      expect(docs.docs.first.data().prompt, message1.prompt);
      expect(docs.docs.first.data().response, message1.response);
      expect(docs.docs.first.data().status, message1.status);

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
      expect(docs.docs[1].data().prompt, message1.prompt);
      expect(docs.docs[1].data().response, message1.response);
      expect(docs.docs[1].data().status, message1.status);

      expect(docs.docs[0].data().prompt, message2.prompt);
      expect(docs.docs[0].data().response, message2.response);
      expect(docs.docs[0].data().status, message2.status);
    });

    test('delete all mssages', () async {
      await dataSource.deleteConversation();
      final docs = await dataSource.messagesQuery().get();

      expect(docs.docs.length, 0);
      expect(fsi.dump(), emptyChat);
    });

  });

}