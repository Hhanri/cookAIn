import 'package:cookain/chatbot/domain/entities/chat_bot_message_entity.dart';

class ChatBotMessageModel extends ChatBotMessageEntity {

  const ChatBotMessageModel({
    required super.prompt,
    required super.response,
    required super.createTime,
    required super.status
  });

  factory ChatBotMessageModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? status = json['status'];
    return ChatBotMessageModel(
      prompt: json['prompt'],
      response: json['response'],
      createTime: json['createTime'],
      status: status != null ? PaLMStatusModel.fromJson(status) : null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prompt': prompt,
      'response': response,
      'createTime': createTime,
      'status': status?.toJson()
    };
  }

  @override
  List<Object?> get props => [
    prompt,
    response,
    createTime,
    status
  ];
}


class PaLMStatusModel extends PaLMStatusEntity {

  const PaLMStatusModel({
    required super.completionTime,
    required super.error,
    required super.startTime,
    required super.update
  });

  factory PaLMStatusModel.fromJson(Map<String, dynamic> json) {
    return PaLMStatusModel(
      completionTime: json['completionTime'],
      error: json['error'],
      startTime: json['startTime'],
      update: json['update']
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'completionTime': completionTime,
      'error': error,
      'startTime': startTime,
      'update': update
    };
  }

  @override
  List<Object?> get props => [
    completionTime,
    error,
    startTime,
    update
  ];
}