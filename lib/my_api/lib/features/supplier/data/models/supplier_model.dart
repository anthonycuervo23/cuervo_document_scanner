import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/order_history/data/model/order_history_model.dart';

class SupplierDetailModel {
  final int id;
  final String name;
  final String mobileNumber;
  final String email;
  final String? profileImage;
  final CustomerBalanceType? balanceType;
  final String dateTime;
  final String address;
  final String gstNo;
  final String panNo;
  final double? totalOrderAmount;
  final double? balance;
  final String? orderId;
  final String? orderDate;
  final int? gst;
  final double? gstAmount;
  final List<ProductDescModel> productList;
  final double? totalAmount;
  final AmountStatusModel? amountStatusModel;

  SupplierDetailModel(
      {required this.name,
      required this.id,
      required this.dateTime,
      required this.mobileNumber,
      required this.email,
      this.profileImage,
      this.balanceType,
      this.totalAmount,
      required this.address,
      required this.gstNo,
      required this.panNo,
      this.totalOrderAmount,
      this.balance,
      this.orderId,
      this.orderDate,
      this.gst,
      this.gstAmount,
      required this.productList,
      this.amountStatusModel});
}

class AmountStatusModel {
  OrderPaid? orderPaid;
  OrderPaymentMethod? paymentStatus;
  OrderDeliveryStatus? deliveryStatus;

  AmountStatusModel({
    this.paymentStatus,
    this.deliveryStatus,
    this.orderPaid,
  });
}

List<SupplierDetailModel> supplierList = [
  SupplierDetailModel(
    id: 1,
    name: "Nilesh Patel",
    dateTime: "06 Dec 2023 | 12:26 PM",
    mobileNumber: "+91 9876543210",
    email: "patelnilesh888@gmail.com",
    balanceType: CustomerBalanceType.ToPay,
    totalAmount: 750,
    profileImage:
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    address: "4012, palladium Mall, Yogi Chowk, Surat-395010.",
    gstNo: "24AAACH7409R2Z6",
    panNo: "PANXP2023X",
    totalOrderAmount: 10000,
    balance: 2000,
    orderId: "58426875007",
    orderDate: "15/10/2023",
    gst: 18,
    gstAmount: 135,
    productList: [
      ProductDescModel(productName: "Wheat flour", productQuanitiy: "500gm", productPrice: "₹500"),
      ProductDescModel(productName: "Sunflower oil", productQuanitiy: "1Ltr", productPrice: "₹250"),
    ],
    amountStatusModel: AmountStatusModel(
      deliveryStatus: OrderDeliveryStatus.Pending,
      orderPaid: OrderPaid.Paid,
      paymentStatus: OrderPaymentMethod.Upi,
    ),
  ),
  SupplierDetailModel(
    id: 2,
    name: "Jenil Patel",
    dateTime: "22 Nov 2023 | 12:26 PM",
    mobileNumber: "+91 9876543210",
    email: "patelnilesh888@gmail.com",
    balanceType: CustomerBalanceType.ToPay,
    totalAmount: 750,
    profileImage:
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    address: "4012, palladium Mall, Yogi Chowk, Surat-395010.",
    gstNo: "24AAACH7409R2Z6",
    panNo: "PANXP2023X",
    totalOrderAmount: 10000,
    balance: 2000,
    orderId: "58426875007",
    orderDate: "15/10/2023",
    gst: 18,
    gstAmount: 135,
    productList: [
      ProductDescModel(productName: "Wheat flour", productQuanitiy: "500gm", productPrice: "₹500"),
      ProductDescModel(productName: "Sunflower oil", productQuanitiy: "1Ltr", productPrice: "₹250"),
    ],
    amountStatusModel: AmountStatusModel(
      deliveryStatus: OrderDeliveryStatus.Pending,
      orderPaid: OrderPaid.Paid,
      paymentStatus: OrderPaymentMethod.Upi,
    ),
  ),
  SupplierDetailModel(
    id: 3,
    name: "Vijay",
    dateTime: "06 Oct 2023 | 12:26 PM",
    mobileNumber: "+91 9876543210",
    email: "patelnilesh888@gmail.com",
    balanceType: CustomerBalanceType.ToPay,
    totalAmount: 750,
    profileImage:
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    address: "4012, palladium Mall, Yogi Chowk, Surat-395010.",
    gstNo: "24AAACH7409R2Z6",
    panNo: "PANXP2023X",
    totalOrderAmount: 5000,
    balance: 2000,
    orderId: "58426875007",
    orderDate: "15/10/2023",
    gst: 18,
    gstAmount: 135,
    productList: [
      ProductDescModel(productName: "Wheat flour", productQuanitiy: "500gm", productPrice: "₹500"),
      ProductDescModel(productName: "Sunflower oil", productQuanitiy: "1Ltr", productPrice: "₹250"),
    ],
    amountStatusModel: AmountStatusModel(
      deliveryStatus: OrderDeliveryStatus.Pending,
      orderPaid: OrderPaid.Paid,
      paymentStatus: OrderPaymentMethod.Upi,
    ),
  ),
  SupplierDetailModel(
    id: 4,
    name: "Vivek",
    dateTime: "22 Nov 2023 | 12:26 PM",
    mobileNumber: "+91 9876543210",
    email: "patelnilesh888@gmail.com",
    balanceType: CustomerBalanceType.ToPay,
    totalAmount: 750,
    profileImage:
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    address: "4012, palladium Mall, Yogi Chowk, Surat-395010.",
    gstNo: "24AAACH7409R2Z6",
    panNo: "PANXP2023X",
    totalOrderAmount: 2000,
    balance: 2000,
    orderId: "58426875007",
    orderDate: "15/10/2023",
    gst: 18,
    gstAmount: 135,
    productList: [
      ProductDescModel(productName: "Wheat flour", productQuanitiy: "500gm", productPrice: "₹500"),
      ProductDescModel(productName: "Sunflower oil", productQuanitiy: "1Ltr", productPrice: "₹250"),
    ],
    amountStatusModel: AmountStatusModel(
      deliveryStatus: OrderDeliveryStatus.Pending,
      orderPaid: OrderPaid.Paid,
      paymentStatus: OrderPaymentMethod.Upi,
    ),
  ),
];
