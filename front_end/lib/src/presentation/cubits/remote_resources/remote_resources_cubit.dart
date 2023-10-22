import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/models/requests/aws_resources_request.dart';
import '../base/base_cubit.dart';
import 'package:dio/dio.dart';
import '../../../domain/models/resource.dart';
import '../../../utils/resources/data_state.dart';
import '../../../domain/repositories/api_repository.dart';

part 'remote_resources_state.dart';

class RemoteResourcesCubit
    extends BaseCubit<RemoteResourcesState, List<Resource>> {
  final ApiRepository _apiRepository;

  RemoteResourcesCubit(this._apiRepository)
      : super(const RemoteResourcesLoading(), []);

  Future<void> getAwsResources() async {
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.getAwsResources(
        request: AwsResourceRequest(),
      );

      if (response is DataSuccess) {
        final resources = response.data!.resources;
        final noMoreData = false;

        data.addAll(resources);

        emit(RemoteResourcesSuccess(resources: data, noMoreData: noMoreData));
      } else if (response is DataFailed) {
        emit(RemoteResourcesFailed(error: response.error));
      }
    });
  }
}
