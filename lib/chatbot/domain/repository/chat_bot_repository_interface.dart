import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/chatbot/domain/entities/chat_bot_message_entity.dart';
import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:dartz/dartz.dart';

abstract class ChatBotRepositoryInterface {

  Future<Either<Failure, Success>> sendMessage(String message);

  CollectionReference<ChatBotMessageEntity> messagesQuery();

  Future<Either<Failure, Success>> deleteMessage(String uid);

  Future<Either<Failure, Success>> deleteConversation();

}