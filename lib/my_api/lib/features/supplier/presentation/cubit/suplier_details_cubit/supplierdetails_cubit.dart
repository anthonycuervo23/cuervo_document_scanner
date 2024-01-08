import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/data/models/item_related_price_model.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/data/models/supplier_model.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/presentation/cubit/supplier_cubit/supplier_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'supplierdetails_state.dart';

class SupplierdetailsCubit extends Cubit<SupplierdetailsState> {
  final SupplierCubit supplierCubit;
  SupplierdetailsCubit({required this.supplierCubit}) : super(const SupplierDetailsLoadedState(tab: 0));

  List<ItemRealtedPriceModel> itemRelatedMarginList = [
    ItemRealtedPriceModel(id: 1, date: "22/11/2023", item: "Wheat flour", amount: 500, margin: "20"),
    ItemRealtedPriceModel(id: 2, date: "22/11/2023", item: "Sunflower oil", amount: 250, margin: "10"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
    ItemRealtedPriceModel(id: 3, date: "22/11/2023", item: "Coconut oil", amount: 125, margin: "7"),
  ];

  void changeTab({required int tabValue}) {
    emit(SupplierDetailsLoadedState(tab: tabValue));
  }

  void deleteSupplier({required SupplierDetailModel supplierDetailModel}) {
    supplierCubit.deleteSupplier(supplierDetailModel: supplierDetailModel);
    CommonRouter.pop();
  }
}
