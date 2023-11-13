import '../../domain/models/requests/alert_request.dart';
import '../../domain/models/requests/alert_setting_request.dart';
import '../../domain/models/requests/aws_resources_request.dart';
import '../../domain/models/requests/login_request.dart';
import '../../domain/models/requests/logout_request.dart';
import '../../domain/models/requests/sign_up_request.dart';
import '../../domain/models/requests/user_key_request.dart';
import '../../domain/models/responses/alert_response.dart';
import '../../domain/models/responses/alert_setting_response.dart';
import '../../domain/models/responses/aws_resources_response.dart';
import '../../domain/models/responses/login_response.dart';
import '../../domain/models/responses/logout_response.dart';
import '../../domain/models/responses/sign_up_response.dart';
import '../../domain/models/responses/user_key_response.dart';
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

  @override
  Future<DataState<AlertResponse>> getAlertMessages({
    required AlertRequest request,
  }) {
    return getStateOf<AlertResponse>(
      request: () => _resourceApiService.getAlertMessages(
        email: request.email,
      ),
    );
  }

  @override
  Future<DataState<UserKeyResponse>> setProfileKey({
    required UserKeyRequest request,
  }) {
    return getStateOf<UserKeyResponse>(
      request: () => _resourceApiService.setProfileKey(
        reqData: request,
      ),
    );
  }

  @override
  Future<DataState<AlertSettingResponse>> setAlert({
    required AlertSettingRequest request,
  }) {
    return getStateOf<AlertSettingResponse>(
      request: () => _resourceApiService.setAlert(
        reqData: request,
      ),
    );
  }

  @override
  Future<DataState<SignUpResponse>> signUp({
    required SignUpRequest request,
  }) {
    return getStateOf<SignUpResponse>(
      request: () => _resourceApiService.signUp(
        reqData: request,
      ),
    );
  }

  @override
  Future<DataState<LoginResponse>> login({
    required LoginRequest request,
  }) {
    return getStateOf<LoginResponse>(
      request: () => _resourceApiService.login(
        reqData: request,
      ),
    );
  }

  @override
  Future<DataState<LogoutResponse>> logout({
    required LogoutRequest request,
  }) {
    return getStateOf<LogoutResponse>(
      request: () => _resourceApiService.logout(
        reqData: request,
      ),
    );
  }
}
