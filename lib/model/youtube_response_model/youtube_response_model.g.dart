// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'youtube_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$YoutubeResponseModelImpl _$$YoutubeResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$YoutubeResponseModelImpl(
  nextPageToken: json['nextPageToken'] as String?,
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => YoutubeItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$YoutubeResponseModelImplToJson(
  _$YoutubeResponseModelImpl instance,
) => <String, dynamic>{
  'nextPageToken': instance.nextPageToken,
  'items': instance.items,
};

_$YoutubeItemImpl _$$YoutubeItemImplFromJson(Map<String, dynamic> json) =>
    _$YoutubeItemImpl(
      id: json['id'] == null
          ? null
          : YoutubeId.fromJson(json['id'] as Map<String, dynamic>),
      snippet: json['snippet'] == null
          ? null
          : YoutubeSnippet.fromJson(json['snippet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$YoutubeItemImplToJson(_$YoutubeItemImpl instance) =>
    <String, dynamic>{'id': instance.id, 'snippet': instance.snippet};

_$YoutubeIdImpl _$$YoutubeIdImplFromJson(Map<String, dynamic> json) =>
    _$YoutubeIdImpl(videoId: json['videoId'] as String?);

Map<String, dynamic> _$$YoutubeIdImplToJson(_$YoutubeIdImpl instance) =>
    <String, dynamic>{'videoId': instance.videoId};

_$YoutubeSnippetImpl _$$YoutubeSnippetImplFromJson(Map<String, dynamic> json) =>
    _$YoutubeSnippetImpl(
      title: json['title'] as String?,
      description: json['description'] as String?,
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      thumbnails: json['thumbnails'] == null
          ? null
          : YoutubeThumbnails.fromJson(
              json['thumbnails'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$$YoutubeSnippetImplToJson(
  _$YoutubeSnippetImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'publishedAt': instance.publishedAt?.toIso8601String(),
  'thumbnails': instance.thumbnails,
};

_$YoutubeThumbnailsImpl _$$YoutubeThumbnailsImplFromJson(
  Map<String, dynamic> json,
) => _$YoutubeThumbnailsImpl(
  medium: json['medium'] == null
      ? null
      : YoutubeThumbnail.fromJson(json['medium'] as Map<String, dynamic>),
  high: json['high'] == null
      ? null
      : YoutubeThumbnail.fromJson(json['high'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$YoutubeThumbnailsImplToJson(
  _$YoutubeThumbnailsImpl instance,
) => <String, dynamic>{'medium': instance.medium, 'high': instance.high};

_$YoutubeThumbnailImpl _$$YoutubeThumbnailImplFromJson(
  Map<String, dynamic> json,
) => _$YoutubeThumbnailImpl(
  url: json['url'] as String?,
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
);

Map<String, dynamic> _$$YoutubeThumbnailImplToJson(
  _$YoutubeThumbnailImpl instance,
) => <String, dynamic>{
  'url': instance.url,
  'width': instance.width,
  'height': instance.height,
};
