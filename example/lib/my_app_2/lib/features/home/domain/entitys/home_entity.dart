import 'package:bakery_shop_flutter/features/home/data/models/home_model.dart';
import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  final List<BannerData> banners;
  final List<CategoryDataModel> categories;

  const HomeEntity({required this.banners, required this.categories});
  @override
  List<Object?> get props => [banners, categories];
}
