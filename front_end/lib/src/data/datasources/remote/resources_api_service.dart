import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../domain/models/requests/alert_setting_request.dart';
import '../../../domain/models/requests/aws_resources_request.dart';
import '../../../domain/models/requests/login_request.dart';
import '../../../domain/models/requests/logout_request.dart';
import '../../../domain/models/requests/sign_up_request.dart';
import '../../../domain/models/requests/user_key_request.dart';
import '../../../domain/models/responses/alert_response.dart';
import '../../../domain/models/responses/alert_setting_response.dart';
import '../../../domain/models/responses/aws_resources_response.dart';
import '../../../domain/models/responses/login_response.dart';
import '../../../domain/models/responses/logout_response.dart';
import '../../../domain/models/responses/sign_up_response.dart';
import '../../../domain/models/responses/user_key_response.dart';
import '../../../utils/constants/strings.dart';

part 'resources_api_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.JsonSerializable)
abstract class ResourceApiService {
  factory ResourceApiService(Dio dio, {String baseUrl}) = _ResourceApiService;

  @GET('/aws-resource')
  @Headers({"Content-Type": "application/json"})
  Future<HttpResponse<AwsResourceResponse>> getAwsResources({
    @Query("email") String? email,
    @Query("region") String? region,
    @Query("day") int? day,
  });

  @GET('/alert-messages')
  @Headers({"Content-Type": "application/json"})
  Future<HttpResponse<AlertResponse>> getAlertMessages({
    @Query("email") String? email,
  });
  @POST('/alert-setting')
  @Headers({"Content-Type": "application/json"})
  Future<HttpResponse<AlertSettingResponse>> setAlert({
    @Body() AlertSettingRequest? reqData,
  });

  @Headers({"Content-Type": "application/json"})
  @POST("/user-key")
  Future<HttpResponse<UserKeyResponse>> setProfileKey({
    @Body() UserKeyRequest? reqData,
  });
  @Headers({"Content-Type": "application/json"})
  @POST("/sign-up")
  Future<HttpResponse<SignUpResponse>> signUp({
    @Body() SignUpRequest? reqData,
  });
  @Headers({"Content-Type": "application/json"})
  @POST("/login")
  Future<HttpResponse<LoginResponse>> login({
    @Body() LoginRequest? reqData,
  });
  @Headers({"Content-Type": "application/json"})
  @POST("/logout")
  Future<HttpResponse<LogoutResponse>> logout({
    @Body() LogoutRequest? reqData,
  });
}
