import 'package:cookain/auth/data/data_sources/auth_data_source_interface.dart';
import 'package:cookain/auth/data/data_sources/auth_remote_firebase_data_source.dart';
import 'package:cookain/auth/data/repository/auth_repository_implementation.dart';
import 'package:cookain/auth/domain/repository/auth_repository_interface.dart';
import 'package:cookain/auth/domain/use_cases/sign_in_with_google_use_case.dart';
import 'package:cookain/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:cookain/auth/domain/use_cases/user_changes_use_case.dart';
import 'package:cookain/auth/presentation/cubits/auth_cubit.dart';
import 'package:cookain/core/config/router.dart';
import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_quantity_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/edit_ingredient_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/ingredients_stream_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/remove_ingredient_quantity_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/remove_ingredient_use_case.dart';
import 'package:cookain/ingredients/presentation/cubits/ingredients_cubit/ingredients_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cookain/ingredients/data/data_sources/ingredients_data_source_interface.dart';
import 'package:cookain/ingredients/data/repository/ingredients_reposiroty_implementation.dart';
import 'package:cookain/ingredients/domain/repository/ingredients_repository_interface.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GetIt sl = GetIt.asNewInstance();

void setupSL() {

  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
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

  sl.registerLazySingleton<IngredientsCubit>(
    () => IngredientsCubit(
      ingredientsStreamUseCase: sl.get<IngredientsStreamUseCase>(),
      addIngredientUseCase: sl.get<AddIngredientUseCase>(),
      editIngredientUseCase: sl.get<EditIngredientUseCase>(),
      removeIngredientUseCase: sl.get<RemoveIngredientUseCase>(),
      addIngredientQuantityUseCase: sl.get<AddIngredientQuantityUseCase>(),
      removeIngredientQuantityUseCase: sl.get<RemoveIngredientQuantityUseCase>(),
    )
  );

  // Router
  sl.registerLazySingleton<MyGoRouter>(() => MyGoRouter(authCubit: sl.get<AuthCubit>()));
}