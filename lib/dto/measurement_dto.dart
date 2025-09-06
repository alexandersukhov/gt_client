import 'package:freezed_annotation/freezed_annotation.dart';

part 'measurement_dto.g.dart';

@JsonSerializable()
class MeasurementDTO {
  final dynamic id;
  final dynamic time;
  final dynamic temperature;
  final dynamic humidity;
  final dynamic researcher;

  MeasurementDTO({
    this.id,
    this.time,
    this.temperature,
    this.humidity,
    this.researcher,
  });


  factory MeasurementDTO.fromJson(Map<String, dynamic> json) => _$MeasurementDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MeasurementDTOToJson(this);
}