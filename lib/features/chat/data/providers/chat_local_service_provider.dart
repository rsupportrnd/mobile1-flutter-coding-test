import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/sources/chat_local_service.dart';

part 'chat_local_service_provider.g.dart';

@riverpod
ChatLocalService chatLocalService(Ref ref) {
  return ChatLocalService();
}