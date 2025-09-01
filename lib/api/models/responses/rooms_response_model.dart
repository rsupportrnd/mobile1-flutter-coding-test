import 'package:json_annotation/json_annotation.dart';
import 'package:mobile1_flutter_coding_test/models/room_model.dart';
part 'rooms_response_model.g.dart';

@JsonSerializable()
class RoomsResponseModel {
  final List<RoomModel> chatRooms;

  RoomsResponseModel({
    required this.chatRooms,
  });

  factory RoomsResponseModel.fromJson(Map<String, dynamic> json) => _$RoomsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomsResponseModelToJson(this);
}