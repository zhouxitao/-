import 'package:json_annotation/json_annotation.dart';

part 'room_list_item_data.g.dart';

@JsonSerializable()
class RoomListItemData {
  @JsonKey(name: 'houseCode')
  final String id;

  final String title;

  @JsonKey(name: 'desc')
  final String subTitle;

  @JsonKey(name: 'houseImg')
  final String imageUri;
  final List<String> tags;
  final int price;

  RoomListItemData({this.id, this.title, this.subTitle, this.imageUri, this.tags, this.price});

  factory RoomListItemData.fromJson(Map<String, dynamic> json) => _$RoomListItemDataFromJson(json);

  Map<String, dynamic> toJson() => _$RoomListItemDataToJson(this);
}