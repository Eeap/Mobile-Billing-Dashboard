import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

import '../../config/router/app_router.dart';
import '../../domain/models/requests/aws_resources_request.dart';
import '../../domain/models/resource.dart';
import '../../utils/extensions/scroll_controller_extensions.dart';
import '../cubits/login/login_cubit.dart';
import '../cubits/remote_resources/remote_resources_cubit.dart';
import '../widgets/location_widget.dart';
import '../widgets/logout_widget.dart';
import '../widgets/resource_average_widget.dart';
import '../widgets/resource_chart_widget.dart';
import '../widgets/user_key_widget.dart';

class AWSBillingDashboardView extends HookWidget {
  const AWSBillingDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.onScrollEndsListener(() {
        context.read<RemoteResourcesCubit>().getAwsResources(
            AwsResourceRequest(email: context.read<LoginCubit>().email));
      });

      return scrollController.dispose;
    }, const []);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 55, 106, 194),
            const Color.fromARGB(255, 233, 185, 114),
          ],
        ),
      ),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Ionicons.bar_chart_outline),
              label: 'Chart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.notifications_outline),
              label: 'Alert',
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.key_outline),
              label: 'Settings',
            ),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.6),
          onTap: (index) {
            switch (index) {
              case 0:
                appRouter.push(
                  const AWSBillingDashboardViewRoute(),
                );
                break;
              case 1:
                appRouter.push(
                  const AlertViewRoute(),
                );
                break;
              case 2:
                showDialog(
                  builder: (context) => UserKeyWidget(),
                  context: context,
                );
                break;
            }
          },
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child:
                    Icon(Ionicons.location_outline, color: Colors.orangeAccent),
              ),
              onTap: () {
                showDialog(
                  builder: (context) => LocationWidget(),
                  context: context,
                );
              },
            ),
            const Spacer(),
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Icon(Ionicons.person_circle_outline,
                    color: Colors.orangeAccent),
              ),
              onTap: () {
                showDialog(
                  builder: (context) => LogoutWidget(),
                  context: context,
                );
              },
            ),
          ],
          backgroundColor: Color.fromARGB(255, 18, 65, 103).withOpacity(0.3),
        ),
        backgroundColor: Colors.transparent,
        body: BlocBuilder<RemoteResourcesCubit, RemoteResourcesState>(
          builder: (_, state) {
            switch (state.runtimeType) {
              case RemoteResourcesLoading:
                return const Center(child: CupertinoActivityIndicator());
              case RemoteResourcesFailed:
                return const Center(child: Icon(Ionicons.refresh));
              case RemoteResourcesSuccess:
                return _buildCosts(
                  scrollController,
                  state.resources,
                  state.noMoreData,
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _buildCosts(
    ScrollController scrollController,
    List<Resource> resources,
    bool noMoreData,
  ) {
    // 리소스 가공
    List<List<Resource>?> mapResources = makeListSort(resources);
    return Padding(
      //container 세부 설정
      padding: const EdgeInsets.all(4),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 20, bottom: 20),
              child: Row(
                children: [
                  Text(
                    "AWS Billing Dashboard",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            CustomScrollView(
              shrinkWrap: true,
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: ResourceAverageWidget(resources: resources),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ResourceChartWidget(
                        mapResources: mapResources[index],
                        dayData: makeDayData(mapResources[index])),
                    childCount: mapResources.length,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<List<Resource>?> makeListSort(List<Resource> resources) {
    Map<String?, List<Resource>> _mapData = {};
    List<List<Resource>?> result = [];
    for (Resource resource in resources) {
      if (_mapData.containsKey(resource.key)) {
        _mapData[resource.key]?.add(resource);
      } else {
        _mapData[resource.key] = [resource];
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
