import 'package:bakery_shop_admin_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_admin_flutter/features/create_new_order/presentation/pages/phone/cateloage/cateloge_screen.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class CatelogeScreenWidget extends State<CatelogeScreen> {
  Widget imageView() {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: widget.productData.image.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: appConstants.transparent,
                elevation: 0,
                contentPadding: EdgeInsets.zero,
                content: productPreview(index),
              );
            },
          );
        },
        child: CommonWidget.imageBuilder(
          imageUrl: widget.productData.image[index],
          borderRadius: 10.r,
        ),
      ),
    );
  }

  Widget productPreview(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: InkWell(
            splashColor: appConstants.transparent,
            splashFactory: NoSplash.splashFactory,
            onTap: () => CommonRouter.pop(),
            child: Container(
              alignment: Alignment.topRight,
              height: 38.h,
              width: double.infinity,
              child: CommonWidget.imageBuilder(
                imageUrl: "assets/photos/svg/catalog_screen/cancle_button.svg",
                color: appConstants.white,
                height: 30.h,
              ),
            ),
          ),
        ),
        CommonWidget.container(
          paddingAllSide: 2,
          borderRadius: 10.r,
          child: InteractiveViewer(
            child: CommonWidget.imageBuilder(
              imageUrl: widget.productData.image[index],
              borderRadius: 10.r,
            ),
          ),
        ),
      ],
    );
  }
}
