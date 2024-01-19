import 'package:captain_score/features/news/presentation/pages/news_widget.dart';
import 'package:captain_score/features/news/presentation/widgets/common_news_widget.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends NewsWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appConstants.greyBackgroundColor,
      appBar: AppBar(
        flexibleSpace: CommonWidget.commonLinearGradient(),
        automaticallyImplyLeading: false,
        title: CommonWidget.commonText(
          text: "News",
          color: appConstants.whiteBackgroundColor,
          fontSize: 23,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            children: [
              ListView.builder(
                itemCount: newsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
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
