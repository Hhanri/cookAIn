import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/chatbot/domain/entities/chat_bot_message_entity.dart';
import 'package:cookain/core/result/success.dart';

abstract class ChatBotRepositoryInterface {

  Future<Success> sendMessage(String message);

  CollectionReference<ChatBotMessageEntity> messagesQuery();

  Future<Success> deleteMessage(String uid);

  Future<Success> deleteConversation();

}