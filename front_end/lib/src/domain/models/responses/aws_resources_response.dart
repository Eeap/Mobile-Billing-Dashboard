import 'package:equatable/equatable.dart';

import '../resource.dart';

class AwsResourceResponse extends Equatable {
  final int totalResults;
  final List<Resource> resources;

  AwsResourceResponse({
    required this.totalResults,
    required this.resources,
  });

  factory AwsResourceResponse.fromMap(Map<String, dynamic> map) {
    return AwsResourceResponse(
      totalResults: (map['totalResults'] ?? 0) as int,
      resources: List<Resource>.from(
        map['resources'].map<Resource>(
          (x) => Resource.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [totalResults, resources];
}
