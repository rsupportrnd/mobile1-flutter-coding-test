import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile1_flutter_coding_test/src/core/constant/hive_constant.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/message_list_response_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/message_list_response_model.dart';

part 'local_message_datasource.g.dart';

@riverpod
LocalMessageDatasource localMessageDatasource(Ref ref) {
  return LocalMessageDatasource();
}

class LocalMessageDatasource {
  Box<dynamic> get _box => Hive.box<dynamic>(HiveStringConstant.messages);

  Future<List<MessageModel>> getMessages({required String roomId}) async {
    final List<dynamic>? stored = _box.get(roomId) as List<dynamic>?;
    if (stored == null) return [];
    return stored.map((e) => MessageModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<void> saveMessages({
    required String roomId,
    required List<MessageEntity> messages,
  }) async {
    await _box.put(roomId, messages.map((e) => e.toJson()).toList());
  }
}
