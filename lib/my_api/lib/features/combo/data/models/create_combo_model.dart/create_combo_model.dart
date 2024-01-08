class CreateComboModel {
  String productName;
  int price;
  String weight;

  CreateComboModel({
    required this.productName,
    required this.price,
    required this.weight,
  });
}

List<CreateComboModel> createComboList = [
  CreateComboModel(productName: "Chocolate Cookies", price: 100, weight: "250 gm"),
  CreateComboModel(productName: "Salt Cookiessssss", price: 300, weight: "1kg"),
  CreateComboModel(productName: "Crunchy Delight Magic", price: 450, weight: "500 gm"),
  CreateComboModel(productName: "Salt Cookies", price: 200, weight: "250 gm"),
  CreateComboModel(productName: "Chocolate Cookies Cookies", price: 300, weight: "250 gm"),
  CreateComboModel(productName: "Premium Cookies", price: 150, weight: "1kg"),
  CreateComboModel(productName: "Crunchy Delight", price: 450, weight: "500 gm"),
  CreateComboModel(productName: "Salt Cookies Extra salty", price: 200, weight: "250 gm"),
];
