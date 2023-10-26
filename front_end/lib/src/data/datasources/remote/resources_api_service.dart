import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../../../domain/models/requests/aws_resources_request.dart';
import '../../../domain/models/responses/aws_resources_response.dart';
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
}
