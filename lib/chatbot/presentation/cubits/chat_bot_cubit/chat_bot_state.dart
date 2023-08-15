part of 'chat_bot_cubit.dart';

@immutable
abstract class ChatBotState extends FirestoreQueryState<ChatBotMessageEntity> {
  const ChatBotState();
}

class ChatBotInitial extends FirestoreQueryInitial<ChatBotMessageEntity> {
  const ChatBotInitial();

  @override
  List<Object?> get props => [];
}

class ChatBotLoaded extends FirestoreQueryLoaded<ChatBotMessageEntity> {
  const ChatBotLoaded({required super.docs});

  @override
  List<Object?> get props => [];
}

class ChatBotError extends FirestoreQueryError<ChatBotMessageEntity> {
  const ChatBotError({
    required super.error,
  });

  @override
  List<Object?> get props => [error];
}