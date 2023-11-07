import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/models/resource.dart';

class ResourceAverageWidget extends StatelessWidget {
  final List<Resource> resources;
  ResourceAverageWidget({
    Key? key,
    required this.resources,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Card(
          color: Colors.blueGrey.shade800.withOpacity(0.8),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 5,
          child: AspectRatio(
            aspectRatio: 3.4,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 24,
                left: 24,
                top: 20,
                bottom: 20,
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Spacer(),
                      Text(
                        "Total cost of resources",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.white,
                    indent: 160,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Spacer(),
                      Text(
                        "US\$ " + _makeTotalCost(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _makeTotalCost() {
    double totalCount = 0;
    for (Resource resource in resources) {
      double amount = double.parse(resource.amount!);
      if (amount < 0.0001 && amount > 0)
        amount = 0.0001;
      else if (amount < 0) amount = 0;
      totalCount += amount;
    }
    return totalCount.toStringAsFixed(6);
  }
}
