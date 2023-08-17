import 'package:cookain/auth/data/data_sources/auth_data_source_interface.dart';
import 'package:cookain/auth/data/data_sources/auth_remote_firebase_data_source.dart';
import 'package:cookain/auth/data/repository/auth_repository_implementation.dart';
import 'package:cookain/auth/domain/repository/auth_repository_interface.dart';
import 'package:cookain/auth/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:cookain/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:cookain/auth/domain/use_cases/user_changes_use_case.dart';
import 'package:cookain/auth/presentation/cubits/auth_cubit.dart';
import 'package:cookain/chatbot/data/data_sources/chat_bot_data_source_interface.dart';
import 'package:cookain/chatbot/data/data_sources/chat_bot_remote_data_source.dart';
import 'package:cookain/chatbot/data/repository/chat_bot_repository_implementation.dart';
import 'package:cookain/chatbot/domain/repository/chat_bot_repository_interface.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_delete_conversation_use_case.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_delete_message_use_case.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_messages_query_use_case.dart';
import 'package:cookain/chatbot/domain/use_cases/chat_bot_send_message_use_case.dart';
import 'package:cookain/chatbot/presentation/cubits/chat_bot_cubit/chat_bot_cubit.dart';
import 'package:cookain/core/config/router.dart';
import 'package:cookain/home_navigation/presentation/cubits/home_navigation_cubit/home_navigation_cubit.dart';
import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/ingredients/domain/entities/ingredient_entity.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_quantity_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/edit_ingredient_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/ingredients_stream_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/remove_ingredient_quantity_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/remove_ingredient_use_case.dart';
import 'package:cookain/ingredients/presentation/cubits/add_ingredient_cubit/add_ingredient_cubit.dart';
import 'package:cookain/ingredients/presentation/cubits/edit_ingredient_cubit/edit_ingredient_cubit.dart';
import 'package:cookain/ingredients/presentation/cubits/ingredients_cubit/ingredients_cubit.dart';
import 'package:cookain/recipes/data/data_sources/recipe_remote_data_source.dart';
import 'package:cookain/recipes/data/repository/recipe_repository_implementation.dart';
import 'package:cookain/recipes/domain/entities/recipe_entity.dart';
import 'package:cookain/recipes/domain/repository/recipe_repository_interface.dart';
import 'package:cookain/recipes/domain/use_cases/add_recipe_use_case.dart';
import 'package:cookain/recipes/domain/use_cases/edit_recipe_use_case.dart';
import 'package:cookain/recipes/domain/use_cases/make_recipe_use_case.dart';
import 'package:cookain/recipes/domain/use_cases/recipes_query_use_case.dart';
import 'package:cookain/recipes/domain/use_cases/remove_recipe_use_case.dart';
import 'package:cookain/recipes/presentation/cubits/add_recipe_cubit/add_recipe_cubit.dart';
import 'package:cookain/recipes/presentation/cubits/edit_recipe_cubit/edit_recipe_cubit.dart';
import 'package:cookain/recipes/presentation/cubits/recipes_cubit/recipes_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cookain/ingredients/data/data_sources/ingredients_data_source_interface.dart';
import 'package:cookain/ingredients/data/repository/ingredients_reposiroty_implementation.dart';
import 'package:cookain/ingredients/domain/repository/ingredients_repository_interface.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GetIt sl = GetIt.asNewInstance();

void setupSL() {

  sl.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore
      .instance
      ..settings = const Settings(
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED
      )
  );
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  FirebaseFirestore.instance;
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  // Auth
  sl.registerLazySingleton<AuthDataSourceInterface>(
    () => AuthRemoteFirebaseDataSource(
      fai: sl.get<FirebaseAuth>(),
      googleSignIn: sl.get<GoogleSignIn>()
    )
  );
  sl.registerLazySingleton<AuthRepositoryInterface>(() => AuthRepositoryImplementation(dataSource: sl.get<AuthDataSourceInterface>()));

  sl.registerLazySingleton<SignInWithGoogleUseCase>(() => SignInWithGoogleUseCase(sl.get<AuthRepositoryInterface>()));
  sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(sl.get<AuthRepositoryInterface>()));
  sl.registerLazySingleton<UserChangesUseCase>(() => UserChangesUseCase(sl.get<AuthRepositoryInterface>()));

  sl.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      signInWithGoogleUseCase: sl.get<SignInWithGoogleUseCase>(),
      signOutUseCase: sl.get<SignOutUseCase>(),
      userChangesUseCase: sl.get<UserChangesUseCase>()
    )..init()
  );

  // Ingredients
  sl.registerLazySingleton<IngredientsDataSourceInterface>(
    () => IngredientsRemoteDataSource(
      fsi: sl.get<FirebaseFirestore>(),
      fai: sl.get<FirebaseAuth>()
    )
  );
  sl.registerLazySingleton<IngredientsRepositoryInterface>(() => IngredientsRepositoryImplementation(sl.get<IngredientsDataSourceInterface>()));

  sl.registerLazySingleton<AddIngredientUseCase>(() => AddIngredientUseCase(sl.get<IngredientsRepositoryInterface>()));
  sl.registerLazySingleton<RemoveIngredientUseCase>(() => RemoveIngredientUseCase(sl.get<IngredientsRepositoryInterface>()));
  sl.registerLazySingleton<EditIngredientUseCase>(() => EditIngredientUseCase(sl.get<IngredientsRepositoryInterface>()));
  sl.registerLazySingleton<AddIngredientQuantityUseCase>(() => AddIngredientQuantityUseCase(sl.get<IngredientsRepositoryInterface>()));
  sl.registerLazySingleton<RemoveIngredientQuantityUseCase>(() => RemoveIngredientQuantityUseCase(sl.get<IngredientsRepositoryInterface>()));
  sl.registerLazySingleton<IngredientsStreamUseCase>(() => IngredientsStreamUseCase(sl.get<IngredientsRepositoryInterface>()));

  sl.registerFactory<IngredientsCubit>(
    () => IngredientsCubit(
      ingredientsStreamUseCase: sl.get<IngredientsStreamUseCase>(),
      removeIngredientUseCase: sl.get<RemoveIngredientUseCase>(),
      addIngredientQuantityUseCase: sl.get<AddIngredientQuantityUseCase>(),
      removeIngredientQuantityUseCase: sl.get<RemoveIngredientQuantityUseCase>(),
    )
  );

  sl.registerFactory<AddIngredientCubit>(
    () => AddIngredientCubit(
      useCase: sl.get<AddIngredientUseCase>()
    )
  );

  sl.registerFactoryParam<EditIngredientCubit, IngredientEntity, dynamic>(
    (param1, _) => EditIngredientCubit(
      useCase: sl.get<EditIngredientUseCase>(),
      initialIngredient: param1
    )
  );

  // Recipes
  sl.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSource(fsi: sl.get<FirebaseFirestore>(), fai: sl.get<FirebaseAuth>())
  );
  sl.registerLazySingleton<RecipeRepositoryInterface>(
    () => RecipeRepositoryImplementation(sl.get<RecipeRemoteDataSource>())
  );

  sl.registerLazySingleton<AddRecipeUseCase>(
    () => AddRecipeUseCase(sl.get<RecipeRepositoryInterface>())
  );
  sl.registerLazySingleton<EditRecipeUseCase>(
    () => EditRecipeUseCase(sl.get<RecipeRepositoryInterface>())
  );
  sl.registerLazySingleton<MakeRecipeUseCase>(
    () => MakeRecipeUseCase(sl.get<RecipeRepositoryInterface>())
  );
  sl.registerLazySingleton<RemoveRecipeUseCase>(
    () => RemoveRecipeUseCase(sl.get<RecipeRepositoryInterface>())
  );
  sl.registerLazySingleton<RecipesQueryUseCase>(
    () => RecipesQueryUseCase(sl.get<RecipeRepositoryInterface>())
  );

  sl.registerFactory<RecipesCubit>(
    () => RecipesCubit(
      removeRecipeUseCase: sl.get<RemoveRecipeUseCase>(),
      recipesQueryUseCase: sl.get<RecipesQueryUseCase>(),
      makeRecipeUseCase: sl.get<MakeRecipeUseCase>(),
      query: sl.get<RecipesQueryUseCase>().call()
    )
  );

  sl.registerFactoryParam<AddRecipeCubit, RecipeEntity?, dynamic>(
    (param1, _) => AddRecipeCubit(
      useCase: sl.get<AddRecipeUseCase>(),
      initialRecipe: param1
    )
  );

  sl.registerFactoryParam<EditRecipeCubit, RecipeEntity, dynamic>(
    (param1, _) => EditRecipeCubit(
      useCase: sl.get<EditRecipeUseCase>(),
      initialRecipe: param1
    )
  );

  // Router
  sl.registerLazySingleton<MyGoRouter>(() => MyGoRouter(authCubit: sl.get<AuthCubit>()));
  sl.registerLazySingleton<HomeNavigationCubit>(() => HomeNavigationCubit());

  // Chat bot

  sl.registerLazySingleton<ChatBotDataSourceInterface>(
    () => ChatBotRemoteDataSource(
      fsi: sl.get<FirebaseFirestore>(),
      fai: sl.get<FirebaseAuth>()
    )
  );

  sl.registerLazySingleton<ChatBotRepositoryInterface>(
    () => ChatBotRepositoryImplementation(sl.get<ChatBotDataSourceInterface>()))
  ;

  sl.registerLazySingleton<ChatBotSendMessageUseCase>(
    () => ChatBotSendMessageUseCase(sl.get<ChatBotRepositoryInterface>())
  );
  sl.registerLazySingleton<ChatBotDeleteMessageUseCase>(
    () => ChatBotDeleteMessageUseCase(sl.get<ChatBotRepositoryInterface>())
  );
  sl.registerLazySingleton<ChatBotDeleteConversationUseCase>(
    () => ChatBotDeleteConversationUseCase(sl.get<ChatBotRepositoryInterface>())
  );
  sl.registerLazySingleton<ChatBotMessagesQueryUseCase>(
    () => ChatBotMessagesQueryUseCase(sl.get<ChatBotRepositoryInterface>())
  );

  sl.registerFactory<ChatBotCubit>(
    () => ChatBotCubit(
      sendMessageUseCase: sl.get<ChatBotSendMessageUseCase>(),
      deleteConversationUseCase: sl.get<ChatBotDeleteConversationUseCase>(),
      deleteMessageUseCase: sl.get<ChatBotDeleteMessageUseCase>(),
      messagesQueryUseCase: sl.get<ChatBotMessagesQueryUseCase>(),
      query: sl.get<ChatBotMessagesQueryUseCase>().call()
    )
  );
}