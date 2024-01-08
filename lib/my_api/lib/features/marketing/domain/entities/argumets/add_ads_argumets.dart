import 'package:bakery_shop_admin_flutter/features/marketing/data/models/marketing_model.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/marketing_cubit/marketing_cubit.dart';

class AddAdsScreebArgs {
  final MarketingDataModel marketingDataModel;
  final SelectedTab selectedTab;
  final bool fromEditScreen;
  AddAdsScreebArgs({required this.marketingDataModel, required this.selectedTab, required this.fromEditScreen});
}
