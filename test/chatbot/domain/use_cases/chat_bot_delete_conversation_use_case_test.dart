import 'package:cookain/chatbot/data/data_sources/chat_bot_remote_data_source.dart';
import 'package:cookain/chatbot/data/repository/chat_bot_repository_implementation.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_delete_message_use_case.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_send_message_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_firebase.dart';

void main() {

  final fsi = mockFSI;
  final fai = mockFAI;

  final dataSource = ChatBotRemoteDataSource(fsi: fsi, fai: fai);
  final repo = ChatBotRepositoryImplementation(dataSource);

  final addUseCase = ChatBotSendMessageUseCase(repo);
  final deleteUseCase = ChatBotDeleteMessageUseCase(repo);

  const emptyChat = '''{
  "ingredients": {
    "uuid123456789": {
      "chat": {}
    }
  }
}''';

  group('delete message use case', () {

    test('delete non existing document should not return failure', () async {
      final res = await deleteUseCase.call('uid');
      expect(res.isRight(), true);
      expect(fsi.dump(), emptyChat);
    });

    test('add message before deleting', () async {
      final res = await addUseCase.call('message');
      expect(res.isRight(), true);
    });

    test('delete sent message', () async {
      final docs = await repo.messagesQuery().get();
      final uid = docs.docs.first.id;
      final res = await deleteUseCase.call(uid);
      expect(res.isRight(), true);
      expect(fsi.dump(), emptyChat);
    });

  });

}