import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

import '../../domain/models/alert_message.dart';
import '../cubits/alert/alert_cubit.dart';
import '../widgets/alert_message_widget.dart';
import '../widgets/alert_settings_widget.dart';

class AlertView extends HookWidget {
  const AlertView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final alertCubit = BlocProvider.of<AlertCubit>(context);
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
        appBar: AppBar(
          actions: [
            const Spacer(),
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Icon(Ionicons.settings_outline, color: Colors.orange),
              ),
              onTap: () => {
                showDialog(
                  builder: (context) => AlertSettingsWidget(
                    alertCubit: alertCubit,
                  ),
                  context: context,
                )
              },
            ),
          ],
          backgroundColor: Color.fromARGB(255, 18, 65, 103).withOpacity(0.3),
        ),
        backgroundColor: Colors.transparent,
        body: BlocBuilder<AlertCubit, AlertState>(
          builder: (_, state) {
            switch (state.runtimeType) {
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
