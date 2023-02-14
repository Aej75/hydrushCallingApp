import 'package:json_annotation/json_annotation.dart';

part 'rtc_response_model.g.dart';

@JsonSerializable()
class RtcTokenModel {
  final String rtcToken;

  RtcTokenModel(this.rtcToken);

  factory RtcTokenModel.fromJson(Map<String, dynamic> json) =>
      _$RtcTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$RtcTokenModelToJson(this);
}
