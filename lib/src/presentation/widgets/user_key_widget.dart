import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../domain/models/requests/user_key_request.dart';
import '../cubits/login/login_cubit.dart';
import '../cubits/profile/profile_cubit.dart';

class UserKeyWidget extends HookWidget {
  UserKeyWidget({
    Key? key,
  }) : super(key: key);
  late TextEditingController _accessController =
      TextEditingController(text: '');
  late TextEditingController _secretController =
      TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Theme(
          data: ThemeData.dark(),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case ProfileInitial:
                  return _buildUserKey(context);
                case ProfileLoading:
                  return const Center(child: CupertinoActivityIndicator());
                case ProfileFailed:
                  return CupertinoAlertDialog(
                    title: const Text('키 등록 실패'),
                    content: const Text('키 등록에 실패했습니다.'),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: const Text('OK'),
                        onPressed: () {
                          context.read<ProfileCubit>().setInitial();
                          _accessController.clear();
                          _secretController.clear();
                        },
                      ),
                    ],
                  );
                case ProfileSuccess:
                  return CupertinoAlertDialog(
                    title: const Text('키 등록 성공'),
                    content: const Text('키 등록에 성공했습니다.'),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: const Text('OK'),
                        onPressed: () {
                          context.read<ProfileCubit>().setInitial();
                          Navigator.pop(context);
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
      ),
    );
  }

  Widget _buildUserKey(BuildContext context) {
    return CupertinoAlertDialog(
      content: const Text("IAM 키 설정을 위해 등록해주세요"),
      actions: <Widget>[
        CupertinoTextField(
          controller: _accessController,
          textInputAction: TextInputAction.next,
          restorationId: 'aws_access_key_text_field',
          clearButtonMode: OverlayVisibilityMode.editing,
          obscureText: true,
          autocorrect: false,
          placeholder: "aws access key",
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        CupertinoTextField(
          controller: _secretController,
          textInputAction: TextInputAction.next,
          restorationId: 'aws_secret_key_text_field',
          clearButtonMode: OverlayVisibilityMode.editing,
          placeholder: "aws secret key",
          obscureText: true,
          autocorrect: false,
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        CupertinoDialogAction(
          child: Text("OK"),
          onPressed: () {
            context.read<ProfileCubit>().setProfileKey(
                  UserKeyRequest(
                    email: context.read<LoginCubit>().state.email,
                    accessKey: _accessController.text,
                    secretKey: _secretController.text,
                  ),
                );
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
