import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../domain/models/resource.dart';

class ResourseChartWidget extends StatelessWidget {
  final Resource resource;

  const ResourseChartWidget({
    Key? key,
    required this.resource,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsetsDirectional.only(
            start: 14, end: 14, bottom: 7, top: 7),
        height: MediaQuery.of(context).size.width / 2.2,
        child: Row(
          children: [
            Text("data"),
          ],
        ),
      ),
    );
  }
}
