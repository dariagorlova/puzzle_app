import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:puzzle_app/di/injection.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
GetIt configureInjection() {
  return $initGetIt(getIt);
}
