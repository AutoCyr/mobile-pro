// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_piece.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DetailPieceImpl _$$DetailPieceImplFromJson(Map<String, dynamic> json) =>
    _$DetailPieceImpl(
      detailPieceId: (json['detail_piece_id'] as num).toInt(),
      partenaireId: (json['partenaire_id'] as num).toInt(),
      pieceId: (json['piece_id'] as num).toInt(),
      marqueId: (json['marque_id'] as num).toInt(),
      modelePiece: json['modele_piece'] as String,
      numeroPiece: json['numero_piece'] as String,
      anneePiece: json['annee_piece'] as String,
      autres: json['autres'] as String?,
      imagePiece: json['image_piece'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      piece: Piece.fromJson(json['piece'] as Map<String, dynamic>),
      marque: Make.fromJson(json['marque'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DetailPieceImplToJson(_$DetailPieceImpl instance) =>
    <String, dynamic>{
      'detail_piece_id': instance.detailPieceId,
      'partenaire_id': instance.partenaireId,
      'piece_id': instance.pieceId,
      'marque_id': instance.marqueId,
      'modele_piece': instance.modelePiece,
      'numero_piece': instance.numeroPiece,
      'annee_piece': instance.anneePiece,
      'autres': instance.autres,
      'image_piece': instance.imagePiece,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'piece': instance.piece,
      'marque': instance.marque,
    };
