class ProductListModel {
  final String itemName;
  final String image;
  final String rating;
  final String sellingStatus;
  final String referralPoint;
  final String selfPoint;
  final String itemCount;
  final String price;
  final String discount;
  final String sellingPrice;
  final String hashtagCount;
  bool isActive;

  ProductListModel({
    required this.itemName,
    required this.image,
    required this.rating,
    required this.sellingStatus,
    required this.referralPoint,
    required this.selfPoint,
    required this.itemCount,
    required this.price,
    required this.discount,
    required this.sellingPrice,
    required this.hashtagCount,
    required this.isActive,
  });
}

List<ProductListModel> productModelList = [
  ProductListModel(
    itemName: "Premium Black Forest Cake",
    image:
        "https://img.freepik.com/free-photo/fruit-cake-with-chocolate-chips-blueberries_176474-2965.jpg?w=740&t=st=1700636472~exp=1700637072~hmac=2d6167f6ddbf21929b34966195a5466676993ea4849eb2da6d9309bdf1895b38",
    rating: "4.5 (350)",
    sellingStatus: "High",
    referralPoint: "5000",
    selfPoint: "10",
    itemCount: "Item(8)",
    price: "₹300",
    discount: "10%",
    sellingPrice: "₹270",
    hashtagCount: "#1",
    isActive: true,
  ),
  ProductListModel(
    itemName: "Brown Breads",
    image:
        "https://img.freepik.com/free-photo/front-view-whole-cut-dietary-black-bread-bowls-flower-pot-blue-maroon-colors-background_179666-47429.jpg?w=1380&t=st=1700636804~exp=1700637404~hmac=7fb73f662c08e428333bdd49aa776102cf08e5ddaa315789914c260bb7667104",
    rating: "4.5 (350)",
    sellingStatus: "Medium",
    referralPoint: "50",
    selfPoint: "10",
    itemCount: "Item(3)",
    price: "₹700",
    discount: "10%",
    sellingPrice: "₹630",
    hashtagCount: "#2",
    isActive: true,
  ),
  ProductListModel(
    itemName: "Chocolate Cookies",
    image:
        "https://img.freepik.com/free-photo/chocolate-chip-gluten-free-cookies_114579-12554.jpg?w=1380&t=st=1700636888~exp=1700637488~hmac=164b91382a0921618eb7f432c739742c7ba55f9e0aa9d3773597e0d91eb96d6e",
    rating: "4.5 (350)",
    sellingStatus: "High",
    referralPoint: "50",
    selfPoint: "10",
    itemCount: "Item(8)",
    price: "₹300",
    discount: "10%",
    sellingPrice: "₹270",
    hashtagCount: "#3",
    isActive: false,
  ),
  ProductListModel(
      itemName: "Blue Berry cake",
      image:
          "https://img.freepik.com/free-photo/close-up-fancy-dessert_23-2150527597.jpg?t=st=1700636957~exp=1700640557~hmac=300449fd83b245fa61510152be90014300ea5840341ce0c673dc2d343aaf76ab&w=740",
      rating: "4.5 (350)",
      sellingStatus: "High",
      referralPoint: "50",
      selfPoint: "10",
      itemCount: "Item(8)",
      price: "₹300",
      discount: "10%",
      sellingPrice: "₹270",
      hashtagCount: "#4",
      isActive: true),
];

List<String> items = [
  '500 gm',
  '1 kg',
  '2 kg',
];

List<String> categoryBrandSelection = [
  "Categories",
  "Brands",
  "Product Selling",
  "Selling Status",
];

class ReferPointModel {
  final String count;
  final String levels;
  final int point;

  ReferPointModel({
    required this.count,
    required this.levels,
    required this.point,
  });
}

List<ReferPointModel> referPointModel = [
  ReferPointModel(
    count: "01",
    levels: "1",
    point: 20,
  ),
  ReferPointModel(
    count: "02",
    levels: "2",
    point: 20,
  ),
  ReferPointModel(
    count: "03",
    levels: "3",
    point: 20,
  ),
  ReferPointModel(
    count: "04",
    levels: "4",
    point: 50,
  ),
  ReferPointModel(
    count: "05",
    levels: "5",
    point: 40,
  ),
];

List<String> sortFiltering = [
  "Name: A to Z",
  "Name: Z to A",
  "Amount : High to Low",
  "Amount : Low to High",
];
