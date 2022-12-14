// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/service/common_functions.dart' as _i4;
import '../core/service/navigator.dart' as _i5;
import '../features/game/cubit/game_cubit.dart' as _i6;
import '../routes/app_router.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.AppRouter>(() => _i3.AppRouter());
  gh.lazySingleton<_i4.CommonFunctions>(() => _i4.CommonFunctions());
  gh.factory<_i5.PuzzleNavigator>(
      () => _i5.PuzzleNavigator(get<_i3.AppRouter>()));
  gh.factory<_i6.GameCubit>(() => _i6.GameCubit(
        get<_i5.PuzzleNavigator>(),
        get<_i4.CommonFunctions>(),
      ));
  return get;
}
