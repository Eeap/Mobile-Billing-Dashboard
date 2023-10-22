import 'package:equatable/equatable.dart';

class Resource extends Equatable {
  final String? key;
  final double? amount;
  final DateTime? timeEnd;
  final DateTime? timeStart;

  const Resource({
    this.key,
    this.amount,
    this.timeEnd,
    this.timeStart,
  });

  factory Resource.fromMap(Map<String, dynamic> map) {
    return Resource(
      amount: map['amount'] != null ? map['amount'] as double : null,
      key: map['key'] != null ? map['key'] as String : null,
      timeEnd: map['timeEnd'] != null ? map['timeEnd'] as DateTime : null,
      timeStart: map['timeStart'] != null ? map['timeStart'] as DateTime : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [key, amount, timeEnd, timeStart];
  }
}
