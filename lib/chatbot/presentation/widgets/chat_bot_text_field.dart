import 'package:cookain/chatbot/presentation/cubits/chat_bot_cubit/chat_bot_cubit.dart';
import 'package:cookain/core/config/theme.dart';
import 'package:cookain/core/widgets/text_field_widget.dart';
import 'package:cookain/recipes/presentation/widgets/ingredients_selector_modal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotTextField extends StatelessWidget {
  const ChatBotTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatBotCubit>();
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            final List<String>? ingredients = await showIngredientsSelectorModal(context);
            if (ingredients != null && context.mounted) {
              context.read<ChatBotCubit>().promptFromList(ingredients);
            }
          },
          icon: const Icon(Icons.list)
        ),
        Expanded(
          child: MyTextField(
            params: NormalTextFieldParameters(
              label: 'your message...',
              maxLines: 4,
            ),
            controller: cubit.controller
          ),
        ),
        IconButton(
          onPressed: cubit.sendMessage,
          icon: Icon(Icons.send, color: MyTheme.scheme.primary,)
        )
      ],
    );
  }
}
