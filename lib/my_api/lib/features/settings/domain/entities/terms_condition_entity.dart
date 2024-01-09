import 'package:equatable/equatable.dart';

class PolicyEntity extends Equatable {
  final int id;
  final String slug;
  final String title;
  final String description;
  final String bannerImage;

  const PolicyEntity({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.bannerImage,
  });

  @override
  List<Object?> get props => [
        id,
        slug,
        title,
        description,
        bannerImage,
      ];
}
