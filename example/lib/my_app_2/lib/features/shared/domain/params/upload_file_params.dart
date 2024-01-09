import 'package:equatable/equatable.dart';

class UploadFileParams extends Equatable {
  final String type;
  final String file;
  final String? oldPath;

  const UploadFileParams({required this.type, required this.file, this.oldPath});

  @override
  List<Object?> get props => [type, file, oldPath];
}
