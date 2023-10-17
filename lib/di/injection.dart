import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:puzzle_app/di/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)

void configureDependencies() => getIt.init();

// GetIt configureInjection(String environment) {
//   return $initGetIt(getIt, environment: environment);
// }
