// ignore_for_file: constant_identifier_names

import 'package:bakery_shop_admin_flutter/features/customer/presentation/cubit/create_customer_cubit/create_customer_cubit.dart';

enum CustomerType { New, Repeat, Loyal, Refer }

enum CustomerBalanceType { ToCollect, ToPay }

class CustomerDetailModel {
  final String name;
  final String emailAddress;
  final String mobileNumber;
  final String profileImage;
  final CustomerType customerType;
  final CustomerBalanceType customerBalanceType;
  final String date;
  final String time;
  final double balance;
  final String dateofBirth;
  final String anniversaryDate;
  final String referralCode;
  final int points;
  final double totalOrderAmount;
  final String gstNo;
  final String panNo;
  final List<ReferDetailModel> referList;
  final List<FamilyDetailModel> familyDetails;
  final List<OrderDetailModel> orders;
  final List<AddressData> address;
  final bool isPending;
  final CustomerBalanceType balanceType;

  CustomerDetailModel({
    required this.name,
    required this.emailAddress,
    required this.mobileNumber,
    required this.profileImage,
    required this.customerType,
    required this.customerBalanceType,
    required this.date,
    required this.time,
    required this.balance,
    required this.dateofBirth,
    required this.anniversaryDate,
    required this.referralCode,
    required this.points,
    required this.totalOrderAmount,
    required this.gstNo,
    required this.panNo,
    required this.referList,
    required this.familyDetails,
    required this.orders,
    required this.address,
    required this.isPending,
    required this.balanceType,
  });
}

class ReferDetailModel {
  final String name;
  final String mobileNo;
  final int level;
  final String date;
  final int point;
  final List<PointListModel> pointList;

  ReferDetailModel({
    required this.name,
    required this.mobileNo,
    required this.level,
    required this.date,
    required this.point,
    required this.pointList,
  });
}

class FamilyDetailModel {
  final String name;
  final String relationship;
  final String dateOfBirth;
  final String anniversaryDate;

  FamilyDetailModel({
    required this.name,
    required this.relationship,
    required this.dateOfBirth,
    required this.anniversaryDate,
  });
}

class OrderDetailModel {
  final String productName;
  final int quantity;
  final String quantityType;
  final String orderDataTime;
  final double price;
  final bool ispanding;

  OrderDetailModel({
    required this.productName,
    required this.quantity,
    required this.quantityType,
    required this.orderDataTime,
    required this.price,
    required this.ispanding,
  });
}

class AddressData {
  Addresstype addressType;
  String flatNo;
  String adddress;
  String landMark;

  AddressData({
    required this.addressType,
    required this.adddress,
    required this.flatNo,
    required this.landMark,
    required,
  });
}

class PointListModel {
  final String date;
  final int point;
  final String sources;
  PointListModel({required this.date, required this.point, required this.sources});
}

List<CustomerDetailModel> customerDetails = [
  CustomerDetailModel(
    balanceType: CustomerBalanceType.ToPay,
    isPending: true,
    name: 'C',
    emailAddress: 'karan01@gamil.com',
    mobileNumber: "+91 99999999",
    profileImage:
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    customerType: CustomerType.Repeat,
    customerBalanceType: CustomerBalanceType.ToPay,
    date: '06 Dec 2023 | 12:26 PM',
    balance: 1000,
    time: "12:23",
    dateofBirth: '12/05/1996',
    anniversaryDate: '19/02/2021',
    referralCode: '654575',
    points: 100,
    totalOrderAmount: 1000,
    gstNo: '24AAACH7409R2Z6',
    panNo: 'PANXP2023X',
    referList: [
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 1,
        date: "06 Dec 2023 | 12:26 PM",
        point: 20,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 2,
        date: "11/10/2023",
        point: 10,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "30/09/2023", point: 40, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
    ],
    familyDetails: [
      FamilyDetailModel(name: 'Mansi Parekh', relationship: 'Sister', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
    ],
    orders: [
      OrderDetailModel(
        productName: 'Premium Black Forest',
        quantity: 500,
        quantityType: 'gm',
        orderDataTime: '15 Oct 2023 | 02:22',
        price: 775,
        ispanding: true,
      ),
      OrderDetailModel(
        productName: 'Premium Black Forest',
        quantity: 500,
        quantityType: 'gm',
        orderDataTime: '15 Oct 2023 | 02:22',
        price: 775,
        ispanding: true,
      ),
    ],
    address: [
      AddressData(
          addressType: Addresstype.work,
          adddress: '4012, palladium Mall, Above -Dairy Don, Yogi Chowk,Puna Gam Surat-395010.',
          flatNo: "302",
          landMark: ""),
    ],
  ),
  CustomerDetailModel(
    balanceType: CustomerBalanceType.ToCollect,
    isPending: false,
    name: 'Cb',
    emailAddress: 'karan01@gamil.com',
    mobileNumber: "+91 99999999",
    profileImage:
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    customerType: CustomerType.Repeat,
    customerBalanceType: CustomerBalanceType.ToPay,
    date: '06 Dec 2023 | 12:26 PM',
    balance: 1000,
    time: "12:23",
    dateofBirth: '12/05/1996',
    anniversaryDate: '19/02/2021',
    referralCode: '654575',
    points: 100,
    totalOrderAmount: 1000,
    gstNo: '24AAACH7409R2Z6',
    panNo: 'PANXP2023X',
    referList: [
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 1,
        date: "09/10/2023",
        point: 20,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 2,
        date: "11/10/2023",
        point: 10,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "30/09/2023", point: 40, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
    ],
    familyDetails: [
      FamilyDetailModel(name: 'Mansi Parekh', relationship: 'Sister', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
    ],
    orders: [
      OrderDetailModel(
        productName: 'Premium Black Forest',
        quantity: 500,
        quantityType: 'gm',
        orderDataTime: '15 Oct 2023 | 02:22',
        price: 775,
        ispanding: true,
      ),
      OrderDetailModel(
        productName: 'Premium Black Forest',
        quantity: 500,
        quantityType: 'gm',
        orderDataTime: '15 Oct 2023 | 02:22',
        price: 775,
        ispanding: true,
      ),
    ],
    address: [
      AddressData(
        addressType: Addresstype.home,
        adddress: '4012, palladium Mall, Above -Dairy Don, Yogi Chowk,Puna Gam Surat-395010.',
        flatNo: "102",
        landMark: "Yogi chawk",
      ),
    ],
  ),
  CustomerDetailModel(
    balanceType: CustomerBalanceType.ToCollect,
    isPending: true,
    name: 'A',
    emailAddress: 'karan01@gamil.com',
    mobileNumber: "+91 99999999",
    profileImage:
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    customerType: CustomerType.Loyal,
    customerBalanceType: CustomerBalanceType.ToPay,
    date: '08 Dec 2023 | 12:59 PM',
    balance: 1000,
    time: "12:23",
    dateofBirth: '12/05/1996',
    anniversaryDate: '19/02/2021',
    referralCode: '654575',
    points: 100,
    totalOrderAmount: 900,
    gstNo: '24AAACH7409R2Z6',
    panNo: 'PANXP2023X',
    referList: [
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 1,
        date: "09/10/2023",
        point: 20,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 2,
        date: "11/10/2023",
        point: 10,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "30/09/2023", point: 40, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
    ],
    familyDetails: [
      FamilyDetailModel(name: 'Mansi Parekh', relationship: 'Sister', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
    ],
    orders: [
      OrderDetailModel(
        productName: 'Premium Black Forest',
        quantity: 500,
        quantityType: 'gm',
        orderDataTime: '15 Oct 2023 | 02:22',
        price: 775,
        ispanding: true,
      ),
      OrderDetailModel(
        productName: 'Premium Black Forest',
        quantity: 500,
        quantityType: 'gm',
        orderDataTime: '15 Oct 2023 | 02:22',
        price: 775,
        ispanding: true,
      ),
    ],
    address: [
      AddressData(
        addressType: Addresstype.home,
        adddress: '4012, palladium Mall, Above -Dairy Don, Yogi Chowk,Puna Gam Surat-395010.',
        flatNo: "101",
        landMark: "Archna",
      ),
    ],
  ),
  CustomerDetailModel(
    balanceType: CustomerBalanceType.ToPay,
    isPending: true,
    name: 'A',
    emailAddress: 'karan01@gamil.com',
    mobileNumber: "+91 99999999",
    profileImage:
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    customerType: CustomerType.Repeat,
    customerBalanceType: CustomerBalanceType.ToPay,
    date: '16 Dec 2023 | 11:26 PM',
    balance: 1000,
    time: "12:23",
    dateofBirth: '12/05/1996',
    anniversaryDate: '19/02/2021',
    referralCode: '654575',
    points: 100,
    totalOrderAmount: 900,
    gstNo: '24AAACH7409R2Z6',
    panNo: 'PANXP2023X',
    referList: [
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 1,
        date: "09/10/2023",
        point: 20,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 2,
        date: "11/10/2023",
        point: 10,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "30/09/2023", point: 40, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
    ],
    familyDetails: [
      FamilyDetailModel(name: 'Mansi Parekh', relationship: 'Sister', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
    ],
    orders: [
      OrderDetailModel(
        productName: 'Premium Black Forest',
        quantity: 500,
        quantityType: 'gm',
        orderDataTime: '15 Oct 2023 | 02:22',
        price: 775,
        ispanding: true,
      ),
      OrderDetailModel(
        productName: 'Premium Black Forest',
        quantity: 500,
        quantityType: 'gm',
        orderDataTime: '15 Oct 2023 | 02:22',
        price: 775,
        ispanding: true,
      ),
    ],
    address: [
      AddressData(
          addressType: Addresstype.home,
          adddress: '4012, palladium Mall, Above -Dairy Don, Yogi Chowk,Puna Gam Surat-395010.',
          flatNo: "302",
          landMark: ""),
    ],
  ),
  CustomerDetailModel(
    balanceType: CustomerBalanceType.ToPay,
    isPending: false,
    name: 'D',
    emailAddress: 'karan01@gamil.com',
    mobileNumber: "+91 99999999",
    profileImage:
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    customerType: CustomerType.Refer,
    customerBalanceType: CustomerBalanceType.ToPay,
    date: '06 Dec 2023 | 12:26 PM',
    balance: 1000,
    time: "12:23",
    dateofBirth: '12/05/1996',
    anniversaryDate: '19/02/2021',
    referralCode: '654575',
    points: 100,
    totalOrderAmount: 9000,
    gstNo: '24AAACH7409R2Z6',
    panNo: 'PANXP2023X',
    referList: [
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 1,
        date: "09/10/2023",
        point: 20,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 2,
        date: "11/10/2023",
        point: 10,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "30/09/2023", point: 40, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
    ],
    familyDetails: [
      FamilyDetailModel(name: 'Mansi Parekh', relationship: 'Sister', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
    ],
    orders: [
      OrderDetailModel(
        productName: 'Premium Black Forest',
        quantity: 500,
        quantityType: 'gm',
        orderDataTime: '15 Oct 2023 | 02:22',
        price: 775,
        ispanding: true,
      ),
      OrderDetailModel(
        productName: 'Premium Black Forest',
        quantity: 500,
        quantityType: 'gm',
        orderDataTime: '15 Oct 2023 | 02:22',
        price: 775,
        ispanding: true,
      ),
    ],
    address: [
      AddressData(
          addressType: Addresstype.home,
          adddress: '4012, palladium Mall, Above -Dairy Don, Yogi Chowk,Puna Gam Surat-395010.',
          flatNo: "404",
          landMark: ""),
    ],
  ),
  CustomerDetailModel(
    balanceType: CustomerBalanceType.ToCollect,
    isPending: false,
    name: 'Ca',
    emailAddress: 'karan01@gamil.com',
    mobileNumber: "+91 99999999",
    profileImage:
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    customerType: CustomerType.Repeat,
    customerBalanceType: CustomerBalanceType.ToPay,
    date: '10 Dec 2023 | 3:06 PM',
    balance: 1000,
    time: "12:23",
    dateofBirth: '12/05/1996',
    anniversaryDate: '19/02/2021',
    referralCode: '654575',
    points: 100,
    totalOrderAmount: 1000,
    gstNo: '24AAACH7409R2Z6',
    panNo: 'PANXP2023X',
    referList: [
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 1,
        date: "09/10/2023",
        point: 20,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 2,
        date: "11/10/2023",
        point: 10,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "30/09/2023", point: 40, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
    ],
    familyDetails: [
      FamilyDetailModel(name: 'Mansi Parekh', relationship: 'Sister', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
    ],
    orders: [
      OrderDetailModel(
        productName: 'Premium Black Forest',
        quantity: 500,
        quantityType: 'gm',
        orderDataTime: '15 Oct 2023 | 02:22',
        price: 775,
        ispanding: true,
      ),
      OrderDetailModel(
        productName: 'Premium Black Forest',
        quantity: 500,
        quantityType: 'gm',
        orderDataTime: '15 Oct 2023 | 02:22',
        price: 775,
        ispanding: true,
      ),
    ],
    address: [
      AddressData(
          addressType: Addresstype.home,
          adddress: '4012, palladium Mall, Above -Dairy Don, Yogi Chowk,Puna Gam Surat-395010.',
          flatNo: "3",
          landMark: ""),
    ],
  ),
  CustomerDetailModel(
    balanceType: CustomerBalanceType.ToCollect,
    isPending: false,
    name: 'A',
    emailAddress: 'karan01@gamil.com',
    mobileNumber: "+91 99999999",
    profileImage:
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    customerType: CustomerType.New,
    customerBalanceType: CustomerBalanceType.ToCollect,
    date: '1 Dec 2023 | 2:26 PM',
    balance: 1000,
    time: "12:23",
    dateofBirth: '12/05/1996',
    anniversaryDate: '19/02/2021',
    referralCode: '654575',
    points: 100,
    totalOrderAmount: 900,
    gstNo: '24AAACH7409R2Z6',
    panNo: 'PANXP2023X',
    referList: [
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 1,
        date: "09/10/2023",
        point: 20,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 2,
        date: "11/10/2023",
        point: 10,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
          PointListModel(date: "30/09/2023", point: 40, sources: "Product Purchase"),
        ],
      ),
      ReferDetailModel(
        name: 'Sonakshi Dave',
        mobileNo: "XXXXXX4321",
        level: 4,
        date: "15/10/2023",
        point: 45,
        pointList: [
          PointListModel(date: "14/09/2023", point: 10, sources: "Product Purchase"),
          PointListModel(date: "22/09/2023", point: 40, sources: "Install"),
          PointListModel(date: "23/09/2023", point: 20, sources: "Product Purchase"),
        ],
      ),
    ],
    familyDetails: [
      FamilyDetailModel(name: 'Mansi Parekh', relationship: 'Sister', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
      FamilyDetailModel(name: 'Sahil Parekh', relationship: 'Brother', dateOfBirth: '20/11/1999', anniversaryDate: ''),
    ],
    orders: [
      OrderDetailModel(
        productName: 'Premium Black Forest',
        quantity: 500,
        quantityType: 'gm',
        orderDataTime: '15 Oct 2023 | 02:22',
        price: 775,
        ispanding: true,
      ),
      OrderDetailModel(
        productName: 'Premium Black Forest',
        quantity: 500,
        quantityType: 'gm',
        orderDataTime: '15 Oct 2023 | 02:22',
        price: 775,
        ispanding: true,
      ),
    ],
    address: [
      AddressData(
          addressType: Addresstype.home,
          adddress: '4012, palladium Mall, Above -Dairy Don, Yogi Chowk,Puna Gam Surat-395010.',
          flatNo: "E",
          landMark: ""),
    ],
  ),
];
