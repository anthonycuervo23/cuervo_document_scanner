import 'package:bakery_shop_flutter/common/constants/common_router.dart';
import 'package:bakery_shop_flutter/common/constants/translation_constants.dart';
import 'package:bakery_shop_flutter/common/extention/string_extension.dart';
import 'package:bakery_shop_flutter/common/extention/theme_extension.dart';
import 'package:bakery_shop_flutter/features/settings/presentation/cubit/policy_cubit/policy_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/cubit/help_support/help_support_cubit.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/custom_app_bar/custom_app_bar.dart';
import 'package:bakery_shop_flutter/features/shared/presentation/view/help_support/help_and_support_widget.dart';
import 'package:bakery_shop_flutter/routing/route_list.dart';
import 'package:bakery_shop_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bakery_shop_flutter/global.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends HelpAndSupportWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.whiteBackgroundColor,
      appBar: customAppBar(
        context,
        onTap: () => CommonRouter.pop(),
        title: TranslationConstants.help_Support.translate(context),
      ),
      body: BlocBuilder<HelpAndSupportCubit, HelpAndSupportState>(
        bloc: helpSupportCubit,
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: CommonWidget.imageBuilder(
                        imageUrl: "assets/photos/svg/help_support/help_and_suport.svg",
                        height: 160.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    CommonWidget.commonText(
                      text: TranslationConstants.help_Support.translate(context),
                      style: Theme.of(context).textTheme.subTitle1BoldHeading.copyWith(
                            color: appConstants.default1Color,
                          ),
                    ),
                    CommonWidget.commonText(
                      text: TranslationConstants.how_can_i_help.translate(context),
                      style: Theme.of(context).textTheme.captionBookHeading.copyWith(
                            color: appConstants.default4Color,
                          ),
                    ),
                    CommonWidget.sizedBox(height: 30),
                    commonBox(
                      connectData: TranslationConstants.connect_with_chat.translate(context),
                      imagePath: "assets/photos/svg/help_support/chat.svg",
                      imageBgcolor: appConstants.bestSeller2Color,
                      onTap: () => CommonRouter.pushNamed(RouteList.chat_support_screen),
                    ),
                    commonBox(
                      connectTitle: TranslationConstants.connect_to_call.translate(context),
                      connectData: "+91 9908796758",
                      imagePath: "assets/photos/svg/help_support/call.svg",
                      imageColor: appConstants.profilePhone1Color,
                      imageBgcolor: appConstants.profilePhone2Color,
                      onTap: () async {
                        Uri phoneno = Uri.parse('tel:+91 9876543210');
                        await launchUrl(phoneno);
                      },
                    ),
                    commonBox(
                      connectTitle: TranslationConstants.connect_to_wp.translate(context),
                      connectData: "+91 9908796758",
                      imagePath: "assets/photos/svg/help_support/whastup.svg",
                      imageColor: appConstants.green1Color,
                      imageBgcolor: appConstants.green2Color,
                      onTap: () async {
                        var url = Uri.parse("http://wa.me/9876543210");
                        await launchUrl(url);
                      },
                    ),
                    commonBox(
                      connectTitle: TranslationConstants.send_an_email.translate(context),
                      connectData: "info@bakerydemo.in",
                      imageColor: appConstants.profileEmail1Color,
                      imageBgcolor: appConstants.profileEmail2Color,
                      imagePath: "assets/photos/svg/help_support/email.svg",
                      onTap: () async {
                        String? email = 'info@bakerydemo.in';
                        var url = Uri.parse("mailto:$email");
                        if (await launchUrl(url)) {
                          launchUrl(url);
                        } else {
                          throw "Error occured sending an email";
                        }
                      },
                    ),
                    CommonWidget.sizedBox(height: 10),
                    InkWell(
                      onTap: () => CommonRouter.pushNamed(
                        RouteList.policy_screen,
                        arguments: TypeOfPolicy.termsAndConditions,
                      ),
                      child: CommonWidget.commonText(
                        text: TranslationConstants.faqs.translate(context),
                        style: Theme.of(context).textTheme.captionBoldHeading.copyWith(
                              decoration: TextDecoration.underline,
                              color: appConstants.default4Color,
                              decorationColor: appConstants.default4Color,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
