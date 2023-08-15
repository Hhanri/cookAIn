import 'package:cookain/chatbot/domain/entities/chat_bot_message_entity.dart';
import 'package:cookain/chatbot/presentation/cubits/chat_bot_cubit/chat_bot_cubit.dart';
import 'package:cookain/chatbot/presentation/widgets/chat_bot_message_tile_widget.dart';
import 'package:cookain/core/widgets/query_list_view_builder.dart';
import 'package:flutter/material.dart';

class ChatBotListViewWidget extends StatelessWidget {
  const ChatBotListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryListViewBuilder<ChatBotCubit, ChatBotMessageEntity>(
      reverse: true,
      emptyBuilder: (context) {
        return const Center(
          child: Text(
            "Start you conversation with CookAIn's Chat Bot"
          ),
        );
      },
      itemBuilder: (context, snapshot) {
        return ChatBotMessageTileWidget(message: snapshot.data());
      }
    );
  }
}
