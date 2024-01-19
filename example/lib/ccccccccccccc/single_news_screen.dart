import 'package:captain_score/common/constants/common_router.dart';
import 'package:captain_score/common/constants/route_list.dart';
import 'package:captain_score/features/news/data/models/news_data_model.dart';
import 'package:captain_score/features/news/presentation/pages/news_widget.dart';
import 'package:captain_score/features/news/presentation/widgets/common_news_widget.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleNewsScreen extends StatefulWidget {
  final NewsModel newsModel;
  const SingleNewsScreen({super.key, required this.newsModel});

  @override
  State<SingleNewsScreen> createState() => _SingleNewsScreenState();
}

class _SingleNewsScreenState extends State<SingleNewsScreen> {
  late NewsModel newsModel;
  @override
  void initState() {
    newsModel = widget.newsModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        CommonRouter.pushReplacementNamed(RouteList.app_home);
      },
      child: Scaffold(
        backgroundColor: appConstants.greyBackgroundColor,
        appBar: AppBar(
          flexibleSpace: CommonWidget.commonLinearGradient(),
          centerTitle: true,
          title: CommonWidget.commonText(
            text: "News",
            color: appConstants.whiteBackgroundColor,
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
          leading: InkWell(
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            onTap: () => CommonRouter.pushReplacementNamed(RouteList.app_home),
            child: const Icon(Icons.arrow_back),
          ),
          iconTheme: IconThemeData(color: appConstants.whiteBackgroundColor),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().screenWidth * 0.6,
                child: CommonWidget.imageBuilder(
                  imageUrl: newsModel.image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidget.commonText(
                      text: newsModel.title,
                      color: appConstants.textColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                    CommonWidget.sizedBox(height: 10),
                    CommonWidget.commonText(
                      text: newsModel.date,
                      color: appConstants.greyTextColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    CommonWidget.sizedBox(height: 10),
                    CommonWidget.commonText(
                      text: newsModel.description,
                      color: appConstants.textColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              ListView.builder(
                itemCount: newsList.length,
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return CommonNewsWidget.newsRow(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
