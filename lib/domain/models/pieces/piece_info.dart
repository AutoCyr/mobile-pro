import 'package:autocyr_pro/domain/models/commons/engin_type.dart';
import 'package:autocyr_pro/domain/models/pieces/disponibilities/auto_disponibility.dart';
import 'package:autocyr_pro/domain/models/pieces/disponibilities/category_disponibility.dart';
import 'package:autocyr_pro/domain/models/pieces/disponibilities/motor_disponibility.dart';
import 'package:autocyr_pro/domain/models/pieces/make.dart';
import 'package:autocyr_pro/domain/models/pieces/piece.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'piece_info.freezed.dart';
part 'piece_info.g.dart';

@freezed
class PieceInfo with _$PieceInfo {
  const factory PieceInfo({
    @JsonKey(name: 'detail_piece_id') required int detailPieceId,
    @JsonKey(name: 'partenaire_id') required int partenaireId,
    @JsonKey(name: 'piece_id') required int pieceId,
    @JsonKey(name: 'marque_id') required int marqueId,
    @JsonKey(name: 'type_engin_id') required int typeEnginId,
    @JsonKey(name: 'modele_piece') required String modelePiece,
    @JsonKey(name: 'numero_piece') required String numeroPiece,
    @JsonKey(name: 'annee_piece') required String anneePiece,
    @JsonKey(name: 'prix_piece') required int prixPiece,
    @JsonKey(name: 'garantie') required int garantie,
    @JsonKey(name: 'autres') String? autres,
    @JsonKey(name: 'image_piece') required String imagePiece,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'piece') required Piece piece,
    @JsonKey(name: 'marque') required Make marque,
    @JsonKey(name: 'type_engin') required EnginType typeEngin,
    @JsonKey(name: 'autos') List<AutoDisponibility>? autos,
    @JsonKey(name: 'moteurs') List<MotorDisponibility>? moteurs,
    @JsonKey(name: 'categories') List<CategoryDisponibility>? categories,
  }) = _PieceInfo;

  factory PieceInfo.fromJson(Map<String, dynamic> json) => _$PieceInfoFromJson(json);
}
