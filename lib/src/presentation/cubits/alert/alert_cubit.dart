import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/requests/alert_request.dart';
import '../../../domain/models/requests/alert_setting_request.dart';
import '../base/base_cubit.dart';
import '../../../domain/models/alert_message.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/resources/data_state.dart';
import 'package:dio/dio.dart';
part 'alert_state.dart';

class AlertCubit extends BaseCubit<AlertState, List<AlertMessage>> {
  final ApiRepository _apiRepository;

  AlertCubit(this._apiRepository) : super(const AlertLoading(), []);

  Future<void> getAlertMessages() async {
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.getAlertMessages(
        request: AlertRequest(),
      );

      if (response is DataSuccess) {
        final messages = response.data!.messages;
        final noMoreData = false;

        data.addAll(messages);

        emit(AlertSuccess(messages: data, noMoreData: noMoreData));
      } else if (response is DataFailed) {
        emit(AlertFailed(error: response.error));
      }
    });
  }

  Future<void> setAlert(AlertSettingRequest alertSettingRequest) async {
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.setAlert(
        request: alertSettingRequest,
      );
      if (response is DataSuccess) {
        final message = response.data!.message;
        final noData = false;

        emit(AlertSettingSuccess(message: message, noMoreData: noData));
      } else if (response is DataFailed) {
        emit(AlertSettingFailed(error: response.error));
      }
    });
  }
}
