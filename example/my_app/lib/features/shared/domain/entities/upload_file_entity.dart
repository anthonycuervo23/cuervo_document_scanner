import 'package:equatable/equatable.dart';

class UploadFileEntity extends Equatable {
  final String path;
  final String fullPath;

  const UploadFileEntity({
    required this.path,
    required this.fullPath,
  });

  @override
  List<Object?> get props => [path, fullPath];
}
