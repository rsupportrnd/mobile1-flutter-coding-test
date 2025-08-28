import 'package:json_annotation/json_annotation.dart';
part 'rooms_request_model.g.dart';

@JsonSerializable()
class RoomsRequestModel {
  RoomsRequestModel();

factory RoomsRequestModel.fromJson(Map<String, dynamic> json) => _$RoomsRequestModelFromJson(json);
Map<String, dynamic> toJson() => _$RoomsRequestModelToJson(this);
}
