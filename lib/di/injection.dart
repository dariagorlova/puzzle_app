import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:puzzle_app/di/injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
GetIt configureInjection(String environment) {
  return $initGetIt(getIt, environment: environment);
}
//Future<void> configureInjection() => $initGetIt(getIt);
