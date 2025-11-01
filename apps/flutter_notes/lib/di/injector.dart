import 'package:flutter_notes/utils/api.dart';
import 'package:flutter_notes/utils/api_storage_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setupDependencies() {
  getIt.registerLazySingleton<Api>(() => ApiStorageImpl());
}
