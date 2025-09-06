// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeasurementDTO _$MeasurementDTOFromJson(Map<String, dynamic> json) =>
    MeasurementDTO(
      id: json['id'],
      time: json['time'],
      temperature: json['temperature'],
      humidity: json['humidity'],
      researcher: json['researcher'],
    );

Map<String, dynamic> _$MeasurementDTOToJson(MeasurementDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time,
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'researcher': instance.researcher,
    };
