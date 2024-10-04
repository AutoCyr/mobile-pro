// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_piece.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DetailPiece _$DetailPieceFromJson(Map<String, dynamic> json) {
  return _DetailPiece.fromJson(json);
}

/// @nodoc
mixin _$DetailPiece {
  @JsonKey(name: 'detail_piece_id')
  int get detailPieceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'partenaire_id')
  int get partenaireId => throw _privateConstructorUsedError;
  @JsonKey(name: 'piece_id')
  int get pieceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'marque_id')
  int get marqueId => throw _privateConstructorUsedError;
  @JsonKey(name: 'modele_piece')
  String get modelePiece => throw _privateConstructorUsedError;
  @JsonKey(name: 'numero_piece')
  String get numeroPiece => throw _privateConstructorUsedError;
  @JsonKey(name: 'annee_piece')
  String get anneePiece => throw _privateConstructorUsedError;
  @JsonKey(name: 'autres')
  String? get autres => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_piece')
  String get imagePiece => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'piece')
  Piece get piece => throw _privateConstructorUsedError;
  @JsonKey(name: 'marque')
  Make get marque => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DetailPieceCopyWith<DetailPiece> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailPieceCopyWith<$Res> {
  factory $DetailPieceCopyWith(
          DetailPiece value, $Res Function(DetailPiece) then) =
      _$DetailPieceCopyWithImpl<$Res, DetailPiece>;
  @useResult
  $Res call(
      {@JsonKey(name: 'detail_piece_id') int detailPieceId,
      @JsonKey(name: 'partenaire_id') int partenaireId,
      @JsonKey(name: 'piece_id') int pieceId,
      @JsonKey(name: 'marque_id') int marqueId,
      @JsonKey(name: 'modele_piece') String modelePiece,
      @JsonKey(name: 'numero_piece') String numeroPiece,
      @JsonKey(name: 'annee_piece') String anneePiece,
      @JsonKey(name: 'autres') String? autres,
      @JsonKey(name: 'image_piece') String imagePiece,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'piece') Piece piece,
      @JsonKey(name: 'marque') Make marque});

  $PieceCopyWith<$Res> get piece;
  $MakeCopyWith<$Res> get marque;
}

/// @nodoc
class _$DetailPieceCopyWithImpl<$Res, $Val extends DetailPiece>
    implements $DetailPieceCopyWith<$Res> {
  _$DetailPieceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? detailPieceId = null,
    Object? partenaireId = null,
    Object? pieceId = null,
    Object? marqueId = null,
    Object? modelePiece = null,
    Object? numeroPiece = null,
    Object? anneePiece = null,
    Object? autres = freezed,
    Object? imagePiece = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? piece = null,
    Object? marque = null,
  }) {
    return _then(_value.copyWith(
      detailPieceId: null == detailPieceId
          ? _value.detailPieceId
          : detailPieceId // ignore: cast_nullable_to_non_nullable
              as int,
      partenaireId: null == partenaireId
          ? _value.partenaireId
          : partenaireId // ignore: cast_nullable_to_non_nullable
              as int,
      pieceId: null == pieceId
          ? _value.pieceId
          : pieceId // ignore: cast_nullable_to_non_nullable
              as int,
      marqueId: null == marqueId
          ? _value.marqueId
          : marqueId // ignore: cast_nullable_to_non_nullable
              as int,
      modelePiece: null == modelePiece
          ? _value.modelePiece
          : modelePiece // ignore: cast_nullable_to_non_nullable
              as String,
      numeroPiece: null == numeroPiece
          ? _value.numeroPiece
          : numeroPiece // ignore: cast_nullable_to_non_nullable
              as String,
      anneePiece: null == anneePiece
          ? _value.anneePiece
          : anneePiece // ignore: cast_nullable_to_non_nullable
              as String,
      autres: freezed == autres
          ? _value.autres
          : autres // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePiece: null == imagePiece
          ? _value.imagePiece
          : imagePiece // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      piece: null == piece
          ? _value.piece
          : piece // ignore: cast_nullable_to_non_nullable
              as Piece,
      marque: null == marque
          ? _value.marque
          : marque // ignore: cast_nullable_to_non_nullable
              as Make,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PieceCopyWith<$Res> get piece {
    return $PieceCopyWith<$Res>(_value.piece, (value) {
      return _then(_value.copyWith(piece: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MakeCopyWith<$Res> get marque {
    return $MakeCopyWith<$Res>(_value.marque, (value) {
      return _then(_value.copyWith(marque: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DetailPieceImplCopyWith<$Res>
    implements $DetailPieceCopyWith<$Res> {
  factory _$$DetailPieceImplCopyWith(
          _$DetailPieceImpl value, $Res Function(_$DetailPieceImpl) then) =
      __$$DetailPieceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'detail_piece_id') int detailPieceId,
      @JsonKey(name: 'partenaire_id') int partenaireId,
      @JsonKey(name: 'piece_id') int pieceId,
      @JsonKey(name: 'marque_id') int marqueId,
      @JsonKey(name: 'modele_piece') String modelePiece,
      @JsonKey(name: 'numero_piece') String numeroPiece,
      @JsonKey(name: 'annee_piece') String anneePiece,
      @JsonKey(name: 'autres') String? autres,
      @JsonKey(name: 'image_piece') String imagePiece,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'piece') Piece piece,
      @JsonKey(name: 'marque') Make marque});

  @override
  $PieceCopyWith<$Res> get piece;
  @override
  $MakeCopyWith<$Res> get marque;
}

/// @nodoc
class __$$DetailPieceImplCopyWithImpl<$Res>
    extends _$DetailPieceCopyWithImpl<$Res, _$DetailPieceImpl>
    implements _$$DetailPieceImplCopyWith<$Res> {
  __$$DetailPieceImplCopyWithImpl(
      _$DetailPieceImpl _value, $Res Function(_$DetailPieceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? detailPieceId = null,
    Object? partenaireId = null,
    Object? pieceId = null,
    Object? marqueId = null,
    Object? modelePiece = null,
    Object? numeroPiece = null,
    Object? anneePiece = null,
    Object? autres = freezed,
    Object? imagePiece = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? piece = null,
    Object? marque = null,
  }) {
    return _then(_$DetailPieceImpl(
      detailPieceId: null == detailPieceId
          ? _value.detailPieceId
          : detailPieceId // ignore: cast_nullable_to_non_nullable
              as int,
      partenaireId: null == partenaireId
          ? _value.partenaireId
          : partenaireId // ignore: cast_nullable_to_non_nullable
              as int,
      pieceId: null == pieceId
          ? _value.pieceId
          : pieceId // ignore: cast_nullable_to_non_nullable
              as int,
      marqueId: null == marqueId
          ? _value.marqueId
          : marqueId // ignore: cast_nullable_to_non_nullable
              as int,
      modelePiece: null == modelePiece
          ? _value.modelePiece
          : modelePiece // ignore: cast_nullable_to_non_nullable
              as String,
      numeroPiece: null == numeroPiece
          ? _value.numeroPiece
          : numeroPiece // ignore: cast_nullable_to_non_nullable
              as String,
      anneePiece: null == anneePiece
          ? _value.anneePiece
          : anneePiece // ignore: cast_nullable_to_non_nullable
              as String,
      autres: freezed == autres
          ? _value.autres
          : autres // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePiece: null == imagePiece
          ? _value.imagePiece
          : imagePiece // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      piece: null == piece
          ? _value.piece
          : piece // ignore: cast_nullable_to_non_nullable
              as Piece,
      marque: null == marque
          ? _value.marque
          : marque // ignore: cast_nullable_to_non_nullable
              as Make,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DetailPieceImpl implements _DetailPiece {
  const _$DetailPieceImpl(
      {@JsonKey(name: 'detail_piece_id') required this.detailPieceId,
      @JsonKey(name: 'partenaire_id') required this.partenaireId,
      @JsonKey(name: 'piece_id') required this.pieceId,
      @JsonKey(name: 'marque_id') required this.marqueId,
      @JsonKey(name: 'modele_piece') required this.modelePiece,
      @JsonKey(name: 'numero_piece') required this.numeroPiece,
      @JsonKey(name: 'annee_piece') required this.anneePiece,
      @JsonKey(name: 'autres') required this.autres,
      @JsonKey(name: 'image_piece') required this.imagePiece,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'piece') required this.piece,
      @JsonKey(name: 'marque') required this.marque});

  factory _$DetailPieceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetailPieceImplFromJson(json);

  @override
  @JsonKey(name: 'detail_piece_id')
  final int detailPieceId;
  @override
  @JsonKey(name: 'partenaire_id')
  final int partenaireId;
  @override
  @JsonKey(name: 'piece_id')
  final int pieceId;
  @override
  @JsonKey(name: 'marque_id')
  final int marqueId;
  @override
  @JsonKey(name: 'modele_piece')
  final String modelePiece;
  @override
  @JsonKey(name: 'numero_piece')
  final String numeroPiece;
  @override
  @JsonKey(name: 'annee_piece')
  final String anneePiece;
  @override
  @JsonKey(name: 'autres')
  final String? autres;
  @override
  @JsonKey(name: 'image_piece')
  final String imagePiece;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  @JsonKey(name: 'piece')
  final Piece piece;
  @override
  @JsonKey(name: 'marque')
  final Make marque;

  @override
  String toString() {
    return 'DetailPiece(detailPieceId: $detailPieceId, partenaireId: $partenaireId, pieceId: $pieceId, marqueId: $marqueId, modelePiece: $modelePiece, numeroPiece: $numeroPiece, anneePiece: $anneePiece, autres: $autres, imagePiece: $imagePiece, createdAt: $createdAt, updatedAt: $updatedAt, piece: $piece, marque: $marque)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailPieceImpl &&
            (identical(other.detailPieceId, detailPieceId) ||
                other.detailPieceId == detailPieceId) &&
            (identical(other.partenaireId, partenaireId) ||
                other.partenaireId == partenaireId) &&
            (identical(other.pieceId, pieceId) || other.pieceId == pieceId) &&
            (identical(other.marqueId, marqueId) ||
                other.marqueId == marqueId) &&
            (identical(other.modelePiece, modelePiece) ||
                other.modelePiece == modelePiece) &&
            (identical(other.numeroPiece, numeroPiece) ||
                other.numeroPiece == numeroPiece) &&
            (identical(other.anneePiece, anneePiece) ||
                other.anneePiece == anneePiece) &&
            (identical(other.autres, autres) || other.autres == autres) &&
            (identical(other.imagePiece, imagePiece) ||
                other.imagePiece == imagePiece) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.piece, piece) || other.piece == piece) &&
            (identical(other.marque, marque) || other.marque == marque));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      detailPieceId,
      partenaireId,
      pieceId,
      marqueId,
      modelePiece,
      numeroPiece,
      anneePiece,
      autres,
      imagePiece,
      createdAt,
      updatedAt,
      piece,
      marque);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailPieceImplCopyWith<_$DetailPieceImpl> get copyWith =>
      __$$DetailPieceImplCopyWithImpl<_$DetailPieceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DetailPieceImplToJson(
      this,
    );
  }
}

abstract class _DetailPiece implements DetailPiece {
  const factory _DetailPiece(
      {@JsonKey(name: 'detail_piece_id') required final int detailPieceId,
      @JsonKey(name: 'partenaire_id') required final int partenaireId,
      @JsonKey(name: 'piece_id') required final int pieceId,
      @JsonKey(name: 'marque_id') required final int marqueId,
      @JsonKey(name: 'modele_piece') required final String modelePiece,
      @JsonKey(name: 'numero_piece') required final String numeroPiece,
      @JsonKey(name: 'annee_piece') required final String anneePiece,
      @JsonKey(name: 'autres') required final String? autres,
      @JsonKey(name: 'image_piece') required final String imagePiece,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'updated_at') required final DateTime updatedAt,
      @JsonKey(name: 'piece') required final Piece piece,
      @JsonKey(name: 'marque') required final Make marque}) = _$DetailPieceImpl;

  factory _DetailPiece.fromJson(Map<String, dynamic> json) =
      _$DetailPieceImpl.fromJson;

  @override
  @JsonKey(name: 'detail_piece_id')
  int get detailPieceId;
  @override
  @JsonKey(name: 'partenaire_id')
  int get partenaireId;
  @override
  @JsonKey(name: 'piece_id')
  int get pieceId;
  @override
  @JsonKey(name: 'marque_id')
  int get marqueId;
  @override
  @JsonKey(name: 'modele_piece')
  String get modelePiece;
  @override
  @JsonKey(name: 'numero_piece')
  String get numeroPiece;
  @override
  @JsonKey(name: 'annee_piece')
  String get anneePiece;
  @override
  @JsonKey(name: 'autres')
  String? get autres;
  @override
  @JsonKey(name: 'image_piece')
  String get imagePiece;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  @JsonKey(name: 'piece')
  Piece get piece;
  @override
  @JsonKey(name: 'marque')
  Make get marque;
  @override
  @JsonKey(ignore: true)
  _$$DetailPieceImplCopyWith<_$DetailPieceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
