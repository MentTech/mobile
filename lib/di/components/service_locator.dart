import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile/data/network/apis/auth/auth_api.dart';
import 'package:mobile/data/network/apis/mentor/mentor_api.dart';
import 'package:mobile/data/network/dio_client.dart';
import 'package:mobile/data/network/rest_client.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/data/sharedpref/shared_preference_helper.dart';
import 'package:mobile/di/module/local_module.dart';
import 'package:mobile/di/module/network_module.dart';
import 'package:mobile/stores/authen/authen_store.dart';
import 'package:mobile/stores/authen_form/authen_form_store.dart';
import 'package:mobile/stores/language/language_store.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => MessageStore());
  getIt.registerFactory(() => AuthenticatorFormStore());

  // async singletons:----------------------------------------------------------
  // getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(
      () => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(
      SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton<Dio>(
      NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(RestClient());

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(
    AuthAPI(
      getIt<DioClient>(),
      // getIt<RestClient>(),
    ),
  );

  getIt.registerSingleton(
    MentorAPI(
      getIt<DioClient>(),
    ),
  );

  // data sources
  // getIt.registerSingleton(PostDataSource(await getIt.getAsync<Database>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(
    getIt<AuthAPI>(),
    getIt<MentorAPI>(),
    getIt<SharedPreferenceHelper>(),
    // getIt<PostDataSource>(),
  ));

  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  getIt.registerSingleton(ThemeStore(getIt<Repository>()));
  getIt.registerSingleton(AuthenStore(getIt<Repository>()));
}
