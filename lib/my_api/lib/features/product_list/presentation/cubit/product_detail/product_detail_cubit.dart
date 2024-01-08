import 'package:bakery_shop_admin_flutter/features/product_list/presentation/cubit/product_detail/product_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit() : super(const ProductDetailLoadedState());
}
