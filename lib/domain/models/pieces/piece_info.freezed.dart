// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'piece_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PieceInfo _$PieceInfoFromJson(Map<String, dynamic> json) {
  return _PieceInfo.fromJson(json);
}

/// @nodoc
mixin _$PieceInfo {
  @JsonKey(name: 'detail_piece_id')
  int get detailPieceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'partenaire_id')
  int get partenaireId => throw _privateConstructorUsedError;
  @JsonKey(name: 'piece_id')
  int get pieceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'marque_id')
  int get marqueId => throw _privateConstructorUsedError;
  @JsonKey(name: 'type_engin_id')
  int get typeEnginId => throw _privateConstructorUsedError;
  @JsonKey(name: 'modele_piece')
  String get modelePiece => throw _privateConstructorUsedError;
  @JsonKey(name: 'numero_piece')
  String get numeroPiece => throw _privateConstructorUsedError;
  @JsonKey(name: 'annee_piece')
  String get anneePiece => throw _privateConstructorUsedError;
  @JsonKey(name: 'prix_piece')
  int get prixPiece => throw _privateConstructorUsedError;
  @JsonKey(name: 'garantie')
  int get garantie => throw _privateConstructorUsedError;
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
  @JsonKey(name: 'type_engin')
  EnginType get typeEngin => throw _privateConstructorUsedError;
  @JsonKey(name: 'autos')
  List<AutoDisponibility>? get autos => throw _privateConstructorUsedError;
  @JsonKey(name: 'moteurs')
  List<MotorDisponibility>? get moteurs => throw _privateConstructorUsedError;
  @JsonKey(name: 'categories')
  List<CategoryDisponibility>? get categories =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PieceInfoCopyWith<PieceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PieceInfoCopyWith<$Res> {
  factory $PieceInfoCopyWith(PieceInfo value, $Res Function(PieceInfo) then) =
      _$PieceInfoCopyWithImpl<$Res, PieceInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: 'detail_piece_id') int detailPieceId,
      @JsonKey(name: 'partenaire_id') int partenaireId,
      @JsonKey(name: 'piece_id') int pieceId,
      @JsonKey(name: 'marque_id') int marqueId,
      @JsonKey(name: 'type_engin_id') int typeEnginId,
      @JsonKey(name: 'modele_piece') String modelePiece,
      @JsonKey(name: 'numero_piece') String numeroPiece,
      @JsonKey(name: 'annee_piece') String anneePiece,
      @JsonKey(name: 'prix_piece') int prixPiece,
      @JsonKey(name: 'garantie') int garantie,
      @JsonKey(name: 'autres') String? autres,
      @JsonKey(name: 'image_piece') String imagePiece,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'piece') Piece piece,
      @JsonKey(name: 'marque') Make marque,
      @JsonKey(name: 'type_engin') EnginType typeEngin,
      @JsonKey(name: 'autos') List<AutoDisponibility>? autos,
      @JsonKey(name: 'moteurs') List<MotorDisponibility>? moteurs,
      @JsonKey(name: 'categories') List<CategoryDisponibility>? categories});

  $PieceCopyWith<$Res> get piece;
  $MakeCopyWith<$Res> get marque;
  $EnginTypeCopyWith<$Res> get typeEngin;
}

/// @nodoc
class _$PieceInfoCopyWithImpl<$Res, $Val extends PieceInfo>
    implements $PieceInfoCopyWith<$Res> {
  _$PieceInfoCopyWithImpl(this._value, this._then);

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
    Object? typeEnginId = null,
    Object? modelePiece = null,
    Object? numeroPiece = null,
    Object? anneePiece = null,
    Object? prixPiece = null,
    Object? garantie = null,
    Object? autres = freezed,
    Object? imagePiece = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? piece = null,
    Object? marque = null,
    Object? typeEngin = null,
    Object? autos = freezed,
    Object? moteurs = freezed,
    Object? categories = freezed,
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
      typeEnginId: null == typeEnginId
          ? _value.typeEnginId
          : typeEnginId // ignore: cast_nullable_to_non_nullable
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
      prixPiece: null == prixPiece
          ? _value.prixPiece
          : prixPiece // ignore: cast_nullable_to_non_nullable
              as int,
      garantie: null == garantie
          ? _value.garantie
          : garantie // ignore: cast_nullable_to_non_nullable
              as int,
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
      typeEngin: null == typeEngin
          ? _value.typeEngin
          : typeEngin // ignore: cast_nullable_to_non_nullable
              as EnginType,
      autos: freezed == autos
          ? _value.autos
          : autos // ignore: cast_nullable_to_non_nullable
              as List<AutoDisponibility>?,
      moteurs: freezed == moteurs
          ? _value.moteurs
          : moteurs // ignore: cast_nullable_to_non_nullable
              as List<MotorDisponibility>?,
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryDisponibility>?,
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

  @override
  @pragma('vm:prefer-inline')
  $EnginTypeCopyWith<$Res> get typeEngin {
    return $EnginTypeCopyWith<$Res>(_value.typeEngin, (value) {
      return _then(_value.copyWith(typeEngin: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PieceInfoImplCopyWith<$Res>
    implements $PieceInfoCopyWith<$Res> {
  factory _$$PieceInfoImplCopyWith(
          _$PieceInfoImpl value, $Res Function(_$PieceInfoImpl) then) =
      __$$PieceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'detail_piece_id') int detailPieceId,
      @JsonKey(name: 'partenaire_id') int partenaireId,
      @JsonKey(name: 'piece_id') int pieceId,
      @JsonKey(name: 'marque_id') int marqueId,
      @JsonKey(name: 'type_engin_id') int typeEnginId,
      @JsonKey(name: 'modele_piece') String modelePiece,
      @JsonKey(name: 'numero_piece') String numeroPiece,
      @JsonKey(name: 'annee_piece') String anneePiece,
      @JsonKey(name: 'prix_piece') int prixPiece,
      @JsonKey(name: 'garantie') int garantie,
      @JsonKey(name: 'autres') String? autres,
      @JsonKey(name: 'image_piece') String imagePiece,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt,
      @JsonKey(name: 'piece') Piece piece,
      @JsonKey(name: 'marque') Make marque,
      @JsonKey(name: 'type_engin') EnginType typeEngin,
      @JsonKey(name: 'autos') List<AutoDisponibility>? autos,
      @JsonKey(name: 'moteurs') List<MotorDisponibility>? moteurs,
      @JsonKey(name: 'categories') List<CategoryDisponibility>? categories});

  @override
  $PieceCopyWith<$Res> get piece;
  @override
  $MakeCopyWith<$Res> get marque;
  @override
  $EnginTypeCopyWith<$Res> get typeEngin;
}

/// @nodoc
class __$$PieceInfoImplCopyWithImpl<$Res>
    extends _$PieceInfoCopyWithImpl<$Res, _$PieceInfoImpl>
    implements _$$PieceInfoImplCopyWith<$Res> {
  __$$PieceInfoImplCopyWithImpl(
      _$PieceInfoImpl _value, $Res Function(_$PieceInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? detailPieceId = null,
    Object? partenaireId = null,
    Object? pieceId = null,
    Object? marqueId = null,
    Object? typeEnginId = null,
    Object? modelePiece = null,
    Object? numeroPiece = null,
    Object? anneePiece = null,
    Object? prixPiece = null,
    Object? garantie = null,
    Object? autres = freezed,
    Object? imagePiece = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? piece = null,
    Object? marque = null,
    Object? typeEngin = null,
    Object? autos = freezed,
    Object? moteurs = freezed,
    Object? categories = freezed,
  }) {
    return _then(_$PieceInfoImpl(
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
      typeEnginId: null == typeEnginId
          ? _value.typeEnginId
          : typeEnginId // ignore: cast_nullable_to_non_nullable
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
      prixPiece: null == prixPiece
          ? _value.prixPiece
          : prixPiece // ignore: cast_nullable_to_non_nullable
              as int,
      garantie: null == garantie
          ? _value.garantie
          : garantie // ignore: cast_nullable_to_non_nullable
              as int,
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
      typeEngin: null == typeEngin
          ? _value.typeEngin
          : typeEngin // ignore: cast_nullable_to_non_nullable
              as EnginType,
      autos: freezed == autos
          ? _value._autos
          : autos // ignore: cast_nullable_to_non_nullable
              as List<AutoDisponibility>?,
      moteurs: freezed == moteurs
          ? _value._moteurs
          : moteurs // ignore: cast_nullable_to_non_nullable
              as List<MotorDisponibility>?,
      categories: freezed == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryDisponibility>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PieceInfoImpl implements _PieceInfo {
  const _$PieceInfoImpl(
      {@JsonKey(name: 'detail_piece_id') required this.detailPieceId,
      @JsonKey(name: 'partenaire_id') required this.partenaireId,
      @JsonKey(name: 'piece_id') required this.pieceId,
      @JsonKey(name: 'marque_id') required this.marqueId,
      @JsonKey(name: 'type_engin_id') required this.typeEnginId,
      @JsonKey(name: 'modele_piece') required this.modelePiece,
      @JsonKey(name: 'numero_piece') required this.numeroPiece,
      @JsonKey(name: 'annee_piece') required this.anneePiece,
      @JsonKey(name: 'prix_piece') required this.prixPiece,
      @JsonKey(name: 'garantie') required this.garantie,
      @JsonKey(name: 'autres') this.autres,
      @JsonKey(name: 'image_piece') required this.imagePiece,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      @JsonKey(name: 'piece') required this.piece,
      @JsonKey(name: 'marque') required this.marque,
      @JsonKey(name: 'type_engin') required this.typeEngin,
      @JsonKey(name: 'autos') final List<AutoDisponibility>? autos,
      @JsonKey(name: 'moteurs') final List<MotorDisponibility>? moteurs,
      @JsonKey(name: 'categories')
      final List<CategoryDisponibility>? categories})
      : _autos = autos,
        _moteurs = moteurs,
        _categories = categories;

  factory _$PieceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PieceInfoImplFromJson(json);

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
  @JsonKey(name: 'type_engin_id')
  final int typeEnginId;
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
  @JsonKey(name: 'prix_piece')
  final int prixPiece;
  @override
  @JsonKey(name: 'garantie')
  final int garantie;
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
  @JsonKey(name: 'type_engin')
  final EnginType typeEngin;
  final List<AutoDisponibility>? _autos;
  @override
  @JsonKey(name: 'autos')
  List<AutoDisponibility>? get autos {
    final value = _autos;
    if (value == null) return null;
    if (_autos is EqualUnmodifiableListView) return _autos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<MotorDisponibility>? _moteurs;
  @override
  @JsonKey(name: 'moteurs')
  List<MotorDisponibility>? get moteurs {
    final value = _moteurs;
    if (value == null) return null;
    if (_moteurs is EqualUnmodifiableListView) return _moteurs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CategoryDisponibility>? _categories;
  @override
  @JsonKey(name: 'categories')
  List<CategoryDisponibility>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PieceInfo(detailPieceId: $detailPieceId, partenaireId: $partenaireId, pieceId: $pieceId, marqueId: $marqueId, typeEnginId: $typeEnginId, modelePiece: $modelePiece, numeroPiece: $numeroPiece, anneePiece: $anneePiece, prixPiece: $prixPiece, garantie: $garantie, autres: $autres, imagePiece: $imagePiece, createdAt: $createdAt, updatedAt: $updatedAt, piece: $piece, marque: $marque, typeEngin: $typeEngin, autos: $autos, moteurs: $moteurs, categories: $categories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PieceInfoImpl &&
            (identical(other.detailPieceId, detailPieceId) ||
                other.detailPieceId == detailPieceId) &&
            (identical(other.partenaireId, partenaireId) ||
                other.partenaireId == partenaireId) &&
            (identical(other.pieceId, pieceId) || other.pieceId == pieceId) &&
            (identical(other.marqueId, marqueId) ||
                other.marqueId == marqueId) &&
            (identical(other.typeEnginId, typeEnginId) ||
                other.typeEnginId == typeEnginId) &&
            (identical(other.modelePiece, modelePiece) ||
                other.modelePiece == modelePiece) &&
            (identical(other.numeroPiece, numeroPiece) ||
                other.numeroPiece == numeroPiece) &&
            (identical(other.anneePiece, anneePiece) ||
                other.anneePiece == anneePiece) &&
            (identical(other.prixPiece, prixPiece) ||
                other.prixPiece == prixPiece) &&
            (identical(other.garantie, garantie) ||
                other.garantie == garantie) &&
            (identical(other.autres, autres) || other.autres == autres) &&
            (identical(other.imagePiece, imagePiece) ||
                other.imagePiece == imagePiece) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.piece, piece) || other.piece == piece) &&
            (identical(other.marque, marque) || other.marque == marque) &&
            (identical(other.typeEngin, typeEngin) ||
                other.typeEngin == typeEngin) &&
            const DeepCollectionEquality().equals(other._autos, _autos) &&
            const DeepCollectionEquality().equals(other._moteurs, _moteurs) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        detailPieceId,
        partenaireId,
        pieceId,
        marqueId,
        typeEnginId,
        modelePiece,
        numeroPiece,
        anneePiece,
        prixPiece,
        garantie,
        autres,
        imagePiece,
        createdAt,
        updatedAt,
        piece,
        marque,
        typeEngin,
        const DeepCollectionEquality().hash(_autos),
        const DeepCollectionEquality().hash(_moteurs),
        const DeepCollectionEquality().hash(_categories)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PieceInfoImplCopyWith<_$PieceInfoImpl> get copyWith =>
      __$$PieceInfoImplCopyWithImpl<_$PieceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PieceInfoImplToJson(
      this,
    );
  }
}

abstract class _PieceInfo implements PieceInfo {
  const factory _PieceInfo(
      {@JsonKey(name: 'detail_piece_id') required final int detailPieceId,
      @JsonKey(name: 'partenaire_id') required final int partenaireId,
      @JsonKey(name: 'piece_id') required final int pieceId,
      @JsonKey(name: 'marque_id') required final int marqueId,
      @JsonKey(name: 'type_engin_id') required final int typeEnginId,
      @JsonKey(name: 'modele_piece') required final String modelePiece,
      @JsonKey(name: 'numero_piece') required final String numeroPiece,
      @JsonKey(name: 'annee_piece') required final String anneePiece,
      @JsonKey(name: 'prix_piece') required final int prixPiece,
      @JsonKey(name: 'garantie') required final int garantie,
      @JsonKey(name: 'autres') final String? autres,
      @JsonKey(name: 'image_piece') required final String imagePiece,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'updated_at') required final DateTime updatedAt,
      @JsonKey(name: 'piece') required final Piece piece,
      @JsonKey(name: 'marque') required final Make marque,
      @JsonKey(name: 'type_engin') required final EnginType typeEngin,
      @JsonKey(name: 'autos') final List<AutoDisponibility>? autos,
      @JsonKey(name: 'moteurs') final List<MotorDisponibility>? moteurs,
      @JsonKey(name: 'categories')
      final List<CategoryDisponibility>? categories}) = _$PieceInfoImpl;

  factory _PieceInfo.fromJson(Map<String, dynamic> json) =
      _$PieceInfoImpl.fromJson;

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
  @JsonKey(name: 'type_engin_id')
  int get typeEnginId;
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
  @JsonKey(name: 'prix_piece')
  int get prixPiece;
  @override
  @JsonKey(name: 'garantie')
  int get garantie;
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
  @JsonKey(name: 'type_engin')
  EnginType get typeEngin;
  @override
  @JsonKey(name: 'autos')
  List<AutoDisponibility>? get autos;
  @override
  @JsonKey(name: 'moteurs')
  List<MotorDisponibility>? get moteurs;
  @override
  @JsonKey(name: 'categories')
  List<CategoryDisponibility>? get categories;
  @override
  @JsonKey(ignore: true)
  _$$PieceInfoImplCopyWith<_$PieceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
