import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donezo/src/auth/domain/usecases/sign_in_with_email_password_use_case.dart';
import 'package:donezo/src/auth/domain/usecases/sign_in_with_google_use_case.dart';
import 'package:donezo/src/task_management/data/datasources/task_datasource.dart';
import 'package:donezo/src/task_management/data/repositories/task_repository_impl.dart';
import 'package:donezo/src/task_management/domain/repositories/task_repository.dart';
import 'package:donezo/src/task_management/domain/usecases/add_category_use_case.dart';
import 'package:donezo/src/task_management/injection.dart';
import 'package:donezo/src/task_management/presentation/bloc/task_form/task_form_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../src/auth/data/datasources/auth_firebase_datasource.dart';
import '../../src/auth/data/repositories/auth_repositories_impl.dart';
import '../../src/auth/domain/repositories/auth_repository.dart';
import '../../src/auth/domain/usecases/sign_up_use_case.dart';
import '../../src/auth/presentation/bloc/auth/auth_bloc.dart';
import '../resources/params.dart';

final sl = GetIt.instance;

void init() async {
  initTaskManagementDependencies(sl);

  // Flutter Secure Storage
  sl.registerFactory<FlutterSecureStorage>(() => const FlutterSecureStorage());

  // No Params
  sl.registerLazySingleton<NoParams>(() => NoParams());

  // Firebase
  sl.registerFactory<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerFactory<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerFactory<GoogleSignIn>(() => GoogleSignIn());

  /*
    Registering Dependencies :
    - Repositories
    - Datasources
    - Params (Optional)
    - UseCases
    - Bloc
  */

  // Auth
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoriesImpl(sl(), sl(), sl()));
  sl.registerLazySingleton<AuthFirebaseDatasource>(() => AuthFirebaseDatasource(sl()));
  sl.registerLazySingleton<SignUpParams>(() => SignUpParams(email: '', password: ''));
  sl.registerLazySingleton<SignInParams>(() => SignInParams(email: '', password: ''));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl()));
  sl.registerLazySingleton<SignInWithEmailPasswordUseCase>(() => SignInWithEmailPasswordUseCase(sl()));
  sl.registerLazySingleton<SignInWithGoogleUseCase>(() => SignInWithGoogleUseCase(sl()));

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signUpUseCase: sl(),
      signUpParams: sl(),
      signInWithEmailPasswordUseCase: sl(),
      signInParams: sl(),
      noParams: sl(),
      signInWithGoogleUseCase: sl(),
    ),
  );

  // Task Management
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(taskDatasource: sl()));
  sl.registerLazySingleton<TaskDatasource>(() => TaskDatasource(firestore: sl()));
  sl.registerLazySingleton<AddCategoryUseCase>(() => AddCategoryUseCase(taskRepository: sl()));

  sl.registerFactory<TaskFormBloc>(() => TaskFormBloc(addCategoryUseCase: sl()));
}
