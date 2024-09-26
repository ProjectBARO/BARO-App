//
//  Generated code. Do not modify.
//  source: lib/service/video/video.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use videoMessageDescriptor instead')
const VideoMessage$json = {
  '1': 'VideoMessage',
  '2': [
    {'1': 'video_id', '3': 1, '4': 1, '5': 9, '10': 'videoId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'thumbnail_url', '3': 3, '4': 1, '5': 9, '10': 'thumbnailUrl'},
    {'1': 'category', '3': 4, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `VideoMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoMessageDescriptor = $convert.base64Decode(
    'CgxWaWRlb01lc3NhZ2USGQoIdmlkZW9faWQYASABKAlSB3ZpZGVvSWQSFAoFdGl0bGUYAiABKA'
    'lSBXRpdGxlEiMKDXRodW1ibmFpbF91cmwYAyABKAlSDHRodW1ibmFpbFVybBIaCghjYXRlZ29y'
    'eRgEIAEoCVIIY2F0ZWdvcnk=');

@$core.Deprecated('Use getVideosRequestDescriptor instead')
const GetVideosRequest$json = {
  '1': 'GetVideosRequest',
};

/// Descriptor for `GetVideosRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVideosRequestDescriptor = $convert.base64Decode(
    'ChBHZXRWaWRlb3NSZXF1ZXN0');

@$core.Deprecated('Use getVideosByCategoryRequestDescriptor instead')
const GetVideosByCategoryRequest$json = {
  '1': 'GetVideosByCategoryRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '10': 'category'},
  ],
};

/// Descriptor for `GetVideosByCategoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getVideosByCategoryRequestDescriptor = $convert.base64Decode(
    'ChpHZXRWaWRlb3NCeUNhdGVnb3J5UmVxdWVzdBIaCghjYXRlZ29yeRgBIAEoCVIIY2F0ZWdvcn'
    'k=');

@$core.Deprecated('Use videosResponseDescriptor instead')
const VideosResponse$json = {
  '1': 'VideosResponse',
  '2': [
    {'1': 'videos', '3': 1, '4': 3, '5': 11, '6': '.video.VideoMessage', '10': 'videos'},
  ],
};

/// Descriptor for `VideosResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videosResponseDescriptor = $convert.base64Decode(
    'Cg5WaWRlb3NSZXNwb25zZRIrCgZ2aWRlb3MYASADKAsyEy52aWRlby5WaWRlb01lc3NhZ2VSBn'
    'ZpZGVvcw==');

