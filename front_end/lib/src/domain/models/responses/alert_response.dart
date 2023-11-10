import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../alert_message.dart';

@JsonSerializable()
class AlertResponse extends Equatable {
  final int totalResults;
  final List<AlertMessage> messages;

  AlertResponse({
    required this.totalResults,
    required this.messages,
  });
  factory AlertResponse.fromJson(Map<String, dynamic> map) {
    return AlertResponse(
      totalResults: (map['totalResults'] ?? 0) as int,
      messages: List<AlertMessage>.from(
        map['messages'].map<AlertMessage>(
          (x) => AlertMessage.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [totalResults, messages];
}
