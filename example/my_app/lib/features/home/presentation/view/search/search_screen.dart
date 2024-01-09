import 'package:bakery_shop_flutter/global.dart';
import 'package:bakery_shop_flutter/features/home/presentation/view/search/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends SearchWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appConstants.greyBackgroundColor,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                children: [
                  categoryView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
