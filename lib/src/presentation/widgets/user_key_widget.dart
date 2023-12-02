import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../domain/models/requests/user_key_request.dart';
import '../../domain/models/resource.dart';
import '../cubits/profile/profile_cubit.dart';
import '../cubits/remote_resources/remote_resources_cubit.dart';

class UserKeyWidget extends StatelessWidget {
  final ProfileCubit profileCubit;
  UserKeyWidget({
    required this.profileCubit,
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
          child: CupertinoAlertDialog(
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
                  profileCubit.setProfileKey(
                    UserKeyRequest(
                      accessKey: _accessController.text,
                      secretKey: _secretController.text,
                    ),
                  );
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text("CANCEL"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
