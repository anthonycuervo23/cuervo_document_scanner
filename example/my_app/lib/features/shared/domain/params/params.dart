import 'package:equatable/equatable.dart';

class StringParams extends Equatable {
  final String params;
  const StringParams({required this.params});

  @override
  List<Object?> get props => [params];
}
