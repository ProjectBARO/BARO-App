//
//  Generated code. Do not modify.
//  source: lib/service/video/video.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'video.pb.dart' as $0;

export 'video.pb.dart';

@$pb.GrpcServiceName('video.VideoService')
class VideoServiceClient extends $grpc.Client {
  static final _$getVideos = $grpc.ClientMethod<$0.GetVideosRequest, $0.VideosResponse>(
      '/video.VideoService/GetVideos',
      ($0.GetVideosRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VideosResponse.fromBuffer(value));
  static final _$getVideosByCategory = $grpc.ClientMethod<$0.GetVideosByCategoryRequest, $0.VideosResponse>(
      '/video.VideoService/GetVideosByCategory',
      ($0.GetVideosByCategoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VideosResponse.fromBuffer(value));

  VideoServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.VideosResponse> getVideos($0.GetVideosRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVideos, request, options: options);
  }

  $grpc.ResponseFuture<$0.VideosResponse> getVideosByCategory($0.GetVideosByCategoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getVideosByCategory, request, options: options);
  }
}

@$pb.GrpcServiceName('video.VideoService')
abstract class VideoServiceBase extends $grpc.Service {
  $core.String get $name => 'video.VideoService';

  VideoServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetVideosRequest, $0.VideosResponse>(
        'GetVideos',
        getVideos_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetVideosRequest.fromBuffer(value),
        ($0.VideosResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetVideosByCategoryRequest, $0.VideosResponse>(
        'GetVideosByCategory',
        getVideosByCategory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetVideosByCategoryRequest.fromBuffer(value),
        ($0.VideosResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.VideosResponse> getVideos_Pre($grpc.ServiceCall call, $async.Future<$0.GetVideosRequest> request) async {
    return getVideos(call, await request);
  }

  $async.Future<$0.VideosResponse> getVideosByCategory_Pre($grpc.ServiceCall call, $async.Future<$0.GetVideosByCategoryRequest> request) async {
    return getVideosByCategory(call, await request);
  }

  $async.Future<$0.VideosResponse> getVideos($grpc.ServiceCall call, $0.GetVideosRequest request);
  $async.Future<$0.VideosResponse> getVideosByCategory($grpc.ServiceCall call, $0.GetVideosByCategoryRequest request);
}
