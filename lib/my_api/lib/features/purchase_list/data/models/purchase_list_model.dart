class PurchaseModel {
  final String supplierName;
  final String orderId;
  final String orderDate;
  final List<ProductDescModel> productList;
  final String discount;
  final String totalAmount;
  final String gstText;
  final String gstAmount;
  final String payAmount;
  final String pendingAmount;
  bool deliveryStatus;
  final int id;

  PurchaseModel({
    required this.id,
    required this.supplierName,
    required this.orderId,
    required this.orderDate,
    required this.productList,
    required this.deliveryStatus,
    required this.discount,
    required this.gstAmount,
    required this.gstText,
    required this.payAmount,
    required this.totalAmount,
    required this.pendingAmount,
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

List<PurchaseModel> purchaseList = [
  PurchaseModel(
      id: 1,
      supplierName: "Nirali Soni",
      orderId: "58426875007",
      orderDate: "15/10/2023",
      productList: [
        ProductDescModel(
          productName: "Black Forest",
          productQuanitiy: "500gm (4)",
          productPrice: "₹900",
        ),
        ProductDescModel(
          productName: "Brown Breads",
          productQuanitiy: "1Kg (2)",
          productPrice: "₹290",
        ),
      ],
      discount: "₹30",
      gstAmount: "₹180",
      gstText: "18%",
      payAmount: "₹500",
      totalAmount: "₹1305",
      deliveryStatus: true,
      pendingAmount: "₹690"),
  PurchaseModel(
    id: 2,
    supplierName: "Nirali Soni",
    orderId: "58426875007",
    orderDate: "15/10/2023",
    productList: [
      ProductDescModel(
        productName: "Black Forest",
        productQuanitiy: "500gm (4)",
        productPrice: "₹900",
      ),
      ProductDescModel(
        productName: "Brown Breads",
        productQuanitiy: "1Kg (2)",
        productPrice: "₹290",
      ),
    ],
    discount: "₹30",
    gstAmount: "₹180",
    gstText: "18%",
    payAmount: "₹500",
    totalAmount: "₹1305",
    deliveryStatus: false,
    pendingAmount: "₹690",
  ),
    PurchaseModel(
    id: 3,
    supplierName: "Nirali Soni",
    orderId: "58426875007",
    orderDate: "15/10/2023",
    productList: [
      ProductDescModel(
        productName: "Black Forest",
        productQuanitiy: "500gm (4)",
        productPrice: "₹900",
      ),
      ProductDescModel(
        productName: "Brown Breads",
        productQuanitiy: "1Kg (2)",
        productPrice: "₹290",
      ),
    ],
    discount: "₹30",
    gstAmount: "₹180",
    gstText: "18%",
    payAmount: "₹500",
    totalAmount: "₹1305",
    deliveryStatus: false,
    pendingAmount: "₹690",
  ),
    PurchaseModel(
    id: 4,
    supplierName: "Nirali Soni",
    orderId: "58426875007",
    orderDate: "15/10/2023",
    productList: [
      ProductDescModel(
        productName: "Black Forest",
        productQuanitiy: "500gm (4)",
        productPrice: "₹900",
      ),
      ProductDescModel(
        productName: "Brown Breads",
        productQuanitiy: "1Kg (2)",
        productPrice: "₹290",
      ),
    ],
    discount: "₹30",
    gstAmount: "₹180",
    gstText: "18%",
    payAmount: "₹500",
    totalAmount: "₹1305",
    deliveryStatus: false,
    pendingAmount: "₹690",
  ),
    PurchaseModel(
    id: 5,
    supplierName: "Nirali Soni",
    orderId: "58426875007",
    orderDate: "15/10/2023",
    productList: [
      ProductDescModel(
        productName: "Black Forest",
        productQuanitiy: "500gm (4)",
        productPrice: "₹900",
      ),
      ProductDescModel(
        productName: "Brown Breads",
        productQuanitiy: "1Kg (2)",
        productPrice: "₹290",
      ),
    ],
    discount: "₹30",
    gstAmount: "₹180",
    gstText: "18%",
    payAmount: "₹500",
    totalAmount: "₹1305",
    deliveryStatus: false,
    pendingAmount: "₹690",
  )
];
