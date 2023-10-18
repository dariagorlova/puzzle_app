// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:puzzle_app/core/service/common_functions.dart' as _i4;
import 'package:puzzle_app/core/service/navigator.dart' as _i5;
import 'package:puzzle_app/features/game/cubit/game_cubit.dart' as _i6;
import 'package:puzzle_app/routes/app_router.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AppRouter>(() => _i3.AppRouter());
    gh.lazySingleton<_i4.CommonFunctions>(() => _i4.CommonFunctions());
    gh.factory<_i5.PuzzleNavigator>(
        () => _i5.PuzzleNavigator(gh<_i3.AppRouter>()));
    gh.factory<_i6.GameCubit>(() => _i6.GameCubit(
          gh<_i5.PuzzleNavigator>(),
          gh<_i4.CommonFunctions>(),
        ));
    return this;
  }
}
