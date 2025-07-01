abstract class IJsonLoader {
  Future<Map<String, dynamic>> loadJson(String path);
  Future<List<dynamic>> loadJsonList(String path);
}
