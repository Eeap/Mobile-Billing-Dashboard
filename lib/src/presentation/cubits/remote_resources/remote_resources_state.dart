part of 'remote_resources_cubit.dart';

sealed class RemoteResourcesState extends Equatable {
  final List<Resource> resources;
  final bool noMoreData;
  final DioError? error;
  final String region;
  const RemoteResourcesState({
    this.resources = const [],
    this.noMoreData = true,
    this.error,
    this.region = "us-east-1",
  });

  @override
  List<Object?> get props => [resources, noMoreData, error];
}

class RemoteResourcesLoading extends RemoteResourcesState {
  const RemoteResourcesLoading();
}

class RemoteResourcesSuccess extends RemoteResourcesState {
  const RemoteResourcesSuccess(
      {super.resources, super.noMoreData, super.region});
}

class RemoteResourcesFailed extends RemoteResourcesState {
  const RemoteResourcesFailed({super.error});
}

class RemoteResourcesInitial extends RemoteResourcesState {
  const RemoteResourcesInitial();
}
