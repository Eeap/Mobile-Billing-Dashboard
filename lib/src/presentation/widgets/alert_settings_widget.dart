import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../domain/models/requests/alert_setting_request.dart';
import '../cubits/alert/alert_cubit.dart';

class AlertSettingsWidget extends HookWidget {
  final initDate = DateTime.now();
  AlertSettingsWidget({
    Key? key,
  }) : super(key: key);
  late TextEditingController costController = TextEditingController(text: '');
  DateTime timeEnd = DateTime.now();
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
            content: const Text("알림 설정을 위한 날짜와 가격을 입력해주세요."),
            actions: <Widget>[
              SizedBox(
                height: 80,
                child: CupertinoDatePicker(
                  maximumYear: DateTime.now().year + 5,
                  initialDateTime: initDate,
                  onDateTimeChanged: _onDateChanged,
                  mode: CupertinoDatePickerMode.date,
                ),
              ),
              SizedBox(
                height: 80,
                child: CupertinoDatePicker(
                  maximumYear: DateTime.now().year + 5,
                  initialDateTime: initDate,
                  onDateTimeChanged: _onTimeChanged,
                  mode: CupertinoDatePickerMode.time,
                ),
              ),
              CupertinoTextField(
                controller: costController,
                textInputAction: TextInputAction.next,
                restorationId: 'target_cost_text_field',
                clearButtonMode: OverlayVisibilityMode.editing,
                placeholder: "target cost input",
                obscureText: false,
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
                  context.read<AlertCubit>().setAlert(
                        AlertSettingRequest(
                          timeEnd: timeEnd.toString(),
                          targetCount: int.parse(costController.text),
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

  void _onDateChanged(DateTime value) {
    timeEnd = DateTime.parse(
        "${value.year}-${value.month}-${value.day} ${timeEnd.hour}:${timeEnd.minute}:${timeEnd.second}");
  }

  void _onTimeChanged(DateTime value) {
    timeEnd = DateTime.parse(
        "${timeEnd.year}-${timeEnd.month}-${timeEnd.day} ${value.hour}:${value.minute}:00");
  }
}
