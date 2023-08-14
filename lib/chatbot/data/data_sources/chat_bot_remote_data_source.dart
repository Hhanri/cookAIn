import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/chatbot/data/data_sources/chat_bot_data_source_interface.dart';
import 'package:cookain/chatbot/data/models/chat_bot_message_model.dart';
import 'package:cookain/core/result/failure.dart';
import 'package:cookain/core/result/success.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatBotRemoteDataSource implements ChatBotDataSourceInterface {

  final FirebaseFirestore fsi;
  final FirebaseAuth fai;

  ChatBotRemoteDataSource({required this.fsi, required this.fai});

  @override
  Future<Success> deleteConversation() {
    return _handleError(
      function: () async {
        final batch = fsi.batch();
        final docs = await _collectionRef.get();
        for (final doc in docs.docs) {
          batch.delete(doc.reference);
        }
        await batch.commit();
      }
    );
  }

  @override
  Future<Success> deleteMessage(String uid) {
    return _handleError(
      function: () async {
        await _collectionRef
          .doc(uid)
          .delete();
      }
    );
  }

  @override
  CollectionReference<ChatBotMessageModel> messagesQuery() {
    return _collectionRef;
  }

  @override
  Future<Success> sendMessage(String message) {
    final model = ChatBotMessageModel(prompt: message, response: null, createTime: null, status: null);
    return _handleError(
      function: () async {
        await _collectionRef.add(model);
      }
    );
  }

  CollectionReference<ChatBotMessageModel> get _collectionRef => fsi
    .collection('ingredients')
    .doc(fai.currentUser?.uid)
    .collection('chat')
    .withConverter(
      fromFirestore: (snapshot, _) => ChatBotMessageModel.fromJson(snapshot.data()!),
      toFirestore: (model, _) => model.toJson()
    );

  Future<Success> _handleError({required Future<void> Function() function}) async {
    try {
      await function();
      return const Success();
    } on FirebaseException catch (e) {
      throw Failure(message: e.message, code: e.code);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}