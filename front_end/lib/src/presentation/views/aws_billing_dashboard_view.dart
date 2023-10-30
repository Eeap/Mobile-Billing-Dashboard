import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

import '../../config/router/app_router.dart';
import '../../domain/models/resource.dart';
import '../../utils/extensions/scroll_controller_extensions.dart';
import '../cubits/remote_resources/remote_resources_cubit.dart';
import '../widgets/resource_chart_widget.dart';

class AWSBillingDashboardView extends HookWidget {
  const AWSBillingDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remoteResourcesCubit = BlocProvider.of<RemoteResourcesCubit>(context);
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.onScrollEndsListener(() {
        remoteResourcesCubit.getAwsResources();
      });

      return scrollController.dispose;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AWS Billing Dashboard',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(Ionicons.bookmark, color: Colors.black),
            ),
          ),
        ],
        backgroundColor: Colors.blueGrey,
      ),
      body: BlocBuilder<RemoteResourcesCubit, RemoteResourcesState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case RemoteResourcesLoading:
              return const Center(child: CupertinoActivityIndicator());
            case RemoteResourcesFailed:
              return const Center(child: Icon(Ionicons.refresh));
            case RemoteResourcesSuccess:
              return _buildArticles(
                scrollController,
                state.resources,
                state.noMoreData,
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildArticles(
    ScrollController scrollController,
    List<Resource> resources,
    bool noMoreData,
  ) {
    // 리소스 가공
    List<List<Resource>?> mapResources = makeListSort(resources);
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ResourseChartWidget(
                mapResources: mapResources[index],
                dayData: makeDayData(mapResources[index])),
            childCount: mapResources.length - 1,
          ),
        ),
        if (!noMoreData)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 14, bottom: 32),
              child: CupertinoActivityIndicator(),
            ),
          )
      ],
    );
  }

  List<List<Resource>?> makeListSort(List<Resource> resources) {
    Map<String?, List<Resource>> _mapData = {};
    List<List<Resource>?> result = [];
    for (Resource resource in resources) {
      if (_mapData.containsKey(resource.key)) {
        _mapData[resource.key]?.add(resource);
      } else {
        _mapData[resource.key] = [];
      }
    }
    for (String? key in _mapData.keys) {
      result.add(_mapData[key]);
    }
    return result;
  }

  List<String> makeDayData(List<Resource>? mapResources) {
    // 년도 짜르고 월일만 보내기
    List<String> dayData = [];
    for (int i = 0; i < mapResources!.length; i++) {
      var date = DateTime.parse(mapResources[i].timeStart!);
      dayData.add(date.month.toString() + "-" + date.day.toString());
    }
    return dayData;
  }
}
