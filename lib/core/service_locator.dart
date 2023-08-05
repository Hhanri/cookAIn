import 'package:cookain/ingredients/data/data_sources/ingredients_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_quantity_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/add_ingredient_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/edit_ingredient_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/ingredients_stream_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/remove_ingredient_quantity_use_case.dart';
import 'package:cookain/ingredients/domain/use_cases/remove_ingredient_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cookain/ingredients/data/data_sources/ingredients_data_source_interface.dart';
import 'package:cookain/ingredients/data/repository/ingredients_reposiroty_implementation.dart';
import 'package:cookain/ingredients/domain/repository/ingredients_repository_interface.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.asNewInstance();

void setupSL() {

  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  sl.registerLazySingleton<IngredientsDataSourceInterface>(() => IngredientsRemoteDataSource(fsi: sl.get<FirebaseFirestore>(), fai: sl.get<FirebaseAuth>()));
  sl.registerLazySingleton<IngredientsRepositoryInterface>(() => IngredientsRepositoryImplementation(sl.get<IngredientsDataSourceInterface>()));

  sl.registerLazySingleton<AddIngredientUseCase>(() => AddIngredientUseCase(sl.get<IngredientsRepositoryInterface>()));
  sl.registerLazySingleton<RemoveIngredientUseCase>(() => RemoveIngredientUseCase(sl.get<IngredientsRepositoryInterface>()));
  sl.registerLazySingleton<EditIngredientUseCase>(() => EditIngredientUseCase(sl.get<IngredientsRepositoryInterface>()));
  sl.registerLazySingleton<AddIngredientQuantityUseCase>(() => AddIngredientQuantityUseCase(sl.get<IngredientsRepositoryInterface>()));
  sl.registerLazySingleton<RemoveIngredientQuantityUseCase>(() => RemoveIngredientQuantityUseCase(sl.get<IngredientsRepositoryInterface>()));
  sl.registerLazySingleton<IngredientsStreamUseCase>(() => IngredientsStreamUseCase(sl.get<IngredientsRepositoryInterface>()));

}