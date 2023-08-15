import 'package:cookain/chatbot/data/data_sources/chat_bot_remote_data_source.dart';
import 'package:cookain/chatbot/data/repository/chat_bot_repository_implementation.dart';
import 'package:cookain/chatbot/domain/entities/chat_bot_message_entity.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_delete_conversation_use_case.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_delete_message_use_case.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_messages_query_use_case.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_send_message_use_case.dart';
import 'package:cookain/chatbot/presentation/cubits/chat_bot_cubit/chat_bot_cubit.dart';
import 'package:cookain/core/cubits/firestore_query_cubit/firestore_query_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/mock_firebase.dart';

void main() {

  final fsi = mockFSI;
  final fai = mockFAI;

  final dataSource = ChatBotRemoteDataSource(fsi: fsi, fai: fai);
  final repo = ChatBotRepositoryImplementation(dataSource);

  final sendMessageUseCase = ChatBotSendMessageUseCase(repo);
  final deleteMessageUseCase = ChatBotDeleteMessageUseCase(repo);
  final deleteConversationUseCase = ChatBotDeleteConversationUseCase(repo);
  final messagesQueryUseCase = ChatBotMessagesQueryUseCase(repo);

  final cubit = ChatBotCubit(
    sendMessageUseCase: sendMessageUseCase,
    deleteConversationUseCase: deleteConversationUseCase,
    deleteMessageUseCase: deleteMessageUseCase,
    messagesQueryUseCase: messagesQueryUseCase,
    collectionReference: messagesQueryUseCase.call()
  );

  group('chat bot cubit test', () {

    test('initial state', () {
      expect(cubit.state, const FirestoreQueryInitial<ChatBotMessageEntity>());
    });

    test('init', () async {
      cubit.fetchMore();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(cubit.state, const FirestoreQueryEmpty<ChatBotMessageEntity>());
    });

    test('send message', () async {
      cubit.controller.text = 'message test';
      await cubit.sendMessage();
      expect(cubit.state, const TypeMatcher<FirestoreQueryLoaded<ChatBotMessageEntity>>());
      expect((cubit.state as FirestoreQueryLoaded<ChatBotMessageEntity>).docs.length, 1);
      expect((cubit.state as FirestoreQueryLoaded<ChatBotMessageEntity>).docs.first.data().prompt, 'message test');
      expect(cubit.controller.text, '');
    });

    test('delete message', () async {
      final doc = await messagesQueryUseCase.call().get();
      final uid = doc.docs.first.id;
      await cubit.deleteMessage(uid);
      expect(cubit.state, const FirestoreQueryEmpty<ChatBotMessageEntity>());
    });

    test('send 2 messages', () async {
      cubit.controller.text = 'message test';
      await cubit.sendMessage();
      expect(cubit.state, const TypeMatcher<FirestoreQueryLoaded<ChatBotMessageEntity>>());
      expect((cubit.state as FirestoreQueryLoaded<ChatBotMessageEntity>).docs.length, 1);
      expect((cubit.state as FirestoreQueryLoaded<ChatBotMessageEntity>).docs.first.data().prompt, 'message test');
      expect(cubit.controller.text, '');

      cubit.controller.text = 'message test 2';
      await cubit.sendMessage();
      expect(cubit.state, const TypeMatcher<FirestoreQueryLoaded<ChatBotMessageEntity>>());
      expect((cubit.state as FirestoreQueryLoaded<ChatBotMessageEntity>).docs.length, 2);
      expect((cubit.state as FirestoreQueryLoaded<ChatBotMessageEntity>).docs[1].data().prompt, 'message test 2');
      expect(cubit.controller.text, '');
    });

    test('delete conversation', () async {
      await cubit.deleteConversation();
      await Future.delayed(const Duration(milliseconds: 50));
      expect(cubit.state, const FirestoreQueryEmpty<ChatBotMessageEntity>());
    });

  });

}