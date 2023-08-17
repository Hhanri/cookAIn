import 'package:cookain/chatbot/presentation/cubits/chat_bot_cubit/chat_bot_cubit.dart';
import 'package:cookain/chatbot/presentation/widgets/chat_bot_list_view_widget.dart';
import 'package:cookain/chatbot/presentation/widgets/chat_bot_text_field.dart';
import 'package:cookain/core/config/theme.dart';
import 'package:cookain/core/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CookAIn Chat Bot"),
        actions: [
          IconButton(
            onPressed: () {
              showConfirmationDialog(
                context: context,
                description: "You are about to delete this conversation",
                onValidate: context.read<ChatBotCubit>().deleteConversation
              );
            },
            icon: Icon(Icons.delete_forever, color: MyTheme.scheme.error,)
          )
        ],
      ),
      body: const ChatBotListViewWidget(),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets, // to make bottom bar stick to the keyboard
        child: const ChatBotTextField(),
      )
    );
  }
}
