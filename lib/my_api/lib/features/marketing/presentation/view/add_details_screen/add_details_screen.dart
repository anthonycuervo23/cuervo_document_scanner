import 'package:bakery_shop_admin_flutter/features/marketing/domain/entities/argumets/add_ads_argumets.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/add_ads_cubit/add_details_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/cubit/add_ads_cubit/add_details_state.dart';
import 'package:bakery_shop_admin_flutter/features/marketing/presentation/view/add_details_screen/add_details_widget.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAdsScreen extends StatefulWidget {
  final AddAdsScreebArgs arguments;
  const AddAdsScreen({super.key, required this.arguments});

  @override
  State<AddAdsScreen> createState() => _AddAdsScreenState();
}

class _AddAdsScreenState extends AddAdsWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AddDeataisCubit, AddDetailsState>(
        bloc: addDeataisCubit,
        builder: (context, state) {
          if (state is AddDetailsLoadedState) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: appbar(context, state: state),
              body: DefaultTabController(
                length: 3,
                initialIndex: state.index,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CommonWidget.container(height: 1.h, color: appConstants.black12),
                      tabbar(context, state),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            tabView(state: state),
                            tabView(state: state),
                            tabView(state: state),
                          ],
                        ),
                      ),
                      CommonWidget.sizedBox(height: 10),
                      submitButton(context: context, state: state),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is AddDetailsLoadingState) {
            return Center(
              child: CommonWidget.loadingIos(),
            );
          } else if (state is AddDeatilsErrorState) {
            return Center(child: CommonWidget.commonText(text: state.errormessage));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
