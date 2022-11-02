import 'package:get_it/get_it.dart';
import 'package:plan_meal_app/data/repositories/abstract/group_repository.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/data/repositories/group_repository_impl.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/group_repository_remote.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/user_repository_remote.dart';
import 'package:plan_meal_app/data/repositories/user_repository_impl.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<UserRepositoryRemote>(() => UserRepositoryRemote());
  sl.registerLazySingleton<GroupRepositoryRemote>(() => GroupRepositoryRemote());

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userRepositoryRemote: sl()));

  sl.registerLazySingleton<GroupRepository>(
      () => GroupRepositoryImpl(groupRepositoryRemote: sl()));
}
