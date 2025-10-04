// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'youtube_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

YoutubeResponseModel _$YoutubeResponseModelFromJson(Map<String, dynamic> json) {
  return _YoutubeResponseModel.fromJson(json);
}

/// @nodoc
mixin _$YoutubeResponseModel {
  String? get nextPageToken => throw _privateConstructorUsedError;
  List<YoutubeItem>? get items => throw _privateConstructorUsedError;

  /// Serializes this YoutubeResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YoutubeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YoutubeResponseModelCopyWith<YoutubeResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YoutubeResponseModelCopyWith<$Res> {
  factory $YoutubeResponseModelCopyWith(
    YoutubeResponseModel value,
    $Res Function(YoutubeResponseModel) then,
  ) = _$YoutubeResponseModelCopyWithImpl<$Res, YoutubeResponseModel>;
  @useResult
  $Res call({String? nextPageToken, List<YoutubeItem>? items});
}

/// @nodoc
class _$YoutubeResponseModelCopyWithImpl<
  $Res,
  $Val extends YoutubeResponseModel
>
    implements $YoutubeResponseModelCopyWith<$Res> {
  _$YoutubeResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YoutubeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? nextPageToken = freezed, Object? items = freezed}) {
    return _then(
      _value.copyWith(
            nextPageToken: freezed == nextPageToken
                ? _value.nextPageToken
                : nextPageToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            items: freezed == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<YoutubeItem>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$YoutubeResponseModelImplCopyWith<$Res>
    implements $YoutubeResponseModelCopyWith<$Res> {
  factory _$$YoutubeResponseModelImplCopyWith(
    _$YoutubeResponseModelImpl value,
    $Res Function(_$YoutubeResponseModelImpl) then,
  ) = __$$YoutubeResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? nextPageToken, List<YoutubeItem>? items});
}

/// @nodoc
class __$$YoutubeResponseModelImplCopyWithImpl<$Res>
    extends _$YoutubeResponseModelCopyWithImpl<$Res, _$YoutubeResponseModelImpl>
    implements _$$YoutubeResponseModelImplCopyWith<$Res> {
  __$$YoutubeResponseModelImplCopyWithImpl(
    _$YoutubeResponseModelImpl _value,
    $Res Function(_$YoutubeResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of YoutubeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? nextPageToken = freezed, Object? items = freezed}) {
    return _then(
      _$YoutubeResponseModelImpl(
        nextPageToken: freezed == nextPageToken
            ? _value.nextPageToken
            : nextPageToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        items: freezed == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<YoutubeItem>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$YoutubeResponseModelImpl implements _YoutubeResponseModel {
  const _$YoutubeResponseModelImpl({
    this.nextPageToken,
    final List<YoutubeItem>? items,
  }) : _items = items;

  factory _$YoutubeResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$YoutubeResponseModelImplFromJson(json);

  @override
  final String? nextPageToken;
  final List<YoutubeItem>? _items;
  @override
  List<YoutubeItem>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'YoutubeResponseModel(nextPageToken: $nextPageToken, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YoutubeResponseModelImpl &&
            (identical(other.nextPageToken, nextPageToken) ||
                other.nextPageToken == nextPageToken) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    nextPageToken,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of YoutubeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YoutubeResponseModelImplCopyWith<_$YoutubeResponseModelImpl>
  get copyWith =>
      __$$YoutubeResponseModelImplCopyWithImpl<_$YoutubeResponseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$YoutubeResponseModelImplToJson(this);
  }
}

abstract class _YoutubeResponseModel implements YoutubeResponseModel {
  const factory _YoutubeResponseModel({
    final String? nextPageToken,
    final List<YoutubeItem>? items,
  }) = _$YoutubeResponseModelImpl;

  factory _YoutubeResponseModel.fromJson(Map<String, dynamic> json) =
      _$YoutubeResponseModelImpl.fromJson;

  @override
  String? get nextPageToken;
  @override
  List<YoutubeItem>? get items;

  /// Create a copy of YoutubeResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YoutubeResponseModelImplCopyWith<_$YoutubeResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

YoutubeItem _$YoutubeItemFromJson(Map<String, dynamic> json) {
  return _YoutubeItem.fromJson(json);
}

/// @nodoc
mixin _$YoutubeItem {
  YoutubeId? get id => throw _privateConstructorUsedError;
  YoutubeSnippet? get snippet => throw _privateConstructorUsedError;

  /// Serializes this YoutubeItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YoutubeItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YoutubeItemCopyWith<YoutubeItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YoutubeItemCopyWith<$Res> {
  factory $YoutubeItemCopyWith(
    YoutubeItem value,
    $Res Function(YoutubeItem) then,
  ) = _$YoutubeItemCopyWithImpl<$Res, YoutubeItem>;
  @useResult
  $Res call({YoutubeId? id, YoutubeSnippet? snippet});

  $YoutubeIdCopyWith<$Res>? get id;
  $YoutubeSnippetCopyWith<$Res>? get snippet;
}

/// @nodoc
class _$YoutubeItemCopyWithImpl<$Res, $Val extends YoutubeItem>
    implements $YoutubeItemCopyWith<$Res> {
  _$YoutubeItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YoutubeItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = freezed, Object? snippet = freezed}) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as YoutubeId?,
            snippet: freezed == snippet
                ? _value.snippet
                : snippet // ignore: cast_nullable_to_non_nullable
                      as YoutubeSnippet?,
          )
          as $Val,
    );
  }

  /// Create a copy of YoutubeItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $YoutubeIdCopyWith<$Res>? get id {
    if (_value.id == null) {
      return null;
    }

    return $YoutubeIdCopyWith<$Res>(_value.id!, (value) {
      return _then(_value.copyWith(id: value) as $Val);
    });
  }

  /// Create a copy of YoutubeItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $YoutubeSnippetCopyWith<$Res>? get snippet {
    if (_value.snippet == null) {
      return null;
    }

    return $YoutubeSnippetCopyWith<$Res>(_value.snippet!, (value) {
      return _then(_value.copyWith(snippet: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$YoutubeItemImplCopyWith<$Res>
    implements $YoutubeItemCopyWith<$Res> {
  factory _$$YoutubeItemImplCopyWith(
    _$YoutubeItemImpl value,
    $Res Function(_$YoutubeItemImpl) then,
  ) = __$$YoutubeItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({YoutubeId? id, YoutubeSnippet? snippet});

  @override
  $YoutubeIdCopyWith<$Res>? get id;
  @override
  $YoutubeSnippetCopyWith<$Res>? get snippet;
}

/// @nodoc
class __$$YoutubeItemImplCopyWithImpl<$Res>
    extends _$YoutubeItemCopyWithImpl<$Res, _$YoutubeItemImpl>
    implements _$$YoutubeItemImplCopyWith<$Res> {
  __$$YoutubeItemImplCopyWithImpl(
    _$YoutubeItemImpl _value,
    $Res Function(_$YoutubeItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of YoutubeItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = freezed, Object? snippet = freezed}) {
    return _then(
      _$YoutubeItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as YoutubeId?,
        snippet: freezed == snippet
            ? _value.snippet
            : snippet // ignore: cast_nullable_to_non_nullable
                  as YoutubeSnippet?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$YoutubeItemImpl implements _YoutubeItem {
  const _$YoutubeItemImpl({this.id, this.snippet});

  factory _$YoutubeItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$YoutubeItemImplFromJson(json);

  @override
  final YoutubeId? id;
  @override
  final YoutubeSnippet? snippet;

  @override
  String toString() {
    return 'YoutubeItem(id: $id, snippet: $snippet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YoutubeItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.snippet, snippet) || other.snippet == snippet));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, snippet);

  /// Create a copy of YoutubeItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YoutubeItemImplCopyWith<_$YoutubeItemImpl> get copyWith =>
      __$$YoutubeItemImplCopyWithImpl<_$YoutubeItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$YoutubeItemImplToJson(this);
  }
}

abstract class _YoutubeItem implements YoutubeItem {
  const factory _YoutubeItem({
    final YoutubeId? id,
    final YoutubeSnippet? snippet,
  }) = _$YoutubeItemImpl;

  factory _YoutubeItem.fromJson(Map<String, dynamic> json) =
      _$YoutubeItemImpl.fromJson;

  @override
  YoutubeId? get id;
  @override
  YoutubeSnippet? get snippet;

  /// Create a copy of YoutubeItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YoutubeItemImplCopyWith<_$YoutubeItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

YoutubeId _$YoutubeIdFromJson(Map<String, dynamic> json) {
  return _YoutubeId.fromJson(json);
}

/// @nodoc
mixin _$YoutubeId {
  String? get videoId => throw _privateConstructorUsedError;

  /// Serializes this YoutubeId to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YoutubeId
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YoutubeIdCopyWith<YoutubeId> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YoutubeIdCopyWith<$Res> {
  factory $YoutubeIdCopyWith(YoutubeId value, $Res Function(YoutubeId) then) =
      _$YoutubeIdCopyWithImpl<$Res, YoutubeId>;
  @useResult
  $Res call({String? videoId});
}

/// @nodoc
class _$YoutubeIdCopyWithImpl<$Res, $Val extends YoutubeId>
    implements $YoutubeIdCopyWith<$Res> {
  _$YoutubeIdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YoutubeId
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? videoId = freezed}) {
    return _then(
      _value.copyWith(
            videoId: freezed == videoId
                ? _value.videoId
                : videoId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$YoutubeIdImplCopyWith<$Res>
    implements $YoutubeIdCopyWith<$Res> {
  factory _$$YoutubeIdImplCopyWith(
    _$YoutubeIdImpl value,
    $Res Function(_$YoutubeIdImpl) then,
  ) = __$$YoutubeIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? videoId});
}

/// @nodoc
class __$$YoutubeIdImplCopyWithImpl<$Res>
    extends _$YoutubeIdCopyWithImpl<$Res, _$YoutubeIdImpl>
    implements _$$YoutubeIdImplCopyWith<$Res> {
  __$$YoutubeIdImplCopyWithImpl(
    _$YoutubeIdImpl _value,
    $Res Function(_$YoutubeIdImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of YoutubeId
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? videoId = freezed}) {
    return _then(
      _$YoutubeIdImpl(
        videoId: freezed == videoId
            ? _value.videoId
            : videoId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$YoutubeIdImpl implements _YoutubeId {
  const _$YoutubeIdImpl({this.videoId});

  factory _$YoutubeIdImpl.fromJson(Map<String, dynamic> json) =>
      _$$YoutubeIdImplFromJson(json);

  @override
  final String? videoId;

  @override
  String toString() {
    return 'YoutubeId(videoId: $videoId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YoutubeIdImpl &&
            (identical(other.videoId, videoId) || other.videoId == videoId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, videoId);

  /// Create a copy of YoutubeId
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YoutubeIdImplCopyWith<_$YoutubeIdImpl> get copyWith =>
      __$$YoutubeIdImplCopyWithImpl<_$YoutubeIdImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$YoutubeIdImplToJson(this);
  }
}

abstract class _YoutubeId implements YoutubeId {
  const factory _YoutubeId({final String? videoId}) = _$YoutubeIdImpl;

  factory _YoutubeId.fromJson(Map<String, dynamic> json) =
      _$YoutubeIdImpl.fromJson;

  @override
  String? get videoId;

  /// Create a copy of YoutubeId
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YoutubeIdImplCopyWith<_$YoutubeIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

YoutubeSnippet _$YoutubeSnippetFromJson(Map<String, dynamic> json) {
  return _YoutubeSnippet.fromJson(json);
}

/// @nodoc
mixin _$YoutubeSnippet {
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get publishedAt => throw _privateConstructorUsedError;
  YoutubeThumbnails? get thumbnails => throw _privateConstructorUsedError;

  /// Serializes this YoutubeSnippet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YoutubeSnippet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YoutubeSnippetCopyWith<YoutubeSnippet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YoutubeSnippetCopyWith<$Res> {
  factory $YoutubeSnippetCopyWith(
    YoutubeSnippet value,
    $Res Function(YoutubeSnippet) then,
  ) = _$YoutubeSnippetCopyWithImpl<$Res, YoutubeSnippet>;
  @useResult
  $Res call({
    String? title,
    String? description,
    DateTime? publishedAt,
    YoutubeThumbnails? thumbnails,
  });

  $YoutubeThumbnailsCopyWith<$Res>? get thumbnails;
}

/// @nodoc
class _$YoutubeSnippetCopyWithImpl<$Res, $Val extends YoutubeSnippet>
    implements $YoutubeSnippetCopyWith<$Res> {
  _$YoutubeSnippetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YoutubeSnippet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? publishedAt = freezed,
    Object? thumbnails = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            publishedAt: freezed == publishedAt
                ? _value.publishedAt
                : publishedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            thumbnails: freezed == thumbnails
                ? _value.thumbnails
                : thumbnails // ignore: cast_nullable_to_non_nullable
                      as YoutubeThumbnails?,
          )
          as $Val,
    );
  }

  /// Create a copy of YoutubeSnippet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $YoutubeThumbnailsCopyWith<$Res>? get thumbnails {
    if (_value.thumbnails == null) {
      return null;
    }

    return $YoutubeThumbnailsCopyWith<$Res>(_value.thumbnails!, (value) {
      return _then(_value.copyWith(thumbnails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$YoutubeSnippetImplCopyWith<$Res>
    implements $YoutubeSnippetCopyWith<$Res> {
  factory _$$YoutubeSnippetImplCopyWith(
    _$YoutubeSnippetImpl value,
    $Res Function(_$YoutubeSnippetImpl) then,
  ) = __$$YoutubeSnippetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? title,
    String? description,
    DateTime? publishedAt,
    YoutubeThumbnails? thumbnails,
  });

  @override
  $YoutubeThumbnailsCopyWith<$Res>? get thumbnails;
}

/// @nodoc
class __$$YoutubeSnippetImplCopyWithImpl<$Res>
    extends _$YoutubeSnippetCopyWithImpl<$Res, _$YoutubeSnippetImpl>
    implements _$$YoutubeSnippetImplCopyWith<$Res> {
  __$$YoutubeSnippetImplCopyWithImpl(
    _$YoutubeSnippetImpl _value,
    $Res Function(_$YoutubeSnippetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of YoutubeSnippet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? publishedAt = freezed,
    Object? thumbnails = freezed,
  }) {
    return _then(
      _$YoutubeSnippetImpl(
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        publishedAt: freezed == publishedAt
            ? _value.publishedAt
            : publishedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        thumbnails: freezed == thumbnails
            ? _value.thumbnails
            : thumbnails // ignore: cast_nullable_to_non_nullable
                  as YoutubeThumbnails?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$YoutubeSnippetImpl implements _YoutubeSnippet {
  const _$YoutubeSnippetImpl({
    this.title,
    this.description,
    this.publishedAt,
    this.thumbnails,
  });

  factory _$YoutubeSnippetImpl.fromJson(Map<String, dynamic> json) =>
      _$$YoutubeSnippetImplFromJson(json);

  @override
  final String? title;
  @override
  final String? description;
  @override
  final DateTime? publishedAt;
  @override
  final YoutubeThumbnails? thumbnails;

  @override
  String toString() {
    return 'YoutubeSnippet(title: $title, description: $description, publishedAt: $publishedAt, thumbnails: $thumbnails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YoutubeSnippetImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.thumbnails, thumbnails) ||
                other.thumbnails == thumbnails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, description, publishedAt, thumbnails);

  /// Create a copy of YoutubeSnippet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YoutubeSnippetImplCopyWith<_$YoutubeSnippetImpl> get copyWith =>
      __$$YoutubeSnippetImplCopyWithImpl<_$YoutubeSnippetImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$YoutubeSnippetImplToJson(this);
  }
}

abstract class _YoutubeSnippet implements YoutubeSnippet {
  const factory _YoutubeSnippet({
    final String? title,
    final String? description,
    final DateTime? publishedAt,
    final YoutubeThumbnails? thumbnails,
  }) = _$YoutubeSnippetImpl;

  factory _YoutubeSnippet.fromJson(Map<String, dynamic> json) =
      _$YoutubeSnippetImpl.fromJson;

  @override
  String? get title;
  @override
  String? get description;
  @override
  DateTime? get publishedAt;
  @override
  YoutubeThumbnails? get thumbnails;

  /// Create a copy of YoutubeSnippet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YoutubeSnippetImplCopyWith<_$YoutubeSnippetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

YoutubeThumbnails _$YoutubeThumbnailsFromJson(Map<String, dynamic> json) {
  return _YoutubeThumbnails.fromJson(json);
}

/// @nodoc
mixin _$YoutubeThumbnails {
  YoutubeThumbnail? get medium => throw _privateConstructorUsedError;
  YoutubeThumbnail? get high => throw _privateConstructorUsedError;

  /// Serializes this YoutubeThumbnails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YoutubeThumbnails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YoutubeThumbnailsCopyWith<YoutubeThumbnails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YoutubeThumbnailsCopyWith<$Res> {
  factory $YoutubeThumbnailsCopyWith(
    YoutubeThumbnails value,
    $Res Function(YoutubeThumbnails) then,
  ) = _$YoutubeThumbnailsCopyWithImpl<$Res, YoutubeThumbnails>;
  @useResult
  $Res call({YoutubeThumbnail? medium, YoutubeThumbnail? high});

  $YoutubeThumbnailCopyWith<$Res>? get medium;
  $YoutubeThumbnailCopyWith<$Res>? get high;
}

/// @nodoc
class _$YoutubeThumbnailsCopyWithImpl<$Res, $Val extends YoutubeThumbnails>
    implements $YoutubeThumbnailsCopyWith<$Res> {
  _$YoutubeThumbnailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YoutubeThumbnails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? medium = freezed, Object? high = freezed}) {
    return _then(
      _value.copyWith(
            medium: freezed == medium
                ? _value.medium
                : medium // ignore: cast_nullable_to_non_nullable
                      as YoutubeThumbnail?,
            high: freezed == high
                ? _value.high
                : high // ignore: cast_nullable_to_non_nullable
                      as YoutubeThumbnail?,
          )
          as $Val,
    );
  }

  /// Create a copy of YoutubeThumbnails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $YoutubeThumbnailCopyWith<$Res>? get medium {
    if (_value.medium == null) {
      return null;
    }

    return $YoutubeThumbnailCopyWith<$Res>(_value.medium!, (value) {
      return _then(_value.copyWith(medium: value) as $Val);
    });
  }

  /// Create a copy of YoutubeThumbnails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $YoutubeThumbnailCopyWith<$Res>? get high {
    if (_value.high == null) {
      return null;
    }

    return $YoutubeThumbnailCopyWith<$Res>(_value.high!, (value) {
      return _then(_value.copyWith(high: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$YoutubeThumbnailsImplCopyWith<$Res>
    implements $YoutubeThumbnailsCopyWith<$Res> {
  factory _$$YoutubeThumbnailsImplCopyWith(
    _$YoutubeThumbnailsImpl value,
    $Res Function(_$YoutubeThumbnailsImpl) then,
  ) = __$$YoutubeThumbnailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({YoutubeThumbnail? medium, YoutubeThumbnail? high});

  @override
  $YoutubeThumbnailCopyWith<$Res>? get medium;
  @override
  $YoutubeThumbnailCopyWith<$Res>? get high;
}

/// @nodoc
class __$$YoutubeThumbnailsImplCopyWithImpl<$Res>
    extends _$YoutubeThumbnailsCopyWithImpl<$Res, _$YoutubeThumbnailsImpl>
    implements _$$YoutubeThumbnailsImplCopyWith<$Res> {
  __$$YoutubeThumbnailsImplCopyWithImpl(
    _$YoutubeThumbnailsImpl _value,
    $Res Function(_$YoutubeThumbnailsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of YoutubeThumbnails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? medium = freezed, Object? high = freezed}) {
    return _then(
      _$YoutubeThumbnailsImpl(
        medium: freezed == medium
            ? _value.medium
            : medium // ignore: cast_nullable_to_non_nullable
                  as YoutubeThumbnail?,
        high: freezed == high
            ? _value.high
            : high // ignore: cast_nullable_to_non_nullable
                  as YoutubeThumbnail?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$YoutubeThumbnailsImpl implements _YoutubeThumbnails {
  const _$YoutubeThumbnailsImpl({this.medium, this.high});

  factory _$YoutubeThumbnailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$YoutubeThumbnailsImplFromJson(json);

  @override
  final YoutubeThumbnail? medium;
  @override
  final YoutubeThumbnail? high;

  @override
  String toString() {
    return 'YoutubeThumbnails(medium: $medium, high: $high)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YoutubeThumbnailsImpl &&
            (identical(other.medium, medium) || other.medium == medium) &&
            (identical(other.high, high) || other.high == high));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, medium, high);

  /// Create a copy of YoutubeThumbnails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YoutubeThumbnailsImplCopyWith<_$YoutubeThumbnailsImpl> get copyWith =>
      __$$YoutubeThumbnailsImplCopyWithImpl<_$YoutubeThumbnailsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$YoutubeThumbnailsImplToJson(this);
  }
}

abstract class _YoutubeThumbnails implements YoutubeThumbnails {
  const factory _YoutubeThumbnails({
    final YoutubeThumbnail? medium,
    final YoutubeThumbnail? high,
  }) = _$YoutubeThumbnailsImpl;

  factory _YoutubeThumbnails.fromJson(Map<String, dynamic> json) =
      _$YoutubeThumbnailsImpl.fromJson;

  @override
  YoutubeThumbnail? get medium;
  @override
  YoutubeThumbnail? get high;

  /// Create a copy of YoutubeThumbnails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YoutubeThumbnailsImplCopyWith<_$YoutubeThumbnailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

YoutubeThumbnail _$YoutubeThumbnailFromJson(Map<String, dynamic> json) {
  return _YoutubeThumbnail.fromJson(json);
}

/// @nodoc
mixin _$YoutubeThumbnail {
  String? get url => throw _privateConstructorUsedError;
  int? get width => throw _privateConstructorUsedError;
  int? get height => throw _privateConstructorUsedError;

  /// Serializes this YoutubeThumbnail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YoutubeThumbnail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YoutubeThumbnailCopyWith<YoutubeThumbnail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YoutubeThumbnailCopyWith<$Res> {
  factory $YoutubeThumbnailCopyWith(
    YoutubeThumbnail value,
    $Res Function(YoutubeThumbnail) then,
  ) = _$YoutubeThumbnailCopyWithImpl<$Res, YoutubeThumbnail>;
  @useResult
  $Res call({String? url, int? width, int? height});
}

/// @nodoc
class _$YoutubeThumbnailCopyWithImpl<$Res, $Val extends YoutubeThumbnail>
    implements $YoutubeThumbnailCopyWith<$Res> {
  _$YoutubeThumbnailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YoutubeThumbnail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(
      _value.copyWith(
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
            width: freezed == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as int?,
            height: freezed == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$YoutubeThumbnailImplCopyWith<$Res>
    implements $YoutubeThumbnailCopyWith<$Res> {
  factory _$$YoutubeThumbnailImplCopyWith(
    _$YoutubeThumbnailImpl value,
    $Res Function(_$YoutubeThumbnailImpl) then,
  ) = __$$YoutubeThumbnailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url, int? width, int? height});
}

/// @nodoc
class __$$YoutubeThumbnailImplCopyWithImpl<$Res>
    extends _$YoutubeThumbnailCopyWithImpl<$Res, _$YoutubeThumbnailImpl>
    implements _$$YoutubeThumbnailImplCopyWith<$Res> {
  __$$YoutubeThumbnailImplCopyWithImpl(
    _$YoutubeThumbnailImpl _value,
    $Res Function(_$YoutubeThumbnailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of YoutubeThumbnail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(
      _$YoutubeThumbnailImpl(
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
        width: freezed == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int?,
        height: freezed == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$YoutubeThumbnailImpl implements _YoutubeThumbnail {
  const _$YoutubeThumbnailImpl({this.url, this.width, this.height});

  factory _$YoutubeThumbnailImpl.fromJson(Map<String, dynamic> json) =>
      _$$YoutubeThumbnailImplFromJson(json);

  @override
  final String? url;
  @override
  final int? width;
  @override
  final int? height;

  @override
  String toString() {
    return 'YoutubeThumbnail(url: $url, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YoutubeThumbnailImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, width, height);

  /// Create a copy of YoutubeThumbnail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YoutubeThumbnailImplCopyWith<_$YoutubeThumbnailImpl> get copyWith =>
      __$$YoutubeThumbnailImplCopyWithImpl<_$YoutubeThumbnailImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$YoutubeThumbnailImplToJson(this);
  }
}

abstract class _YoutubeThumbnail implements YoutubeThumbnail {
  const factory _YoutubeThumbnail({
    final String? url,
    final int? width,
    final int? height,
  }) = _$YoutubeThumbnailImpl;

  factory _YoutubeThumbnail.fromJson(Map<String, dynamic> json) =
      _$YoutubeThumbnailImpl.fromJson;

  @override
  String? get url;
  @override
  int? get width;
  @override
  int? get height;

  /// Create a copy of YoutubeThumbnail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YoutubeThumbnailImplCopyWith<_$YoutubeThumbnailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
