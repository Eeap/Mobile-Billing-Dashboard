import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/models/responses/aws_resources_response.dart';
import '../../../utils/constants/strings.dart';

part 'resources_api_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.MapSerializable)
abstract class ResourceApiService {
  factory ResourceApiService(Dio dio, {String baseUrl}) = _ResourceApiService;

  @GET('/aws-resource')
  Future<HttpResponse<AwsResourceResponse>> getAwsResources({
    @Query("region") String? region,
    @Query("day") int? day,
    @Query("email") String? email,
  });
}
