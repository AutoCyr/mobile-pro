import 'package:autocyr_pro/domain/models/pieces/make.dart';
import 'package:autocyr_pro/domain/models/pieces/piece.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_piece.freezed.dart';
part 'detail_piece.g.dart';

@freezed
class DetailPiece with _$DetailPiece {
  const factory DetailPiece({
    @JsonKey(name: 'detail_piece_id') required int detailPieceId,
    @JsonKey(name: 'partenaire_id') required int partenaireId,
    @JsonKey(name: 'piece_id') required int pieceId,
    @JsonKey(name: 'marque_id') required int marqueId,
    @JsonKey(name: 'modele_piece') required String modelePiece,
    @JsonKey(name: 'numero_piece') required String numeroPiece,
    @JsonKey(name: 'annee_piece') required String anneePiece,
    @JsonKey(name: 'autres') required String? autres,
    @JsonKey(name: 'image_piece') required String imagePiece,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'piece') required Piece piece,
    @JsonKey(name: 'marque') required Make marque,
  }) = _DetailPiece;

  factory DetailPiece.fromJson(Map<String, dynamic> json) => _$DetailPieceFromJson(json);
}
