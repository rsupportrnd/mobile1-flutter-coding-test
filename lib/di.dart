import 'package:mobile1_flutter_coding_test/index.dart';
import 'di.config.dart';
import 'local_database/objectbox.dart';
final getIt = GetIt.instance;
@InjectableInit()
void configureDependencies() async{
  getIt.init();
  final objectBox = await ObjectBox.create();
  getIt.registerSingleton<ObjectBox>(objectBox);
}
