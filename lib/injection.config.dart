// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/home/home_cubit.dart' as _i6;
import 'application/search/search_cubit.dart' as _i5;
import 'data/home/home_repo_imp.dart' as _i4;
import 'domain/home/home_repo.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.HomeRepo>(() => _i4.HomeRepoImplementation());
  gh.factory<_i5.SearchCubit>(() => _i5.SearchCubit());
  gh.factory<_i6.HomeCubit>(() => _i6.HomeCubit(get<_i3.HomeRepo>()));
  return get;
}
