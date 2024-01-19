import 'package:captain_score/common/constants/common_router.dart';
import 'package:captain_score/common/constants/route_list.dart';
import 'package:captain_score/common/constants/translation_constants.dart';
import 'package:captain_score/common/extention/string_extension.dart';
import 'package:captain_score/di/get_it.dart';
import 'package:captain_score/features/home_screen/presentation/pages/home_screen.dart';
import 'package:captain_score/features/home_screen/presentation/widgets/common_home_widget.dart';
import 'package:captain_score/features/news/presentation/pages/news_widget.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/cubit/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:captain_score/shared/cubit/counter/counter_cubit.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class HomeWidget extends State<HomePage> {
  late CounterCubit counterCubit;

  @override
  void initState() {
    counterCubit = getItInstance<CounterCubit>();
    super.initState();
  }

  @override
  void dispose() {
    counterCubit.close();
    super.dispose();
  }

  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      flexibleSpace: CommonWidget.commonLinearGradient(),
      automaticallyImplyLeading: false,
      title: CommonWidget.commonText(
        text: TranslationConstants.captain_score.translate(context),
        fontSize: 23,
        color: appConstants.whiteBackgroundColor,
        fontWeight: FontWeight.w600,
      ),
      bottom: TabBar(
        indicatorColor: appConstants.whiteBackgroundColor,
        indicatorSize: TabBarIndicatorSize.tab,
        overlayColor: MaterialStateProperty.all(appConstants.transparent),
        tabs: [
          Tab(
            child: CommonWidget.commonText(
              text: TranslationConstants.home.translate(context).toUpperCase(),
              fontSize: 18,
              color: appConstants.whiteBackgroundColor,
            ),
          ),
          Tab(
            child: CommonWidget.commonText(
              text: TranslationConstants.live.translate(context).toUpperCase(),
              fontSize: 18,
              color: appConstants.whiteBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget homeView(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(8.r),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: 5,
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 0.95,
              initialPage: 0,
              autoPlayCurve: Curves.easeInOut,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              onPageChanged: (index, reason) => counterCubit.chanagePageIndex(index: index),
            ),
            itemBuilder: (ctx, index, realIdx) {
              return GestureDetector(
                onTap: () => CommonRouter.pushNamed(RouteList.score_screen),
                child: CommonWidget.container(
                  alignment: Alignment.center,
                  borderRadius: 15.r,
                  child: CommonHomeWidget.commonScoreDetailBox(context: context),
                ),
              );
            },
          ),
          BlocBuilder<CounterCubit, int>(
            bloc: counterCubit,
            builder: (context, counterState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: counterState == index
                        ? SizedBox(
                            height: 8.h,
                            width: 18.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.r),
                              child: CommonWidget.commonLinearGradient(),
                            ),
                          )
                        : Container(
                            height: 8.h,
                            width: 8.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: counterState == index ? appConstants.primary1Color : appConstants.default7Color,
                            ),
                          ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20.h),
          commontitle(
            text: TranslationConstants.trending_series.translate(context),
            isviewText: true,
            onTapMoreView: () => BlocProvider.of<BottomNavigationCubit>(context).changedBottomNavigation(2),
          ),
          commonTrendingSeriesBox(),
          SizedBox(height: 10.h),
          commontitle(text: TranslationConstants.featured_videos.translate(context)),
          featuredVideosList(),
          SizedBox(height: 10.h),
          commontitle(text: TranslationConstants.suggested_shorts.translate(context)),
          suggestedShortsList(),
          SizedBox(height: 10.h),
          commontitle(text: TranslationConstants.top_stories.translate(context)),
          topStoriesList(),
        ],
      ),
    );
  }

  Widget topStoriesList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.r),
      child: CommonWidget.container(
        
        borderRadius: 8.r,
        color: appConstants.whiteBackgroundColor,
        child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            if (index % 3 == 0) {
              return GestureDetector(
                onTap: () => CommonRouter.pushNamed(RouteList.single_news_screen, arguments: newsList[index]),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.r),
                      child: Column(
                        children: [
                          CommonWidget.container(
                            height: 200.h,
                            width: 500.w,
                            borderRadius: 8.r,
                            color: appConstants.textColor,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: CommonWidget.imageBuilder(
                                imageUrl: newsList[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          CommonWidget.commonText(
                            text: newsList[index].title,
                            fontSize: 18,
                            bold: true,
                          ),
                          CommonWidget.commonText(
                            text: newsList[index].description,
                            fontSize: 12,
                            color: appConstants.greyTextColor,
                            maxLines: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.fromLTRB(10.w, 10.h, 0, 10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.container(
                      height: 90.r,
                      width: 110.r,
                      borderRadius: 20.r,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Image.network(
                          "https://c.ndtvimg.com/2023-08/udvef5t8_virat-kohli-806_625x300_18_August_23.jpg?im=FeatureCrop,algorithm=dnn,width=806,height=605",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonWidget.commonText(
                            text: "Lorem ipsum dolor sit amet dum\nsed do eiusmod  ",
                            bold: true,
                          ),
                          CommonWidget.commonText(
                            text: "Lorem ipsum dolor sit amet, consectet ed\ndo dummy to it.",
                            fontSize: 12,
                            color: appConstants.greyTextColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(10.r),
              child: Divider(
                height: 10.h,
                color: appConstants.dividerColor,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget suggestedShortsList() {
    return SizedBox(
      height: 160.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => BlocProvider.of<BottomNavigationCubit>(context).changedBottomNavigation(1),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.r),
              width: 150,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://w0.peakpx.com/wallpaper/162/831/HD-wallpaper-virat-kohli-cricket-india-indian-cricketer-rcb.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.r),
                          bottomRight: Radius.circular(8.r),
                        ),
                        gradient: LinearGradient(
                          begin: const Alignment(0.00, -1.00),
                          end: const Alignment(0, 1),
                          colors: [appConstants.lightBlack.withOpacity(0), appConstants.lightBlack],
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.play_arrow,
                            color: appConstants.whiteBackgroundColor,
                          ),
                          SizedBox(width: 5.w),
                          Expanded(
                            child: CommonWidget.commonText(
                              text: "Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit",
                              fontSize: 10,
                              color: appConstants.whiteBackgroundColor,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget featuredVideosList() {
    return SizedBox(
      height: 140.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 210,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.h),
              child: GestureDetector(
                onTap: () async {
                  Uri url = Uri.parse('https://www.youtube.com/watch?v=WQdqgrWvy6g');
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CommonWidget.imageBuilder(
                          imageUrl:
                              "https://c.ndtvimg.com/2022-11/jsjh3gbc_virat-kohli-ani-650_625x300_11_November_22.jpg?im=FaceCrop,algorithm=dnn,width=806,height=605",
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.r),
                            bottomRight: Radius.circular(8.r),
                          ),
                          gradient: LinearGradient(
                            begin: const Alignment(0.00, -1.00),
                            end: const Alignment(0, 1),
                            colors: [appConstants.lightBlack.withOpacity(0), appConstants.lightBlack],
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.play_arrow,
                              color: appConstants.whiteBackgroundColor,
                            ),
                            SizedBox(width: 5.w),
                            Expanded(
                              child: CommonWidget.commonText(
                                text: "Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit",
                                fontSize: 10,
                                color: appConstants.whiteBackgroundColor,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget liveView(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: ListView.builder(
        itemCount: 10,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => CommonRouter.pushNamed(RouteList.score_screen),
            child: CommonHomeWidget.commonScoreDetailBox(context: context),
          );
        },
      ),
    );
  }

  Widget commontitle({
    bool isviewText = false,
    required text,
    VoidCallback? onTapMoreView,
  }) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Row(
        children: [
          CommonWidget.commonPoint(),
          SizedBox(width: 5.w),
          Expanded(
            child: CommonWidget.commonText(
              text: text,
              fontSize: 20,
              bold: true,
            ),
          ),
          Visibility(
            visible: isviewText,
            child: GestureDetector(
              onTap: onTapMoreView,
              child: CommonWidget.commonText(
                text: TranslationConstants.view_more.translate(context),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: appConstants.greyTextColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget commonTrendingSeriesBox() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: ListView.builder(
        itemCount: 2,
        physics: const NeverScrollableScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: GestureDetector(
              onTap: () => BlocProvider.of<BottomNavigationCubit>(context).changedBottomNavigation(2),
              child: CommonWidget.container(
                padding: EdgeInsets.all(10.r),
                borderRadius: 8.r,
                color: appConstants.whiteBackgroundColor,
                child: Row(
                  children: [
                    CommonWidget.container(
                      height: 60.r,
                      width: 75.r,
                      borderRadius: 8.r,
                      color: appConstants.greyColor1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.network(
                          'https://images.pexels.com/photos/3628912/pexels-photo-3628912.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w, top: 5.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonWidget.commonText(
                              text: "Big Bash League 2023-2024 ",
                              fontSize: 15,
                            ),
                            SizedBox(height: 5.h),
                            CommonWidget.commonText(
                              text: "44 Matches . 07 Dec - 24 Jan 2024",
                              fontSize: 12,
                              color: appConstants.greyTextColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                      color: appConstants.textColor,
                    )
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
