import 'package:equatable/equatable.dart';

class Resource extends Equatable {
  final String? key;
  final String? amount;
  final String? timeEnd;
  final String? timeStart;

  const Resource({
    this.key,
    this.amount,
    this.timeEnd,
    this.timeStart,
  });

  factory Resource.fromMap(Map<String, dynamic> map) {
    return Resource(
      amount: map['amount'] != null ? map['amount'] as String : null,
      key: map['key'] != null ? map['key'] as String : null,
      timeEnd: map['timeEnd'] != null ? map['timeEnd'] as String : null,
      timeStart: map['timeStart'] != null ? map['timeStart'] as String : null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [key, amount, timeEnd, timeStart];
  }
}
