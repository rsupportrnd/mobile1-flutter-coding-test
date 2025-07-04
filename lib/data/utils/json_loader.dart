abstract class IJsonLoader {
  /// path로 .json 파일 읽어오는 메서드 - Object
  Future<Map<String, dynamic>> loadJson(String path);

  /// path로 .json 파일 읽어오는 메서드 - List<Object>
  Future<List<dynamic>> loadJsonList(String path);
}
