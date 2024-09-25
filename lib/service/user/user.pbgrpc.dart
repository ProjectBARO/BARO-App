//
//  Generated code. Do not modify.
//  source: lib/service/user/user.proto
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

import 'user.pb.dart' as $0;

export 'user.pb.dart';

@$pb.GrpcServiceName('UserService')
class UserServiceClient extends $grpc.Client {
  static final _$login = $grpc.ClientMethod<$0.RequestCreateUser, $0.ResponseToken>(
      '/UserService/Login',
      ($0.RequestCreateUser value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseToken.fromBuffer(value));
  static final _$getUserInfo = $grpc.ClientMethod<$0.Empty, $0.ResponseUser>(
      '/UserService/GetUserInfo',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseUser.fromBuffer(value));
  static final _$updateUserInfo = $grpc.ClientMethod<$0.RequestUpdateUser, $0.ResponseUser>(
      '/UserService/UpdateUserInfo',
      ($0.RequestUpdateUser value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseUser.fromBuffer(value));
  static final _$deleteUser = $grpc.ClientMethod<$0.Empty, $0.Empty>(
      '/UserService/DeleteUser',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$updateFcmToken = $grpc.ClientMethod<$0.RequestUpdateFcmToken, $0.ResponseUpdateFcmToken>(
      '/UserService/UpdateFcmToken',
      ($0.RequestUpdateFcmToken value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseUpdateFcmToken.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.ResponseToken> login($0.RequestCreateUser request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$login, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseUser> getUserInfo($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseUser> updateUserInfo($0.RequestUpdateUser request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUserInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> deleteUser($0.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteUser, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseUpdateFcmToken> updateFcmToken($0.RequestUpdateFcmToken request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateFcmToken, request, options: options);
  }
}

@$pb.GrpcServiceName('UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RequestCreateUser, $0.ResponseToken>(
        'Login',
        login_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestCreateUser.fromBuffer(value),
        ($0.ResponseToken value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.ResponseUser>(
        'GetUserInfo',
        getUserInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.ResponseUser value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestUpdateUser, $0.ResponseUser>(
        'UpdateUserInfo',
        updateUserInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestUpdateUser.fromBuffer(value),
        ($0.ResponseUser value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Empty>(
        'DeleteUser',
        deleteUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestUpdateFcmToken, $0.ResponseUpdateFcmToken>(
        'UpdateFcmToken',
        updateFcmToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestUpdateFcmToken.fromBuffer(value),
        ($0.ResponseUpdateFcmToken value) => value.writeToBuffer()));
  }

  $async.Future<$0.ResponseToken> login_Pre($grpc.ServiceCall call, $async.Future<$0.RequestCreateUser> request) async {
    return login(call, await request);
  }

  $async.Future<$0.ResponseUser> getUserInfo_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getUserInfo(call, await request);
  }

  $async.Future<$0.ResponseUser> updateUserInfo_Pre($grpc.ServiceCall call, $async.Future<$0.RequestUpdateUser> request) async {
    return updateUserInfo(call, await request);
  }

  $async.Future<$0.Empty> deleteUser_Pre($grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return deleteUser(call, await request);
  }

  $async.Future<$0.ResponseUpdateFcmToken> updateFcmToken_Pre($grpc.ServiceCall call, $async.Future<$0.RequestUpdateFcmToken> request) async {
    return updateFcmToken(call, await request);
  }

  $async.Future<$0.ResponseToken> login($grpc.ServiceCall call, $0.RequestCreateUser request);
  $async.Future<$0.ResponseUser> getUserInfo($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.ResponseUser> updateUserInfo($grpc.ServiceCall call, $0.RequestUpdateUser request);
  $async.Future<$0.Empty> deleteUser($grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.ResponseUpdateFcmToken> updateFcmToken($grpc.ServiceCall call, $0.RequestUpdateFcmToken request);
}
