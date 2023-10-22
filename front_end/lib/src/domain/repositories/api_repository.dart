import '../../utils/resources/data_state.dart';
import '../models/requests/aws_resources_request.dart';
import '../models/responses/aws_resources_response.dart';

abstract class ApiRepository {
  Future<DataState<AwsResourceResponse>> getAwsResources({
    required AwsResourceRequest request,
  });
}
