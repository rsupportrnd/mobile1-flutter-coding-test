import 'package:mobile1_flutter_coding_test/index.dart';
import 'package:http/http.dart' as http;


@Injectable(as: RoomRepository)
class RoomRepositoryImpl implements RoomRepository {
  @override
  Future<List<RoomModel>> fetchRooms() async{
    final response =
    await http.get(Uri.https(ApiPaths.baseUrl, ApiPaths.rooms));
    if (response.statusCode == 200) {
      final RoomResponseModel roomResponseModel = RoomResponseModel.fromJson(jsonDecode(response.body));
      return roomResponseModel.chatRooms;
    } else {
      throw Exception('Failed to load rooms');
    }
  }

}