import 'package:captain_score/features/news/data/models/news_data_model.dart';
import 'package:captain_score/features/news/presentation/pages/news_screen.dart';
import 'package:captain_score/shared/common_widgets/common_widget.dart';
import 'package:captain_score/shared/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

abstract class NewsWidget extends State<NewsScreen> {
  int? selected;

  Widget newsContainer(int index) {
    return CommonWidget.container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      color: appConstants.whiteBackgroundColor,
      borderRadius: 10.r,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              newsList[index].image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10.w),
          CommonWidget.commonText(
            text: newsList[index].title,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 5.w),
          CommonWidget.commonText(
            text: newsList[index].description,
            fontSize: 10,
            color: appConstants.greyTextColor,
          ),
        ],
      ),
    );
  }
}

List<NewsModel> newsList = [
  NewsModel(
    title: "Kuldeep, Axar in India squad for first two England Tests; Jurel earns maiden call-up",
    description:
        "Kuldeep Yadav and Axar Patel are back in India's spin-heavy squad for the first two home Tests against England. Mohammed Shami, who is working his way back from an ankle injury, is a notable absentee, though.Vice-captain Jasprit Bumrah, Mohammed Siraj, Mukesh Kumar and Avesh Khan make up the seam attack while R Ashwin and Ravindra Jadeja make up the spin attack along with Kuldeep and Axar.While Shami was optimistic about making a return for the England Tests, the selectors and the BCCI medical staff might have wanted to give him further rest as a precautionary move. The 33-year-old fast bowler has not played any competitive cricket since the ODI World Cup final in November last year.Dhruv Jurel, the Uttar Pradesh player, earned his maiden call-up to the India side - in any format - as the back-up keeper to KL Rahul, who had kept wickets in the two Tests in South Africa, and KS Bharat.",
    date: DateFormat('dd MMMM yyyy').format(DateTime.now()),
    image: "https://img1.hscicdn.com/image/upload/f_auto,t_ds_wide_w_1040/lsci/db/PICTURES/CMS/361300/361324.6.jpg",
  ),
  NewsModel(
    title: "Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod",
    description:
        "Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief. Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit",
    date: DateFormat('dd MMMM yyyy').format(DateTime.now()),
    image: "https://img1.hscicdn.com/image/upload/f_auto,t_ds_wide_w_1040/lsci/db/PICTURES/CMS/368700/368738.6.jpg",
  ),
  NewsModel(
    title: "Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod",
    description:
        "Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief. Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit",
    date: DateFormat('dd MMMM yyyy').format(DateTime.now()),
    image: "https://img1.hscicdn.com/image/upload/f_auto,t_ds_w_960/lsci/db/PICTURES/CMS/373900/373929.3.png",
  ),
  NewsModel(
    title: "Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod",
    description:
        "Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief. Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit",
    date: DateFormat('dd MMMM yyyy').format(DateTime.now()),
    image: "https://img1.hscicdn.com/image/upload/f_auto,t_ds_wide_w_1040/lsci/db/PICTURES/CMS/368700/368738.6.jpg",
  ),
  NewsModel(
    title: "Kuldeep, Axar in India squad for first two England Tests; Jurel earns maiden call-up",
    description:
        "Kuldeep Yadav and Axar Patel are back in India's spin-heavy squad for the first two home Tests against England. Mohammed Shami, who is working his way back from an ankle injury, is a notable absentee, though.Vice-captain Jasprit Bumrah, Mohammed Siraj, Mukesh Kumar and Avesh Khan make up the seam attack while R Ashwin and Ravindra Jadeja make up the spin attack along with Kuldeep and Axar.While Shami was optimistic about making a return for the England Tests, the selectors and the BCCI medical staff might have wanted to give him further rest as a precautionary move. The 33-year-old fast bowler has not played any competitive cricket since the ODI World Cup final in November last year.Dhruv Jurel, the Uttar Pradesh player, earned his maiden call-up to the India side - in any format - as the back-up keeper to KL Rahul, who had kept wickets in the two Tests in South Africa, and KS Bharat.",
    date: DateFormat('dd MMMM yyyy').format(DateTime.now()),
    image: "https://img1.hscicdn.com/image/upload/f_auto,t_ds_wide_w_1040/lsci/db/PICTURES/CMS/361300/361324.6.jpg",
  ),
  NewsModel(
    title: "Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod",
    description:
        "Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief. Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit",
    date: DateFormat('dd MMMM yyyy').format(DateTime.now()),
    image: "https://img1.hscicdn.com/image/upload/f_auto,t_ds_wide_w_1040/lsci/db/PICTURES/CMS/368700/368738.6.jpg",
  ),
  NewsModel(
    title: "Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod",
    description:
        "Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief. Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit",
    date: DateFormat('dd MMMM yyyy').format(DateTime.now()),
    image: "https://img1.hscicdn.com/image/upload/f_auto,t_ds_w_960/lsci/db/PICTURES/CMS/373900/373929.3.png",
  ),
  NewsModel(
    title: "Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod",
    description:
        "Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief. Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit, sed do eiusmod is simply dummy text do eiusmod is simply dummy text of the printing it contrary to popular belief.Lorem ipsum dolor sit amet, consectet adipiscing elit",
    date: DateFormat('dd MMMM yyyy').format(DateTime.now()),
    image: "https://img1.hscicdn.com/image/upload/f_auto,t_ds_wide_w_1040/lsci/db/PICTURES/CMS/368700/368738.6.jpg",
  ),
];
