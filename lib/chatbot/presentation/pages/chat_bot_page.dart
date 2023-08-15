import 'package:cookain/chatbot/presentation/widgets/chat_bot_list_view_widget.dart';
import 'package:cookain/chatbot/presentation/widgets/chat_bot_text_field.dart';
import 'package:flutter/material.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CookAIn Chat Bot"),
      ),
      body: const ChatBotListViewWidget(),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets, // to make bottom bar stick to the keyboard
        child: const ChatBotTextField(),
      )
    );
  }
}
