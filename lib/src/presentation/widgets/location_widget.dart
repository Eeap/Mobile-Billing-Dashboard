import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../domain/models/requests/aws_resources_request.dart';
import '../cubits/login/login_cubit.dart';
import '../cubits/remote_resources/remote_resources_cubit.dart';

class LocationWidget extends HookWidget {
  int _selectedRegionIndex = 0;
  final List<String> _regions = [
    'us-east-1',
    'us-east-2',
    'us-west-1',
    'us-west-2',
    'af-south-1',
    'ap-east-1',
    'ap-south-1',
    'ap-south-2',
    'ap-southeast-1',
    'ap-southeast-2',
    'ap-southeast-3',
    'ap-southeast-4',
    'ap-northeast-1',
    'ap-northeast-2',
    'ap-northeast-3',
    'ca-central-1',
    'eu-central-1',
    'eu-central-2',
    'eu-west-1',
    'eu-west-2',
    'eu-south-1',
    'eu-south-2',
    'eu-west-3',
    'eu-north-1',
    'me-south-1',
    'sa-east-1',
    'il-central-1',
    'me-central-1',
    'us-gov-east-1',
    'us-gov-west-1',
  ];
  LocationWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: CupertinoAlertDialog(
          title: const Text('AWS 리전 선택'),
          actions: <Widget>[
            Container(
              height: 100,
              child: CupertinoPicker(
                itemExtent: _regions.length.toDouble(),
                onSelectedItemChanged: (int index) {
                  _selectedRegionIndex = index;
                },
                children: _regions.map<Text>((String region) {
                  return Text(region);
                }).toList(),
              ),
            ),
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                context.read<RemoteResourcesCubit>().setInitial();
                context.read<RemoteResourcesCubit>().getAwsResources(
                      AwsResourceRequest(
                          email: context.read<LoginCubit>().state.email,
                          region: _regions[_selectedRegionIndex]),
                    );
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
