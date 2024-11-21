// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:mobile1_flutter_coding_test/index.dart' as _i501;
import 'package:mobile1_flutter_coding_test/providers/room/room_list_cubit.dart'
    as _i428;
import 'package:mobile1_flutter_coding_test/providers/user/user_list_cubit.dart'
    as _i522;
import 'package:mobile1_flutter_coding_test/repositories/room/room_repository_impl.dart'
    as _i981;
import 'package:mobile1_flutter_coding_test/repositories/user/user_repository_impl.dart'
    as _i675;
import 'package:mobile1_flutter_coding_test/services/room/room_service.dart'
    as _i363;
import 'package:mobile1_flutter_coding_test/services/user/user_service.dart'
    as _i675;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i501.UserRepository>(() => _i675.UserRepositoryImpl());
    gh.factory<_i501.RoomRepository>(() => _i981.RoomRepositoryImpl());
    gh.factory<_i675.UserService>(
        () => _i675.UserService(gh<_i501.UserRepository>()));
    gh.factory<_i363.RoomService>(
        () => _i363.RoomService(gh<_i501.RoomRepository>()));
    gh.factory<_i522.UserListCubit>(
        () => _i522.UserListCubit(gh<_i501.UserService>()));
    gh.factory<_i428.RoomListCubit>(
        () => _i428.RoomListCubit(gh<_i501.RoomService>()));
    return this;
  }
}
