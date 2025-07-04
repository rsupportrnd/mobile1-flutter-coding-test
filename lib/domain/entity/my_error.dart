import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_error.freezed.dart';

enum ErrorType { unauthorized, network, server, unknown }

@freezed
abstract class MyError with _$MyError {
  const factory MyError({
    required ErrorType type,
    required String message,
  }) = _MyError;

//   // factory AppError.fromJson(Map<String, dynamic> json) =>
//   //     _$AppErrorFromJson(json);
}
