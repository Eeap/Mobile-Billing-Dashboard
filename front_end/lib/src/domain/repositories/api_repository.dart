import '../../utils/resources/data_state.dart';
import '../models/requests/alert_request.dart';
import '../models/requests/alert_setting_request.dart';
import '../models/requests/aws_resources_request.dart';
import '../models/requests/user_key_request.dart';
import '../models/responses/alert_response.dart';
import '../models/responses/alert_setting_response.dart';
import '../models/responses/aws_resources_response.dart';
import '../models/responses/user_key_response.dart';

abstract class ApiRepository {
  Future<DataState<AwsResourceResponse>> getAwsResources({
    required AwsResourceRequest request,
  });
  Future<DataState<AlertResponse>> getAlertMessages({
    required AlertRequest request,
  });
  Future<DataState<UserKeyResponse>> setProfileKey({
    required UserKeyRequest request,
  });
  Future<DataState<AlertSettingResponse>> setAlert({
    required AlertSettingRequest request,
  });
}
