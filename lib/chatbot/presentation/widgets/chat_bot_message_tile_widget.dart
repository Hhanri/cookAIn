import 'package:cookain/chatbot/domain/entities/chat_bot_message_entity.dart';
import 'package:cookain/core/config/theme.dart';
import 'package:cookain/core/utils/extract_recipe_from_string.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:cookain/recipes/presentation/widgets/recipe_dialog.dart';
import 'package:flutter/material.dart';

class ChatBotMessageTileWidget extends StatelessWidget {
  final ChatBotMessageEntity message;
  const ChatBotMessageTileWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textWithRecipe = textWithRecipeFromString(message.response ?? _defaultResponse);

    return Column(
      children: [
        _UserMessageTile(text: message.prompt),
        //if (message.response != null) _BotMessageTile(text: message.response!),
        _BotMessageTile(text: textWithRecipe.text),
        if (textWithRecipe.recipe != null) exportRecipe(context, textWithRecipe.recipe!)
      ]
    );
  }

  Widget exportRecipe(BuildContext context, RecipeEntity recipe) {
    return Container(
      padding: MyShapes.smallPadding,
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          showAddRecipeDialog(context, initialRecipe: recipe);
        },
        child: Text("export ${recipe.name}")
      ),
    );
  }
}

class _UserMessageTile extends _GenericMessageTileWidget {
  _UserMessageTile({
    required super.text
  }) : super(
    alignment: Alignment.centerRight,
    backgroundColor: MyTheme.scheme.secondaryContainer
  );
}

class _BotMessageTile extends _GenericMessageTileWidget {
  _BotMessageTile({
    required super.text
  }) : super(
    alignment: Alignment.centerLeft,
    backgroundColor: MyTheme.scheme.primaryContainer
  );
}

abstract class _GenericMessageTileWidget extends StatelessWidget {
  final Alignment alignment;
  final Color backgroundColor;
  final String text;
  const _GenericMessageTileWidget({
    Key? key,
    required this.alignment,
    required this.backgroundColor,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7
        ),
        margin: MyShapes.padding,
        padding: MyShapes.padding,
        decoration: BoxDecoration(
          borderRadius: MyShapes.circularBorderRadius,
          color: backgroundColor
        ),
        child: Text(text),
      ),
    );
  }
}

const String _defaultResponse = '''hey here is a recipe you can make:
{
  "name": "Apple Pie",
  "ingredients": {
    "apple": {
      "name": "apple",
      "quantity": 50,
      "unit": "g"
    }
  }
}''';