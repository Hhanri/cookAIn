import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class ChatBotMessageEntity extends Equatable {
  final String uid;
  final String prompt;
  final String? response;
  final Timestamp? createTime;
  final PaLMStatusEntity? status;

  const ChatBotMessageEntity({
    required this.uid,
    required this.prompt,
    required this.response,
    required this.createTime,
    required this.status
  });
}


abstract class PaLMStatusEntity extends Equatable {
  final Timestamp? completionTime;
  final String? error;
  final Timestamp? startTime;
  final Timestamp? update;

  const PaLMStatusEntity({
    required this.completionTime,
    required this.error,
    required this.startTime,
    required this.update
  });

  Map<String, dynamic> toJson();
}