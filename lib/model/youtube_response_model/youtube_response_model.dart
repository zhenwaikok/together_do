import 'package:freezed_annotation/freezed_annotation.dart';

part 'youtube_response_model.freezed.dart';
part 'youtube_response_model.g.dart';

@freezed
class YoutubeResponseModel with _$YoutubeResponseModel {
  const factory YoutubeResponseModel({
    String? nextPageToken,
    List<YoutubeItem>? items,
  }) = _YoutubeResponseModel;

  factory YoutubeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$YoutubeResponseModelFromJson(json);
}

@freezed
class YoutubeItem with _$YoutubeItem {
  const factory YoutubeItem({YoutubeId? id, YoutubeSnippet? snippet}) =
      _YoutubeItem;

  factory YoutubeItem.fromJson(Map<String, dynamic> json) =>
      _$YoutubeItemFromJson(json);
}

@freezed
class YoutubeId with _$YoutubeId {
  const factory YoutubeId({String? videoId}) = _YoutubeId;

  factory YoutubeId.fromJson(Map<String, dynamic> json) =>
      _$YoutubeIdFromJson(json);
}

@freezed
class YoutubeSnippet with _$YoutubeSnippet {
  const factory YoutubeSnippet({
    String? title,
    String? description,
    DateTime? publishedAt,
    YoutubeThumbnails? thumbnails,
  }) = _YoutubeSnippet;

  factory YoutubeSnippet.fromJson(Map<String, dynamic> json) =>
      _$YoutubeSnippetFromJson(json);
}

@freezed
class YoutubeThumbnails with _$YoutubeThumbnails {
  const factory YoutubeThumbnails({
    YoutubeThumbnail? medium,
    YoutubeThumbnail? high,
  }) = _YoutubeThumbnails;

  factory YoutubeThumbnails.fromJson(Map<String, dynamic> json) =>
      _$YoutubeThumbnailsFromJson(json);
}

@freezed
class YoutubeThumbnail with _$YoutubeThumbnail {
  const factory YoutubeThumbnail({String? url, int? width, int? height}) =
      _YoutubeThumbnail;

  factory YoutubeThumbnail.fromJson(Map<String, dynamic> json) =>
      _$YoutubeThumbnailFromJson(json);
}
