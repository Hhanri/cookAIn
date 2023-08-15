import 'package:cookain/chatbot/data/data_sources/chat_bot_remote_data_source.dart';
import 'package:cookain/chatbot/data/repository/chat_bot_repository_implementation.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_delete_conversation_use_case.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_send_message_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_firebase.dart';

void main() {

  final fsi = mockFSI;
  final fai = mockFAI;

  final dataSource = ChatBotRemoteDataSource(fsi: fsi, fai: fai);
  final repo = ChatBotRepositoryImplementation(dataSource);

  final addUseCase = ChatBotSendMessageUseCase(repo);
  final deleteAllUseCase = ChatBotDeleteConversationUseCase(repo);

  const emptyChat = '''{
  "ingredients": {
    "uuid123456789": {
      "chat": {}
    }
  }
}''';

  group('delete conversation use case', () {

    test('delete empty chat should not return failure', () async {
      final res = await deleteAllUseCase.call();
      expect(res.isRight(), true);
      expect(fsi.dump(), emptyChat);
    });

    test('add messages before deleting', () async {
      final res1 = await addUseCase.call('message1');
      final res2 = await addUseCase.call('message2');
      expect(res1.isRight(), true);
      expect(res2.isRight(), true);
    });

    test('delete all messages', () async {
      final res = await deleteAllUseCase.call();
      expect(res.isRight(), true);
      expect(fsi.dump(), emptyChat);
    });

  });

}