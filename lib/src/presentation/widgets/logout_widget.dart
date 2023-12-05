import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../config/router/app_router.dart';
import '../../domain/models/requests/logout_request.dart';
import '../cubits/login/login_cubit.dart';
import '../cubits/logout/logout_cubit.dart';
import '../cubits/profile/profile_cubit.dart';
import '../cubits/remote_resources/remote_resources_cubit.dart';

class LogoutWidget extends HookWidget {
  LogoutWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: BlocBuilder<LogoutCubit, LogoutState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case LogoutInitial:
                return _buildLogout(context);
              case LogoutLoading:
                return const Center(child: CupertinoActivityIndicator());
              case LogoutFailed:
                return CupertinoAlertDialog(
                  title: const Text('로그아웃 실패'),
                  content: const Text('로그아웃에 실패했습니다.'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: const Text('OK'),
                      onPressed: () {
                        context.read<LogoutCubit>().setInitial();
                      },
                    ),
                  ],
                );
              case LogoutSuccess:
                return CupertinoAlertDialog(
                  title: const Text('로그아웃 성공'),
                  content: const Text('로그아웃에 성공했습니다.'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: const Text('OK'),
                      onPressed: () {
                        context.read<LogoutCubit>().setInitial();
                        context.read<ProfileCubit>().setInitial();
                        context.read<RemoteResourcesCubit>().setInitial();
                        appRouter.push(const LoginViewRoute());
                      },
                    ),
                  ],
                );
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLogout(BuildContext context) {
    return CupertinoAlertDialog(
      content: const Text("로그아웃 하시겠습니까?"),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text("OK"),
          onPressed: () {
            context.read<LogoutCubit>().logout(
                LogoutRequest(email: context.read<LoginCubit>().state.email));
            context.read<LoginCubit>().setInitial();
          },
        ),
        CupertinoDialogAction(
          child: Text("CANCEL"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
