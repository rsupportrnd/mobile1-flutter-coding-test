import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/data/database/local_database.dart';
import 'package:mobile1_flutter_coding_test/data/utils/json_loader.dart';
import 'package:mobile1_flutter_coding_test/data/utils/json_loader_impl.dart';

final jsonLoaderProvider = Provider<IJsonLoader>((ref) => JsonLoader());
final localDatabaseProvider = Provider<LocalDatabase>((ref) => LocalDatabase());
