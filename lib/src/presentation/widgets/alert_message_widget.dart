import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../domain/models/alert_message.dart';
import '../../domain/models/resource.dart';

class AlertMessageWidget extends StatelessWidget {
  final AlertMessage message;
  AlertMessageWidget({
    required this.message,
    Key? key,
  }) : super(key: key);
  List<Color> gradientColors = [
    Colors.orange,
    Colors.orangeAccent,
  ];
  double maxData = 0.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Card(
          color: const Color.fromARGB(255, 42, 129, 201).withOpacity(0.2),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 5,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  message.time.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 9,
                child: Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                      left: 16,
                      top: 12,
                      bottom: 4,
                    ),
                    child: Text(
                      "${message.message}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
