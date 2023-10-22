import '../../domain/models/requests/aws_resources_request.dart';
import '../../domain/models/responses/aws_resources_response.dart';
import '../../domain/repositories/api_repository.dart';
import '../../utils/resources/data_state.dart';
import '../datasources/remote/resources_api_service.dart';
import 'base/base_api_repository.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final ResourceApiService _resourceApiService;

  ApiRepositoryImpl(this._resourceApiService);

  @override
  Future<DataState<AwsResourceResponse>> getAwsResources({
    required AwsResourceRequest request,
  }) {
    return getStateOf<AwsResourceResponse>(
      request: () => _resourceApiService.getAwsResources(
        region: request.region,
        day: request.day,
        email: request.email,
      ),
    );
  }
}
