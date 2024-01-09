import 'package:bakery_shop_admin_flutter/di/get_it.dart';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/refer_list/presentation/view/refer_list_screen.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/search_filter_cubit/search_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/sort_filter_cubit/sort_filter_cubit.dart';
import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ReferListWidget extends State<ReferListScreen> {
  late List<ReferDetailModel> referData;
  late SearchFilterCubit searchFilterCubit;
  late CounterCubit counterCubit;
  late SortFilterCubit sortFilterCubit;

  @override
  void initState() {
    super.initState();
    searchFilterCubit = getItInstance<SearchFilterCubit>();
    counterCubit = getItInstance<CounterCubit>();
    sortFilterCubit = getItInstance<SortFilterCubit>();
    referData = widget.referData;
  }

  @override
  void dispose() {
    super.dispose();
    searchFilterCubit.close();
    counterCubit.close();
    sortFilterCubit.close();
  }

  Widget dataTable() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 16.h),
        child: CommonWidget.container(
          color: const Color.fromRGBO(240, 240, 240, 1),
          isBorder: true,
          borderRadius: 15.r,
          borderWidth: 1,
          borderColor: const Color.fromRGBO(240, 240, 240, 1),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Column(
              children: [
                Row(
                  children: [
                    tableTileRow(title: '#', width: 20.w),
                    Expanded(child: tableTileRow(title: 'Reg.Date')),
                    Expanded(child: tableTileRow(title: 'Name')),
                    Expanded(child: tableTileRow(title: 'Mobile\nNumber')),
                    tableTileRow(title: 'Level'),
                    tableTileRow(title: 'Point'),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: referData.length,
                    itemBuilder: (context, index) {
                      ReferDetailModel rederDatailModel = referData[index];
                      return Row(
                        children: [
                          tableDataBox(
                            rederDatailModel: rederDatailModel,
                            text: "${referData.indexOf(rederDatailModel) + 1}",
                            width: 20.w,
                          ),
                          Expanded(
                            child: tableDataBox(
                              rederDatailModel: rederDatailModel,
                              text: rederDatailModel.date.toString(),
                              padding: 5,
                            ),
                          ),
                          Expanded(
                            child: tableDataBox(
                              rederDatailModel: rederDatailModel,
                              text: rederDatailModel.name.toString(),
                              padding: 5,
                            ),
                          ),
                          Expanded(
                            child: tableDataBox(
                              rederDatailModel: rederDatailModel,
                              text: rederDatailModel.mobileNo.toString(),
                              padding: 5,
                            ),
                          ),
                          tableDataBox(
                            rederDatailModel: rederDatailModel,
                            text: rederDatailModel.level.toString(),
                          ),
                          tableDataBox(
                              rederDatailModel: rederDatailModel,
                              text: rederDatailModel.point.toString(),
                              textColor: const Color.fromRGBO(67, 146, 241, 1)),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tableDataBox({
    required ReferDetailModel rederDatailModel,
    required String text,
    double? width,
    double? padding,
    Color? textColor,
  }) {
    return containtBox(
      text: text,
      padding: padding,
      boxColor: appConstants.white,
      width: width ?? 35.w,
      textColor: textColor ?? appConstants.black,
      isOpenDialog: true,
      list: rederDatailModel.pointList,
    );
  }

  Widget tableTileRow({required String title, double? width}) {
    return containtBox(
      borderColor: appConstants.theme2Color,
      text: title,
      boxColor: appConstants.theme1Color,
      width: width ?? 35.w,
      isOpenDialog: true,
      textColor: appConstants.white,
    );
  }

  Widget containtBox({
    required Color boxColor,
    required String text,
    Color? borderColor,
    double? width,
    required Color textColor,
    List<PointListModel>? list,
    bool isOpenDialog = false,
    double? padding,
  }) {
    return CommonWidget.container(
      width: width,
      height: 40.h,
      isBorder: true,
      padding: EdgeInsets.only(left: padding ?? 0),
      borderColor: borderColor ?? const Color.fromRGBO(240, 240, 240, 1),
      borderWidth: 0.8,
      // isBorderOnlySide: true,
      color: boxColor,
      alignment: padding == null ? Alignment.center : Alignment.centerLeft,
      child: CommonWidget.commonText(
        color: textColor,
        fontSize: 10.sp,
        textAlign: TextAlign.center,
        text: text,
        maxLines: 2,
      ),
    );
  }
  // Widget buildTable() {
  //   return FittedBox(
  //     alignment: Alignment.center,
  //     child: DataTable(
  //       headingTextStyle: TextStyle(color: appConstants.white),
  //       headingRowColor: MaterialStatePropertyAll(appConstants.theme1Color),
  //       dataRowColor: MaterialStatePropertyAll(appConstants.white),
  //       columnSpacing: 0,
  //       horizontalMargin: 0,
  //       clipBehavior: Clip.antiAlias,
  //       border: TableBorder(borderRadius: BorderRadius.circular(10.r)),
  //       headingRowHeight: 50.h,
  //       columns: [
  //         DataColumn(
  //           label: containtBox(
  //             borderColor: const Color.fromRGBO(47, 101, 151, 1),
  //             text: "#",
  //             boxColor: appConstants.theme1Color,
  //             width: 20.w,
  //             textColor: appConstants.white,
  //           ),
  //         ),
  //         DataColumn(
  //           label: containtBox(
  //             borderColor: const Color.fromRGBO(47, 101, 151, 1),
  //             text: "Reg. Date",
  //             boxColor: appConstants.theme1Color,
  //             width: 55.w,
  //             textColor: appConstants.white,
  //           ),
  //         ),
  //         DataColumn(
  //           label: containtBox(
  //             borderColor: const Color.fromRGBO(47, 101, 151, 1),
  //             text: "Name",
  //             padding: 10.w,
  //             boxColor: appConstants.theme1Color,
  //             width: 80.w,
  //             textColor: appConstants.white,
  //           ),
  //         ),
  //         DataColumn(
  //           label: containtBox(
  //             borderColor: const Color.fromRGBO(47, 101, 151, 1),
  //             text: "Mobile Number",
  //             boxColor: appConstants.theme1Color,
  //             width: 65.w,
  //             textColor: appConstants.white,
  //           ),
  //         ),
  //         DataColumn(
  //           label: containtBox(
  //             borderColor: const Color.fromRGBO(47, 101, 151, 1),
  //             text: "Level",
  //             boxColor: appConstants.theme1Color,
  //             width: 50.w,
  //             textColor: appConstants.white,
  //           ),
  //         ),
  //         DataColumn(
  //           label: containtBox(
  //             borderColor: const Color.fromRGBO(47, 101, 151, 1),
  //             text: "Point",
  //             boxColor: appConstants.theme1Color,
  //             width: 35.w,
  //             textColor: appConstants.white,
  //           ),
  //         ),
  //       ],
  //       rows: referData
  //           .map(
  //             (e) => DataRow(
  //               cells: [
  //                 DataCell(
  //                   containtBox(
  //                     borderColor: const Color.fromRGBO(240, 240, 240, 1),
  //                     text: "${referData.indexOf(e) + 1}",
  //                     boxColor: appConstants.white,
  //                     width: 20.w,
  //                     isOpenDialog: true,
  //                     list: e.pointList,
  //                     textColor: appConstants.black,
  //                   ),
  //                 ),
  //                 DataCell(
  //                   containtBox(
  //                     borderColor: const Color.fromRGBO(240, 240, 240, 1),
  //                     text: e.date,
  //                     boxColor: appConstants.white,
  //                     width: 55.w,
  //                     isOpenDialog: true,
  //                     list: e.pointList,
  //                     textColor: appConstants.black,
  //                   ),
  //                 ),
  //                 DataCell(
  //                   containtBox(
  //                     borderColor: const Color.fromRGBO(240, 240, 240, 1),
  //                     text: e.name,
  //                     boxColor: appConstants.white,
  //                     width: 80.w,
  //                     isOpenDialog: true,
  //                     list: e.pointList,
  //                     textColor: appConstants.black,
  //                   ),
  //                 ),
  //                 DataCell(
  //                   containtBox(
  //                     borderColor: const Color.fromRGBO(240, 240, 240, 1),
  //                     text: e.mobileNo,
  //                     boxColor: appConstants.white,
  //                     width: 65.w,
  //                     isOpenDialog: true,
  //                     list: e.pointList,
  //                     textColor: appConstants.black,
  //                   ),
  //                 ),
  //                 DataCell(
  //                   containtBox(
  //                     borderColor: const Color.fromRGBO(240, 240, 240, 1),
  //                     text: e.level.toString(),
  //                     boxColor: appConstants.white,
  //                     textColor: appConstants.black,
  //                     isOpenDialog: true,
  //                     list: e.pointList,
  //                     width: 50.w,
  //                   ),
  //                 ),
  //                 DataCell(
  //                   containtBox(
  //                     borderColor: const Color.fromRGBO(240, 240, 240, 1),
  //                     text: e.point.toString(),
  //                     boxColor: appConstants.white,
  //                     width: 35.w,
  //                     isOpenDialog: true,
  //                     list: e.pointList,
  //                     textColor: appConstants.editbuttonColor,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           )
  //           .toList(),
  //     ),
  //   );
  // }

//   Widget containtBox({
//     required Color boxColor,
//     required String text,
//     Color? borderColor,
//     double? width,
//     required Color textColor,
//     List<PointListModel>? list,
//     bool isOpenDialog = false,
//     double? padding,
//   }) {
//     return CommonWidget.container(
//       width: width,
//       isBorder: true,
//       padding: EdgeInsets.only(left: padding ?? 0),
//       borderColor: borderColor,
//       borderWidth: 1,
//       isBorderOnlySide: true,
//       color: boxColor,
//       alignment: padding == null ? Alignment.center : Alignment.centerLeft,
//       child: CommonWidget.commonText(
//         color: textColor,
//         fontSize: 10.sp,
//         textAlign: TextAlign.center,
//         text: text,
//         maxLines: 2,
//       ),
//     );
//   }
// }
}
