import 'package:cookain/chatbot/data/data_sources/chat_bot_remote_data_source.dart';
import 'package:cookain/chatbot/data/models/chat_bot_message_model.dart';
import 'package:cookain/chatbot/data/repository/chat_bot_repository_implementation.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_send_message_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_firebase.dart';

void main() {

  final fsi = mockFSI;
  final fai = mockFAI;

  final dataSource = ChatBotRemoteDataSource(fsi: fsi, fai: fai);
  final repo = ChatBotRepositoryImplementation(dataSource);

  final addUseCase = ChatBotSendMessageUseCase(repo);

  const message = ChatBotMessageModel(
    prompt: 'message',
    response: null,
    createTime: null,
    status: null
  );

  test('send message', () async {

    final res = await addUseCase.call(message.prompt);
    expect(res.isRight(), true);

    final docs = await repo.messagesQuery().get();
    final doc = docs.docs.first;

    expect(doc.data(), message);
  });

}