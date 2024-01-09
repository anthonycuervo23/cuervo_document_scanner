import 'package:equatable/equatable.dart';

class PolicyEntity extends Equatable {
  final String title;
  final String description;

  const PolicyEntity({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [
        title,
        description,
      ];
}
