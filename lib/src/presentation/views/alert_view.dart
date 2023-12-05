import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import '../../config/router/app_router.dart';
import '../../domain/models/alert_message.dart';
import '../../domain/models/requests/alert_request.dart';
import '../../domain/models/requests/aws_resources_request.dart';
import '../cubits/alert/alert_cubit.dart';
import '../cubits/login/login_cubit.dart';
import '../cubits/remote_resources/remote_resources_cubit.dart';
import '../widgets/alert_message_widget.dart';
import '../widgets/alert_settings_widget.dart';
import '../widgets/logout_widget.dart';
import '../widgets/user_key_widget.dart';

class AlertView extends HookWidget {
  const AlertView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

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
          currentIndex: 1,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.6),
          onTap: (index) {
            switch (index) {
              case 0:
                context
                    .read<RemoteResourcesCubit>()
                    .getAwsResources(AwsResourceRequest(
                      email: context.read<LoginCubit>().state.email,
                      region: context.read<RemoteResourcesCubit>().state.region,
                    ));
                appRouter.push(
                  const AWSBillingDashboardViewRoute(),
                );
                break;
              case 1:
                context.read<AlertCubit>().getAlertMessages(
                      AlertRequest(
                        email: context.read<LoginCubit>().state.email,
                      ),
                    );
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
          actions: [
            const Spacer(),
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Icon(Ionicons.settings_outline, color: Colors.orange),
              ),
              onTap: () {
                showDialog(
                  builder: (context) => AlertSettingsWidget(),
                  context: context,
                );
              },
            ),
          ],
          backgroundColor: Color.fromARGB(255, 18, 65, 103).withOpacity(0.3),
        ),
        backgroundColor: Colors.transparent,
        body: BlocBuilder<AlertCubit, AlertState>(
          builder: (_, state) {
            switch (state.runtimeType) {
              case AlertSettingSuccess:
                return CupertinoAlertDialog(
                  content: const Text("알림 설정을 완료했습니다."),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text("OK"),
                      onPressed: () {
                        context.read<AlertCubit>().getAlertMessages(
                              AlertRequest(
                                email: context.read<LoginCubit>().state.email,
                              ),
                            );
                      },
                    ),
                  ],
                );
              case AlertLoading:
                return const Center(child: CupertinoActivityIndicator());
              case AlertFailed:
                return const Center(child: Icon(Ionicons.refresh));
              case AlertSuccess:
                return _buildAlerts(
                  scrollController,
                  state.messages,
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

  Widget _buildAlerts(
    ScrollController scrollController,
    List<AlertMessage> messages,
    bool noMoreData,
  ) {
    // 리소스 가공
    messages.sort((a, b) => b.time!.compareTo(a.time!));
    return Padding(
      //container 세부 설정
      padding: const EdgeInsets.all(4),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomScrollView(
              shrinkWrap: true,
              controller: scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => AlertMessageWidget(
                      message: messages[index],
                    ),
                    childCount: messages.length,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
