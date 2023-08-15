import 'package:cookain/chatbot/presentation/cubits/chat_bot_cubit/chat_bot_cubit.dart';
import 'package:cookain/chatbot/presentation/pages/chat_bot_page.dart';
import 'package:cookain/core/service_locator.dart';
import 'package:cookain/ingredients/presentation/cubits/ingredients_cubit/ingredients_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotPageWrapper extends StatelessWidget {
  final IngredientsCubit ingredientsCubit;
  const ChatBotPageWrapper({Key? key, required this.ingredientsCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChatBotCubit>(
          create: (context) => sl.get<ChatBotCubit>()..fetchMore()
        ),
        BlocProvider<IngredientsCubit>.value(
          value: ingredientsCubit
        )
      ],
      child: const ChatBotPage()
    );
  }
}
