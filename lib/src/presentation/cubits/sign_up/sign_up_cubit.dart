import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/requests/sign_up_request.dart';
import '../base/base_cubit.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/resources/data_state.dart';
import 'package:dio/dio.dart';

part 'sign_up_state.dart';

class SignUpCubit extends BaseCubit<SignUpState, String> {
  final ApiRepository _apiRepository;
  SignUpCubit(this._apiRepository) : super(const SignUpInitial(), "");

  Future<void> signUp(SignUpRequest request) async {
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.signUp(
        request: request,
      );

      if (response is DataSuccess) {
        final message = response.data!.message;
        final noData = false;

        emit(SignUpSuccess(message: message, noData: noData));
      } else if (response is DataFailed) {
        emit(SignUpFailed(error: response.error));
      }
    });
  }

  Future<void> setInitial() async {
    emit(SignUpInitial());
  }
}
