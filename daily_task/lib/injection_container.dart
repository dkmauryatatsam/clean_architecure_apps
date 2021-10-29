import 'package:daily_task/features/dailyTask/data/datasources/local_data_source.dart';
import 'package:daily_task/features/dailyTask/data/datasources/local_data_source_impl.dart';
import 'package:daily_task/features/dailyTask/data/repositories/local_repository_impl.dart';
import 'package:daily_task/features/dailyTask/domain/repositories/local_repository.dart';
import 'package:daily_task/features/dailyTask/domain/usecases/add_task.dart';
import 'package:daily_task/features/dailyTask/domain/usecases/delete_task.dart';
import 'package:daily_task/features/dailyTask/domain/usecases/get_notification.dart';
import 'package:daily_task/features/dailyTask/domain/usecases/get_task.dart';
import 'package:daily_task/features/dailyTask/domain/usecases/open_database.dart';
import 'package:daily_task/features/dailyTask/domain/usecases/turn_on_notification.dart';
import 'package:daily_task/features/dailyTask/domain/usecases/update_task.dart';
import 'package:daily_task/features/dailyTask/presentation/controller/task_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

GetIt sl = GetIt.instance;
Future<void> init() async {
  //controller
  sl.registerFactory<TaskController>(
    () => TaskController(
        addTask: sl.call(),
        deleteTask: sl.call(),
        updateTask: sl.call(),
        getTask: sl.call(),
        getNotification: sl.call(),
        turnOnNotification: sl.call(),
        openDatabase: sl.call()),
  );
  // usecases
  sl.registerLazySingleton<AddTask>(() => AddTask(localRepository: sl.call()));
  sl.registerLazySingleton<DeleteTask>(
      () => DeleteTask(localRepository: sl.call()));
  sl.registerLazySingleton<GetNotification>(
      () => GetNotification(localRepository: sl.call()));
  sl.registerLazySingleton<GetTask>(() => GetTask(localRepository: sl.call()));
  sl.registerLazySingleton<OpenDatabase>(
      () => OpenDatabase(localRepository: sl.call()));
  sl.registerLazySingleton<TurnOnNotification>(
      () => TurnOnNotification(localRepository: sl.call()));
  sl.registerLazySingleton<UpdateTask>(
      () => UpdateTask(localRepository: sl.call()));

  // repository
  sl.registerLazySingleton<LocalRepository>(
      () => LocalRepositoryImpl(localDataSource: sl.call()));

  // remote data source
  final coreBox = GetStorage();
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(coreBox));
}
