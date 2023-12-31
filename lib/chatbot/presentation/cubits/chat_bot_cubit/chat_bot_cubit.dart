import 'package:cookain/chatbot/domain/entities/chat_bot_message_entity.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_delete_conversation_use_case.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_delete_message_use_case.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_messages_query_use_case.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_send_message_use_case.dart';
import 'package:cookain/core/cubits/firestore_query_cubit/firestore_query_cubit.dart';
import 'package:flutter/cupertino.dart';

part 'chat_bot_state.dart';

class ChatBotCubit extends FirestoreQueryCubit<ChatBotMessageEntity> {
  final ChatBotSendMessageUseCase sendMessageUseCase;
  final ChatBotDeleteMessageUseCase deleteMessageUseCase;
  final ChatBotDeleteConversationUseCase deleteConversationUseCase;
  final ChatBotMessagesQueryUseCase messagesQueryUseCase;

  final TextEditingController controller = TextEditingController();

  ChatBotCubit({
    required this.sendMessageUseCase,
    required this.deleteConversationUseCase,
    required this.deleteMessageUseCase,
    required this.messagesQueryUseCase,
    required super.query
  });

  Future<void> sendMessage() async {
    final text = controller.text.trim();
    controller.clear();
    if (text.isEmpty) return;
    final res = await sendMessageUseCase.call(text);
    res.fold(
      (failure) => ChatBotError(error: failure.message ?? "unknown error"),
      (success) => null
    );
  }

  Future<void> promptFromList(List<String> ingredients) async {
    controller.clear();
    String prompt = "Give me a recipe based on this list of ingredients:\n\n";
    for (final ingredient in ingredients) {
      prompt += "$ingredient\n";
    }
    controller.text = prompt;
  }

  Future<void> deleteMessage(String uid) async {
    final temp = [...docs]..removeWhere((element) => element.id == uid);
    emit(ChatBotLoaded(docs: temp));
    final res = await deleteMessageUseCase.call(uid);
    res.fold(
      (failure) => ChatBotError(error: failure.message ?? "unknown error"),
      (success) => null
    );
  }

  Future<void> deleteConversation() async {
    final res = await deleteConversationUseCase.call();
    res.fold(
      (failure) => ChatBotError(error: failure.message ?? "unknown error"),
      (success) => null
    );
  }

  @override
  Future<void> close() async {
    controller.dispose();
    return super.close();
  }
}