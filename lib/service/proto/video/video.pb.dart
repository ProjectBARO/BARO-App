//
//  Generated code. Do not modify.
//  source: lib/service/video/video.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class VideoMessage extends $pb.GeneratedMessage {
  factory VideoMessage({
    $core.String? videoId,
    $core.String? title,
    $core.String? thumbnailUrl,
    $core.String? category,
  }) {
    final $result = create();
    if (videoId != null) {
      $result.videoId = videoId;
    }
    if (title != null) {
      $result.title = title;
    }
    if (thumbnailUrl != null) {
      $result.thumbnailUrl = thumbnailUrl;
    }
    if (category != null) {
      $result.category = category;
    }
    return $result;
  }
  VideoMessage._() : super();
  factory VideoMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VideoMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'video'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'videoId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'thumbnailUrl')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideoMessage clone() => VideoMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideoMessage copyWith(void Function(VideoMessage) updates) => super.copyWith((message) => updates(message as VideoMessage)) as VideoMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoMessage create() => VideoMessage._();
  VideoMessage createEmptyInstance() => create();
  static $pb.PbList<VideoMessage> createRepeated() => $pb.PbList<VideoMessage>();
  @$core.pragma('dart2js:noInline')
  static VideoMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoMessage>(create);
  static VideoMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get videoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set videoId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVideoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVideoId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get thumbnailUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set thumbnailUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasThumbnailUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearThumbnailUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);
}

class GetVideosRequest extends $pb.GeneratedMessage {
  factory GetVideosRequest() => create();
  GetVideosRequest._() : super();
  factory GetVideosRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVideosRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetVideosRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'video'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVideosRequest clone() => GetVideosRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVideosRequest copyWith(void Function(GetVideosRequest) updates) => super.copyWith((message) => updates(message as GetVideosRequest)) as GetVideosRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVideosRequest create() => GetVideosRequest._();
  GetVideosRequest createEmptyInstance() => create();
  static $pb.PbList<GetVideosRequest> createRepeated() => $pb.PbList<GetVideosRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVideosRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVideosRequest>(create);
  static GetVideosRequest? _defaultInstance;
}

class GetVideosByCategoryRequest extends $pb.GeneratedMessage {
  factory GetVideosByCategoryRequest({
    $core.String? category,
  }) {
    final $result = create();
    if (category != null) {
      $result.category = category;
    }
    return $result;
  }
  GetVideosByCategoryRequest._() : super();
  factory GetVideosByCategoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetVideosByCategoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetVideosByCategoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'video'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetVideosByCategoryRequest clone() => GetVideosByCategoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetVideosByCategoryRequest copyWith(void Function(GetVideosByCategoryRequest) updates) => super.copyWith((message) => updates(message as GetVideosByCategoryRequest)) as GetVideosByCategoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetVideosByCategoryRequest create() => GetVideosByCategoryRequest._();
  GetVideosByCategoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetVideosByCategoryRequest> createRepeated() => $pb.PbList<GetVideosByCategoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetVideosByCategoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetVideosByCategoryRequest>(create);
  static GetVideosByCategoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);
}

class VideosResponse extends $pb.GeneratedMessage {
  factory VideosResponse({
    $core.Iterable<VideoMessage>? videos,
  }) {
    final $result = create();
    if (videos != null) {
      $result.videos.addAll(videos);
    }
    return $result;
  }
  VideosResponse._() : super();
  factory VideosResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideosResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VideosResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'video'), createEmptyInstance: create)
    ..pc<VideoMessage>(1, _omitFieldNames ? '' : 'videos', $pb.PbFieldType.PM, subBuilder: VideoMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideosResponse clone() => VideosResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideosResponse copyWith(void Function(VideosResponse) updates) => super.copyWith((message) => updates(message as VideosResponse)) as VideosResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideosResponse create() => VideosResponse._();
  VideosResponse createEmptyInstance() => create();
  static $pb.PbList<VideosResponse> createRepeated() => $pb.PbList<VideosResponse>();
  @$core.pragma('dart2js:noInline')
  static VideosResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideosResponse>(create);
  static VideosResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<VideoMessage> get videos => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
