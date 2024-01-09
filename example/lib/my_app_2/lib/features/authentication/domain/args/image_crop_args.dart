import 'package:equatable/equatable.dart';

class ImageCropArgs extends Equatable {
  final String imagePathOrURL;
  final double? aspectRatio;

  const ImageCropArgs({required this.imagePathOrURL, required this.aspectRatio});

  @override
  List<Object?> get props => [imagePathOrURL, aspectRatio];
}
class ImageCropInitial extends Equatable{
   @override
  List<Object?> get props => [];
}
