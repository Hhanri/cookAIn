import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/chatbot/domain/entities/chat_bot_message_entity.dart';
import 'package:cookain/chatbot/domain/repository/chat_bot_repository_interface.dart';

class ChatBotMessagesQueryUseCase {

  final ChatBotRepositoryInterface repo;

  ChatBotMessagesQueryUseCase(this.repo);

  CollectionReference<ChatBotMessageEntity> call() {
    return repo.messagesQuery();
  }
}