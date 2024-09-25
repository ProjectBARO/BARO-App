//
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'nickname', '3': 3, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'fcm_token', '3': 4, '4': 1, '5': 9, '10': 'fcmToken'},
    {'1': 'email', '3': 5, '4': 1, '5': 9, '10': 'email'},
    {'1': 'age', '3': 6, '4': 1, '5': 5, '10': 'age'},
    {'1': 'gender', '3': 7, '4': 1, '5': 9, '10': 'gender'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgEUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhoKCG5pY2tuYW1lGA'
    'MgASgJUghuaWNrbmFtZRIbCglmY21fdG9rZW4YBCABKAlSCGZjbVRva2VuEhQKBWVtYWlsGAUg'
    'ASgJUgVlbWFpbBIQCgNhZ2UYBiABKAVSA2FnZRIWCgZnZW5kZXIYByABKAlSBmdlbmRlcg==');

@$core.Deprecated('Use requestCreateUserDescriptor instead')
const RequestCreateUser$json = {
  '1': 'RequestCreateUser',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'fcm_token', '3': 2, '4': 1, '5': 9, '10': 'fcmToken'},
    {'1': 'email', '3': 3, '4': 1, '5': 9, '10': 'email'},
    {'1': 'age', '3': 4, '4': 1, '5': 5, '10': 'age'},
    {'1': 'gender', '3': 5, '4': 1, '5': 9, '10': 'gender'},
  ],
};

/// Descriptor for `RequestCreateUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestCreateUserDescriptor = $convert.base64Decode(
    'ChFSZXF1ZXN0Q3JlYXRlVXNlchISCgRuYW1lGAEgASgJUgRuYW1lEhsKCWZjbV90b2tlbhgCIA'
    'EoCVIIZmNtVG9rZW4SFAoFZW1haWwYAyABKAlSBWVtYWlsEhAKA2FnZRgEIAEoBVIDYWdlEhYK'
    'BmdlbmRlchgFIAEoCVIGZ2VuZGVy');

@$core.Deprecated('Use responseTokenDescriptor instead')
const ResponseToken$json = {
  '1': 'ResponseToken',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `ResponseToken`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseTokenDescriptor = $convert.base64Decode(
    'Cg1SZXNwb25zZVRva2VuEhQKBXRva2VuGAEgASgJUgV0b2tlbg==');

@$core.Deprecated('Use responseUserDescriptor instead')
const ResponseUser$json = {
  '1': 'ResponseUser',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'nickname', '3': 3, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'email', '3': 4, '4': 1, '5': 9, '10': 'email'},
    {'1': 'age', '3': 5, '4': 1, '5': 5, '10': 'age'},
    {'1': 'gender', '3': 6, '4': 1, '5': 9, '10': 'gender'},
  ],
};

/// Descriptor for `ResponseUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseUserDescriptor = $convert.base64Decode(
    'CgxSZXNwb25zZVVzZXISDgoCaWQYASABKARSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSGgoIbm'
    'lja25hbWUYAyABKAlSCG5pY2tuYW1lEhQKBWVtYWlsGAQgASgJUgVlbWFpbBIQCgNhZ2UYBSAB'
    'KAVSA2FnZRIWCgZnZW5kZXIYBiABKAlSBmdlbmRlcg==');

@$core.Deprecated('Use requestUpdateUserDescriptor instead')
const RequestUpdateUser$json = {
  '1': 'RequestUpdateUser',
  '2': [
    {'1': 'nickname', '3': 1, '4': 1, '5': 9, '10': 'nickname'},
    {'1': 'age', '3': 2, '4': 1, '5': 5, '10': 'age'},
    {'1': 'gender', '3': 3, '4': 1, '5': 9, '10': 'gender'},
  ],
};

/// Descriptor for `RequestUpdateUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestUpdateUserDescriptor = $convert.base64Decode(
    'ChFSZXF1ZXN0VXBkYXRlVXNlchIaCghuaWNrbmFtZRgBIAEoCVIIbmlja25hbWUSEAoDYWdlGA'
    'IgASgFUgNhZ2USFgoGZ2VuZGVyGAMgASgJUgZnZW5kZXI=');

@$core.Deprecated('Use requestUpdateFcmTokenDescriptor instead')
const RequestUpdateFcmToken$json = {
  '1': 'RequestUpdateFcmToken',
  '2': [
    {'1': 'fcm_token', '3': 1, '4': 1, '5': 9, '10': 'fcmToken'},
  ],
};

/// Descriptor for `RequestUpdateFcmToken`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestUpdateFcmTokenDescriptor = $convert.base64Decode(
    'ChVSZXF1ZXN0VXBkYXRlRmNtVG9rZW4SGwoJZmNtX3Rva2VuGAEgASgJUghmY21Ub2tlbg==');

@$core.Deprecated('Use responseUpdateFcmTokenDescriptor instead')
const ResponseUpdateFcmToken$json = {
  '1': 'ResponseUpdateFcmToken',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResponseUpdateFcmToken`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseUpdateFcmTokenDescriptor = $convert.base64Decode(
    'ChZSZXNwb25zZVVwZGF0ZUZjbVRva2VuEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode(
    'CgVFbXB0eQ==');

