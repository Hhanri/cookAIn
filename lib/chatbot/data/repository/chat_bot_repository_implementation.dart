import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/chatbot/data/data_sources/chat_bot_data_source_interface.dart';
import 'package:cookain/chatbot/domain/entities/chat_bot_message_entity.dart';
import 'package:cookain/chatbot/domain/repository/chat_bot_repository_interface.dart';
import 'package:cookain/core/result/execute.dart';
import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:dartz/dartz.dart';

class ChatBotRepositoryImplementation implements ChatBotRepositoryInterface {

  final ChatBotDataSourceInterface dataSource;

  ChatBotRepositoryImplementation(this.dataSource);

  @override
  Future<Either<Failure, Success>> deleteConversation() {
    return execute(dataSource.deleteConversation);
  }

  @override
  Future<Either<Failure, Success>> deleteMessage(String uid) {
    return execute(() => dataSource.deleteMessage(uid));
  }

  @override
  Query<ChatBotMessageEntity> messagesQuery() {
    return dataSource.messagesQuery();
  }

  @override
  Future<Either<Failure, Success>> sendMessage(String message) {
    return execute(() => dataSource.sendMessage(message));
  }

}