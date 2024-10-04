// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'make.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MakeImpl _$$MakeImplFromJson(Map<String, dynamic> json) => _$MakeImpl(
      marqueId: (json['marque_id'] as num).toInt(),
      libelleMarque: json['libelle_marque'] as String,
      typeMarque: (json['type_marque'] as num).toInt(),
      statut: (json['statut'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$MakeImplToJson(_$MakeImpl instance) =>
    <String, dynamic>{
      'marque_id': instance.marqueId,
      'libelle_marque': instance.libelleMarque,
      'type_marque': instance.typeMarque,
      'statut': instance.statut,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
