import 'package:get_it/get_it.dart';
import 'package:plan_meal_app/data/repositories/abstract/firebase_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/food_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/ingredient_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/menu_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/data/repositories/firebase/firebase_repository_impl.dart';
import 'package:plan_meal_app/data/repositories/food_repository_impl.dart';
import 'package:plan_meal_app/data/repositories/group_repository_impl.dart';
import 'package:plan_meal_app/data/repositories/ingredient_repository_impl.dart';
import 'package:plan_meal_app/data/repositories/menu_repository_impl.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/food_repository_remote.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/group_repository_remote.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/ingredient_repository_remote.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/menu_repository_remote.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/shopping_list_repository_remote.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/user_repository_remote.dart';
import 'package:plan_meal_app/data/repositories/shopping_list_repository_impl.dart';
import 'package:plan_meal_app/data/repositories/user_repository_impl.dart';
import 'data/repositories/firebase/firebase_repository_remote.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<UserRepositoryRemote>(() => UserRepositoryRemote());
  sl.registerLazySingleton<GroupRepositoryRemote>(
      () => GroupRepositoryRemote());
  sl.registerLazySingleton<FoodRepositoryRemote>(() => FoodRepositoryRemote());
  sl.registerLazySingleton<MenuRepositoryRemote>(() => MenuRepositoryRemote());
  sl.registerLazySingleton<CloudFireStoreRepositoryRemote>(
      () => CloudFireStoreRepositoryRemote());
  sl.registerLazySingleton<ShoppingListRepositoryRemote>(
      () => ShoppingListRepositoryRemote());
  sl.registerLazySingleton<IngredientRepositoryRemote>(
      () => IngredientRepositoryRemote());

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userRepositoryRemote: sl()));

  sl.registerLazySingleton<GroupRepository>(
      () => GroupRepositoryImpl(groupRepositoryRemote: sl()));

  sl.registerLazySingleton<FoodRepository>(
      () => FoodRepositoryImpl(foodRepositoryRemote: sl()));

  sl.registerLazySingleton<MenuRepository>(
      () => MenuRepositoryImpl(menuRepositoryRemote: sl()));

  sl.registerLazySingleton<FirebaseFireStoreRepository>(() =>
      FirebaseFireStoreRepositoryImpl(cloudFireStoreRepositoryRemote: sl()));

  sl.registerLazySingleton<ShoppingListRepository>(() =>
      ShoppingListRepositoryImpl(shoppingListRepositoryRemote: sl()));

  sl.registerLazySingleton<IngredientRepository>(
      () => IngredientRepositoryImpl(ingredientRepositoryRemote: sl()));
}
