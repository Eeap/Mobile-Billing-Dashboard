import 'package:equatable/equatable.dart';

class AlertMessage extends Equatable {
  final String? time;
  final String? message;

  const AlertMessage({
    this.time,
    this.message,
  });

  factory AlertMessage.fromMap(Map<String, dynamic> map) {
    return AlertMessage(
      time: map['time'] != null ? map['time'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [time, message];
  }
}
