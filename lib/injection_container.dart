


import 'package:alex_quizz/app/core/data/datasources/cache_data.dart';

import '/app/authentication/data/datasources/remote_data.dart' as ac;
import '/app/authentication/data/datasources/cache_data.dart' as ac;
import '/app/authentication/data/respositories/repositories_impl.dart' as ac;
import '/app/authentication/domain/repositories/repositories.dart' as ac;
import '/app/authentication/domain/usecases/signup.dart' as ac;
import '/app/authentication/domain/usecases/login.dart' as ac;
import '/app/authentication/domain/usecases/get_account.dart' as ac;
import '/app/authentication/domain/usecases/setIp4.dart' as ac;
import '/app/authentication/domain/usecases/getIp4.dart' as ac;
import '/app/authentication/presentation/bloc/authentication/authentication_bloc.dart' as ac;
import '/app/authentication/presentation/bloc/account/account_cubit.dart' as ac;
import '/app/authentication/presentation/bloc/ip/ip_cubit.dart' as ac;

import 'app/home/data/datasources/remote_data.dart' as pf;
import 'app/home/data/respositories/repositories_impl.dart' as pf;
import 'app/home/domain/repositories/repositories.dart' as pf;
import 'app/home/presentation/bloc/user_info/user_info_bloc.dart' as pf;
import 'app/home/domain/usecases/get_info.dart' as pf;


import 'app/checkin/presentation/bloc/checkin/check_in_cubit.dart' as ci;
import 'app/checkin/data/datasources/remote_data.dart' as ci;
import 'app/checkin/data/respositories/repositories_impl.dart' as ci;
import 'app/checkin/domain/usecases/check_in.dart' as ci;
import 'app/checkin/domain/repositories/repositories.dart' as ci;

import 'app/quiz/presentation/bloc/quiz/quiz_bloc.dart' as qi;
import 'app/quiz/domain/usecases/get_quiz.dart' as qi;
import 'app/quiz/domain/usecases/get_quiz_result.dart' as qi;
import 'app/quiz/domain/usecases/submit_quiz.dart' as qi;
import 'app/quiz/domain/repositories/repositories.dart' as qi;
import 'app/quiz/data/datasources/remote_data.dart' as qi;
import 'app/quiz/data/respositories/repositories_impl.dart' as qi;

import 'app/poll/presentation/bloc/poll_bloc.dart' as po;
import 'app/poll/data/datasources/remote_data.dart' as po;
import 'app/poll/data/respositories/repositories_impl.dart' as po;
import 'app/poll/domain/repositories/repositories.dart' as po;
import 'app/poll/domain/usecases/get.dart' as po;
import 'app/poll/domain/usecases/submit.dart' as po;



import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';


final sl = GetIt.instance;


Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ac.AuthenticationBloc(
      signup: sl(),
      login: sl(),
      getAccount: sl()
  ));
  sl.registerFactory(() => ac.AccountCubit(
      getAccount: sl()
  ));
  sl.registerFactory(() => pf.UserInfoBloc(
      getInfo: sl()
  ));
  sl.registerFactory(() => ac.IpCubit(
    getIP4: sl(),
    setIP4: sl()
  ));
  sl.registerFactory(() => ci.CheckInCubit(checkIn: sl()));
  sl.registerFactory(() => qi.QuizBloc(
    getQuiz: sl(),
    getQuizResult: sl(),
    submitQuiz: sl()
  ));
  sl.registerFactory(() => po.PollBloc(
    get: sl(),
    submit: sl()
  ));


  // Usecase
  sl.registerLazySingleton(() => ac.Signup(repositories: sl()));
  sl.registerLazySingleton(() => ac.Login(repositories: sl()));
  sl.registerLazySingleton(() => ac.GetIP4(repositories: sl()));
  sl.registerLazySingleton(() => ac.SetIP4(repositories: sl()));
  sl.registerLazySingleton(() => ac.GetAccount(repositories: sl()));
  sl.registerLazySingleton(() => pf.GetInfo(repositories: sl()));
  sl.registerLazySingleton(() => ci.CheckIn(repositories: sl()));
  sl.registerLazySingleton(() => qi.GetQuiz(repositories: sl()));
  sl.registerLazySingleton(() => qi.GetQuizResult(repositories: sl()));
  sl.registerLazySingleton(() => qi.SubmitQuiz(repositories: sl()));
  sl.registerLazySingleton(() => po.Get(repositories: sl()));
  sl.registerLazySingleton(() => po.Submit(repositories: sl()));

  // Repositories
  sl.registerLazySingleton<ac.Repositories>(() => ac.RepositoriesImpl(
      remoteData: sl(),
      cacheData: sl(),
      coreCacheData: sl()
  ));
  sl.registerLazySingleton<pf.Repositories>(() => pf.RepositoriesImpl(
    remoteData: sl(),
    coreCacheData: sl()
  ));
  sl.registerLazySingleton<ci.Repositories>(() => ci.RepositoriesImpl(
      remoteData: sl(),
      coreCacheData: sl()
  ));
  sl.registerLazySingleton<qi.Repositories>(() => qi.RepositoriesImpl(
    coreCacheData: sl(),
    remoteData: sl()
  ));
  sl.registerLazySingleton<po.Repositories>(() => po.RepositoriesImpl(
    remoteData: sl(),
    coreCacheData: sl()
  ));

  // Data
  sl.registerLazySingleton<ac.RemoteData>(() => ac.RemoteDataImpl(
    dio: sl()
  ));
  sl.registerLazySingleton<ac.CacheData>(() => ac.CacheDataImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<pf.RemoteData>(() => pf.RemoteDataImpl(
    dio: sl()
  ));
  sl.registerLazySingleton<ci.RemoteData>(() => ci.RemoteDataImpl(
      dio: sl()
  ));
  sl.registerLazySingleton<CoreCacheData>(() => CoreCacheDataImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<qi.RemoteData>(() => qi.RemoteDataImpl(dio: sl()));
  sl.registerLazySingleton<po.RemoteData>(() => po.RemoteDataImpl(dio: sl()));



  // 3th service
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
}