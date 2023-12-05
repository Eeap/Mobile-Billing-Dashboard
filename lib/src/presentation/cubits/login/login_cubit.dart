import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/requests/login_request.dart';
import '../base/base_cubit.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/resources/data_state.dart';
import 'package:dio/dio.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState, String> {
  final ApiRepository _apiRepository;
  LoginCubit(this._apiRepository) : super(LoginInitial(), "");
  late final email;
  Future<void> login(LoginRequest request) async {
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.login(
        request: request,
      );
      if (response is DataSuccess) {
        final message = response.data!.message;
        final noData = false;
        emit(LoginSuccess(
            message: message, noData: noData, email: request.email));
      } else if (response is DataFailed) {
        emit(LoginFailed(error: response.error));
      }
    });
  }

  Future<void> setInitial() async {
    emit(LoginInitial());
  }

  String? get emailValue => state.email;
}
