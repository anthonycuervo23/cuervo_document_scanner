import 'package:equatable/equatable.dart';

class GetUserParams extends Equatable {
  final String profilePhoto;
  const GetUserParams({
    required this.profilePhoto,
  });

  @override
  List<Object?> get props => [profilePhoto];
}
