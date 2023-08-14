import 'package:cookain/chatbot/domain/repository/chat_bot_repository_interface.dart';
import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:dartz/dartz.dart';

class ChatBotDeleteMessageUesCase {

  final ChatBotRepositoryInterface repo;

  ChatBotDeleteMessageUesCase(this.repo);

  Future<Either<Failure, Success>> call(String uid) {
    return repo.deleteMessage(uid);
  }
}