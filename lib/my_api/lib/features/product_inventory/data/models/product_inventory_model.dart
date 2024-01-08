class ProductInventoryModel {
  final int? id;
  final String? orderId;
  final String? orderDate;
  final String? buyingPrice;
  final String? gstText;
  final String? gstAmount;
  final String? productName;
  final String? productwait;
  final String? stock;
  

  ProductInventoryModel({
   this.id,
   this.orderId,
   this.orderDate,
   this.gstAmount,
   this.gstText,
   this.buyingPrice,
   this.productName,
   this.productwait,
   this.stock,
  });
}

List<ProductInventoryModel> productInventoryList = [
  ProductInventoryModel(
    id: 1,
    orderId: "58426875007",
    orderDate: "15/10/2023",
    gstAmount: "₹180",
    gstText: "18%",
    buyingPrice: "₹1305",
    productName: "Brown Breads",
    productwait: "500gm",
    stock: "100",
  ),
  ProductInventoryModel(
    id: 2,
    orderId: "58426875070",
    orderDate: "15/10/2023",
    gstAmount: "₹180",
    gstText: "18%",
    buyingPrice: "₹1305",
    productName: "Cookies",
    productwait: "500gm",
    stock: "100",
  )
];
