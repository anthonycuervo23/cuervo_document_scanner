import 'package:bakery_shop_admin_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_admin_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/home/presentation/view/home_screen/home_screen_widget.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/common_customer_box.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/widgets/customer_abd_supplier_card_model.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeScreenWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dashboardDetails(),
            Text(
              TranslationConstants.transactions.translate(context),
              style: TextStyle(
                fontSize: 18.sp,
                color: appConstants.themeColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            1 == 1
                ? customerAndSupplierListBox(
                    context: context,
                    details: loadCardData(customerDetails: customerDetails[0]),
                    onDeleteButtonTap: () {},
                    onCardTap: () {},
                    onEditButtonTap: () {},
                  )
                : transactionsHere(context),
          ],
        ),
      ),
    );
  }

  CustomerAndSupplierCardModel loadCardData({required CustomerDetailModel customerDetails}) {
    return CustomerAndSupplierCardModel(
      name: customerDetails.name,
      mobileNumber: customerDetails.mobileNumber,
      orderAmount: customerDetails.totalOrderAmount.toString(),
      balanceAmount: customerDetails.balance.toString(),
      image: customerDetails.profileImage,
      date: customerDetails.date,
      balanceAmountType: CustomerBalanceType.ToPay,
      customerType: CustomerType.New,
      isPending: false,
    );
  }
}
