// ignore_for_file: constant_identifier_names

enum OrderPaymentMethod { Cash, Upi, CreditCard }

enum OrderPaid { Paid, Unpaid }

enum OrderDeliveryStatus { Pending, Delivered, CustomerCancel, RejectOrder, ReturnOrder }

enum CustomerType { customer, supplier, supplierReturnList }

class OrderHistoryModel {
  final String customerName;
  final String orderId;
  final String orderDate;
  final String address;
  final List<ProductDescModel> productList;
  final AmountStatusModel amountDetailList;
  final CustomerType customerType;

  OrderHistoryModel({
    required this.customerName,
    required this.orderId,
    required this.orderDate,
    required this.address,
    required this.productList,
    required this.amountDetailList,
    required this.customerType,
  });
}

class ProductDescModel {
  final String productName;
  final String productQuanitiy;
  final String productPrice;

  ProductDescModel({
    required this.productName,
    required this.productQuanitiy,
    required this.productPrice,
  });
}

class AmountStatusModel {
  String? totalAmount;
  String? balance;
  String? returnItemAmount;
  String? settlementStatus;
  OrderPaid? orderPaid;
  OrderPaymentMethod? paymentStatus;
  OrderDeliveryStatus? deliveryStatus;

  AmountStatusModel({
    this.totalAmount,
    this.balance,
    this.paymentStatus,
    this.deliveryStatus,
    this.returnItemAmount,
    this.settlementStatus,
    this.orderPaid,
  });
}

List<OrderHistoryModel> listOfOrder = [
  OrderHistoryModel(
    customerName: "1Karan Parekh",
    orderId: "58426853641",
    orderDate: "08/12/2023",
    address: "4012, palladium Mall, Yogi Chowk,Surat-395010.",
    customerType: CustomerType.customer,
    amountDetailList: AmountStatusModel(
      orderPaid: OrderPaid.Paid,
      paymentStatus: OrderPaymentMethod.Cash,
      deliveryStatus: OrderDeliveryStatus.Delivered,
      balance: "₹10,000",
      totalAmount: "200",
    ),
    productList: [
      ProductDescModel(
        productName: "Premium Black Forest",
        productQuanitiy: "(2) 500gm",
        productPrice: "₹500",
      ),
    ],
  ),
  OrderHistoryModel(
    customerName: "14Karan Parekh",
    orderId: "58426853641",
    orderDate: "8/12/2023",
    address: "4012, palladium Mall, Yogi Chowk,Surat-395010.",
    customerType: CustomerType.customer,
    amountDetailList: AmountStatusModel(
      orderPaid: OrderPaid.Unpaid,
      balance: "₹10,000",
      totalAmount: "200",
    ),
    productList: [
      ProductDescModel(
        productName: "Premium Black Forest",
        productQuanitiy: "(2) 500gm",
        productPrice: "₹500",
      ),
    ],
  ),
  OrderHistoryModel(
    customerName: "2Karan Parekh",
    orderId: "58426853641",
    orderDate: "11/12/2023",
    address: "4012, palladium Mall, Yogi Chowk,Surat-395010.",
    customerType: CustomerType.customer,
    amountDetailList: AmountStatusModel(
      orderPaid: OrderPaid.Paid,
      paymentStatus: OrderPaymentMethod.CreditCard,
      deliveryStatus: OrderDeliveryStatus.Delivered,
      balance: "₹10,000",
      totalAmount: "200",
    ),
    productList: [
      ProductDescModel(
        productName: "Premium Black Forest",
        productQuanitiy: "(2) 500gm",
        productPrice: "₹500",
      ),
    ],
  ),
  OrderHistoryModel(
    customerName: "3Karan Parekh",
    orderId: "58426853641",
    orderDate: "11/12/2023",
    address: "4012, palladium Mall, Yogi Chowk,Surat-395010.",
    customerType: CustomerType.customer,
    amountDetailList: AmountStatusModel(
      orderPaid: OrderPaid.Paid,
      paymentStatus: OrderPaymentMethod.Upi,
      deliveryStatus: OrderDeliveryStatus.CustomerCancel,
      balance: "₹10,000",
      totalAmount: "200",
    ),
    productList: [
      ProductDescModel(
        productName: "Premium Black Forest",
        productQuanitiy: "(2) 500gm",
        productPrice: "₹500",
      ),
    ],
  ),
  OrderHistoryModel(
    customerName: "4Karan Parekh",
    orderId: "58426853641",
    orderDate: "11/12/2023",
    address: "4012, palladium Mall, Yogi Chowk,Surat-395010.",
    customerType: CustomerType.customer,
    amountDetailList: AmountStatusModel(
      orderPaid: OrderPaid.Paid,
      paymentStatus: OrderPaymentMethod.Upi,
      deliveryStatus: OrderDeliveryStatus.RejectOrder,
      balance: "₹10,000",
      totalAmount: "200",
    ),
    productList: [
      ProductDescModel(
        productName: "Premium Black Forest",
        productQuanitiy: "(2) 500gm",
        productPrice: "₹500",
      ),
    ],
  ),
  OrderHistoryModel(
    customerName: "5Karan Parekh",
    orderId: "58426853641",
    orderDate: "15/10/2023",
    address: "4012, palladium Mall, Yogi Chowk,Surat-395010.",
    customerType: CustomerType.customer,
    amountDetailList: AmountStatusModel(
      orderPaid: OrderPaid.Paid,
      paymentStatus: OrderPaymentMethod.Upi,
      deliveryStatus: OrderDeliveryStatus.ReturnOrder,
      balance: "₹10,000",
      totalAmount: "550",
    ),
    productList: [
      ProductDescModel(
        productName: "Premium Black Forest",
        productQuanitiy: "(2) 500gm",
        productPrice: "₹500",
      ),
    ],
  ),
  OrderHistoryModel(
    customerName: "6Karan Parekh",
    orderId: "58426853641",
    orderDate: "25/12/2023",
    address: "4012, palladium Mall, Yogi Chowk,Surat-395010.",
    customerType: CustomerType.customer,
    amountDetailList: AmountStatusModel(
      orderPaid: OrderPaid.Unpaid,
      balance: "₹10,000",
      totalAmount: "200",
    ),
    productList: [
      ProductDescModel(
        productName: "Premium Black Forest",
        productQuanitiy: "(2) 500gm",
        productPrice: "₹500",
      ),
    ],
  ),
  OrderHistoryModel(
    customerName: "7Karan Parekh",
    orderId: "58426853641",
    orderDate: "08/11/2023",
    address: "4012, palladium Mall, Yogi Chowk,Surat-395010.",
    customerType: CustomerType.customer,
    amountDetailList: AmountStatusModel(
      orderPaid: OrderPaid.Paid,
      paymentStatus: OrderPaymentMethod.Cash,
      deliveryStatus: OrderDeliveryStatus.Pending,
      balance: "₹10,000",
      totalAmount: "200",
    ),
    productList: [
      ProductDescModel(
        productName: "Premium Black Forest",
        productQuanitiy: "(2) 500gm",
        productPrice: "₹500",
      ),
    ],
  ),
  // supplier
  OrderHistoryModel(
    customerName: "8Karan Parekh",
    orderId: "58426853641",
    orderDate: "15/10/2023",
    address: "4012, palladium Mall, Yogi Chowk,Surat-395010.",
    customerType: CustomerType.supplier,
    amountDetailList: AmountStatusModel(
      orderPaid: OrderPaid.Paid,
      paymentStatus: OrderPaymentMethod.Cash,
      deliveryStatus: OrderDeliveryStatus.Pending,
      balance: "₹10,000",
      totalAmount: "200",
    ),
    productList: [
      ProductDescModel(
        productName: "Premium Black Forest",
        productQuanitiy: "(2) 500gm",
        productPrice: "₹500",
      ),
    ],
  ),
  OrderHistoryModel(
    customerName: "9Karan Parekh",
    orderId: "58426853641",
    orderDate: "15/10/2023",
    address: "4012, palladium Mall, Yogi Chowk,Surat-395010.",
    customerType: CustomerType.supplier,
    amountDetailList: AmountStatusModel(
      orderPaid: OrderPaid.Paid,
      paymentStatus: OrderPaymentMethod.CreditCard,
      deliveryStatus: OrderDeliveryStatus.Delivered,
      balance: "₹10,000",
      totalAmount: "200",
    ),
    productList: [
      ProductDescModel(
        productName: "Premium Black Forest",
        productQuanitiy: "(2) 500gm",
        productPrice: "₹500",
      ),
    ],
  ),
  OrderHistoryModel(
    customerName: "10Karan Parekh",
    orderId: "58426853641",
    orderDate: "15/10/2023",
    address: "4012, palladium Mall, Yogi Chowk,Surat-395010.",
    customerType: CustomerType.supplier,
    amountDetailList: AmountStatusModel(
      orderPaid: OrderPaid.Paid,
      paymentStatus: OrderPaymentMethod.Upi,
      deliveryStatus: OrderDeliveryStatus.CustomerCancel,
      balance: "₹10,000",
      totalAmount: "200",
    ),
    productList: [
      ProductDescModel(
        productName: "Premium Black Forest",
        productQuanitiy: "(2) 500gm",
        productPrice: "₹500",
      ),
    ],
  ),
  OrderHistoryModel(
    customerName: "11Karan Parekh",
    orderId: "58426853641",
    orderDate: "15/10/2023",
    address: "4012, palladium Mall, Yogi Chowk,Surat-395010.",
    customerType: CustomerType.supplier,
    amountDetailList: AmountStatusModel(
      orderPaid: OrderPaid.Paid,
      paymentStatus: OrderPaymentMethod.Upi,
      deliveryStatus: OrderDeliveryStatus.RejectOrder,
      balance: "₹10,000",
      totalAmount: "200",
    ),
    productList: [
      ProductDescModel(
        productName: "Premium Black Forest",
        productQuanitiy: "(2) 500gm",
        productPrice: "₹500",
      ),
    ],
  ),
  OrderHistoryModel(
    customerName: "12Karan Parekh",
    orderId: "58426853641",
    orderDate: "15/10/2023",
    address: "4012, palladium Mall, Yogi Chowk,Surat-395010.",
    customerType: CustomerType.supplier,
    amountDetailList: AmountStatusModel(
      orderPaid: OrderPaid.Paid,
      paymentStatus: OrderPaymentMethod.Upi,
      deliveryStatus: OrderDeliveryStatus.ReturnOrder,
      balance: "₹10,000",
      totalAmount: "200",
    ),
    productList: [
      ProductDescModel(
        productName: "Premium Black Forest",
        productQuanitiy: "(2) 500gm",
        productPrice: "₹500",
      ),
    ],
  ),
  OrderHistoryModel(
    customerName: "13Karan Parekh",
    orderId: "58426853641",
    orderDate: "15/10/2023",
    address: "4012, palladium Mall, Yogi Chowk,Surat-395010.",
    customerType: CustomerType.supplier,
    amountDetailList: AmountStatusModel(
      orderPaid: OrderPaid.Unpaid,
      balance: "₹10,000",
      totalAmount: "500",
    ),
    productList: [
      ProductDescModel(
        productName: "Premium Black Forest",
        productQuanitiy: "(2) 500gm",
        productPrice: "₹500",
      ),
    ],
  ),
];
