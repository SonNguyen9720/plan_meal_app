import 'package:get_it/get_it.dart';
import 'package:plan_meal_app/data/repositories/abstract/user_repository.dart';
import 'package:plan_meal_app/data/repositories/remote_repositories/repositories/user_repository_remote.dart';
import 'package:plan_meal_app/data/repositories/user_repository_impl.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<UserRepositoryRemote>(() => UserRepositoryRemote());

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userRepositoryRemote: sl()));
}
