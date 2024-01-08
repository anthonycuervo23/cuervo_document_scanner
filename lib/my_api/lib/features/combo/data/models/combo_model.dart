class ComboModel {
  String comboName;
  int comboPrice;
  String startDate;
  String endDate;
  String imagePath;
  bool isAppLive;
  bool isExpired;
  List<ComboProductModel> comboProducts;

  ComboModel({
    required this.comboName,
    required this.endDate,
    required this.startDate,
    required this.comboPrice,
    required this.isAppLive,
    required this.isExpired,
    required this.imagePath,
    required this.comboProducts,
  });
}

class ComboProductModel {
  String productName;
  int price;
  String weight;

  ComboProductModel({
    required this.productName,
    required this.price,
    required this.weight,
  });
}

List<ComboModel> comboOfferList = [
  ComboModel(
    endDate: "27/11/2023",
    startDate: "20/11/2023",
    comboPrice: 1500,
    isAppLive: true,
    isExpired: false,
    comboName: 'Cookies + Black forest cake',
    imagePath:
        'https://img.freepik.com/free-photo/delicious-cake-with-fruits_23-2150727534.jpg?t=st=1701760927~exp=1701764527~hmac=6fbb735ebbe6544e1e6d0e7899641a77cb19efedd5ffd44f5a1d028c74c0cba8&w=740',
    comboProducts: [
      ComboProductModel(productName: "Chocolate Cookies", price: 100, weight: "250 gm"),
      ComboProductModel(productName: "Premium Cookies", price: 300, weight: "1kg"),
      ComboProductModel(productName: "Crunchy Delight", price: 450, weight: "500 gm"),
      ComboProductModel(productName: "Salt Cookies", price: 200, weight: "250 gm"),
    ],
  ),
  ComboModel(
    endDate: "12/11/2023",
    startDate: "02/11/2023",
    comboPrice: 700,
    isAppLive: true,
    isExpired: false,
    comboName: 'Salt Cookies',
    imagePath:
        'https://img.freepik.com/free-photo/delicious-cake-with-fruits_23-2150727534.jpg?t=st=1701760927~exp=1701764527~hmac=6fbb735ebbe6544e1e6d0e7899641a77cb19efedd5ffd44f5a1d028c74c0cba8&w=740',
    comboProducts: [
      ComboProductModel(productName: "Crunchy Delight", price: 450, weight: "500 gm"),
      ComboProductModel(productName: "Salt Cookies", price: 200, weight: "250 gm"),
    ],
  ),
  ComboModel(
    endDate: "25/11/2023",
    startDate: "20/11/2023",
    comboPrice: 1500,
    isAppLive: false,
    isExpired: true,
    comboName: 'Premium cakes',
    imagePath:
        'https://img.freepik.com/free-photo/delicious-cake-with-fruits_23-2150727534.jpg?t=st=1701760927~exp=1701764527~hmac=6fbb735ebbe6544e1e6d0e7899641a77cb19efedd5ffd44f5a1d028c74c0cba8&w=740',
    comboProducts: [
      ComboProductModel(productName: "Chocolate Cookies", price: 100, weight: "250 gm"),
      ComboProductModel(productName: "Crunchy Delight", price: 450, weight: "500 gm"),
      ComboProductModel(productName: "Salt Cookies", price: 200, weight: "250 gm"),
      ComboProductModel(productName: "Salt Cookies", price: 200, weight: "250 gm"),
    ],
  ),
  ComboModel(
    endDate: "27/11/2023",
    startDate: "20/11/2023",
    comboPrice: 1700,
    isAppLive: true,
    isExpired: false,
    comboName: 'Cookies + Premium Cookies',
    imagePath:
        'https://img.freepik.com/free-photo/delicious-cake-with-fruits_23-2150727534.jpg?t=st=1701760927~exp=1701764527~hmac=6fbb735ebbe6544e1e6d0e7899641a77cb19efedd5ffd44f5a1d028c74c0cba8&w=740',
    comboProducts: [
      ComboProductModel(productName: "Crunchy Delight", price: 450, weight: "500 gm"),
      ComboProductModel(productName: "Salt Cookies", price: 200, weight: "250 gm"),
      ComboProductModel(productName: "Salt Cookies", price: 200, weight: "250 gm"),
      ComboProductModel(productName: "Salt Cookies", price: 200, weight: "250 gm"),
    ],
  ),
  ComboModel(
    endDate: "27/11/2023",
    startDate: "20/11/2023",
    comboPrice: 1500,
    isAppLive: true,
    isExpired: false,
    comboName: 'Black forest cake',
    imagePath:
        'https://img.freepik.com/free-photo/delicious-cake-with-fruits_23-2150727534.jpg?t=st=1701760927~exp=1701764527~hmac=6fbb735ebbe6544e1e6d0e7899641a77cb19efedd5ffd44f5a1d028c74c0cba8&w=740',
    comboProducts: [
      ComboProductModel(productName: "Chocolate Cookies", price: 100, weight: "250 gm"),
      ComboProductModel(productName: "Premium Cookies", price: 300, weight: "1kg"),
      ComboProductModel(productName: "Crunchy Delight", price: 450, weight: "500 gm"),
      ComboProductModel(productName: "Salt Cookies", price: 200, weight: "250 gm"),
    ],
  ),
];

List<ComboProductModel> createComboList = [
  ComboProductModel(productName: "Chocolate Cookies", price: 100, weight: "250 gm"),
  ComboProductModel(productName: "Premium Cookies", price: 300, weight: "1kg"),
  ComboProductModel(productName: "Crunchy Delight", price: 450, weight: "500 gm"),
  ComboProductModel(productName: "Salt Cookies", price: 200, weight: "250 gm"),
  ComboProductModel(productName: "Chocolate Cookies", price: 300, weight: "250 gm"),
  ComboProductModel(productName: "Premium Cookies", price: 150, weight: "1kg"),
  ComboProductModel(productName: "Crunchy Delight", price: 450, weight: "500 gm"),
  ComboProductModel(productName: "Salt Cookies", price: 200, weight: "250 gm"),
];


// class ComboModel {
//   List<String> comboProducts;
//   String startDate;
//   String endDate;
//   int comboPrice;
//   bool isAppLive;
//   bool isExpired;

//   ComboModel({
//     required this.comboProducts,
//     required this.endDate,
//     required this.startDate,
//     required this.comboPrice,
//     required this.isAppLive,
//     required this.isExpired,
//   });
// }

// List<ComboModel> comboOfferList = [
//   ComboModel(
//     comboProducts: ["Cookies", "Black forest cake", "white forest cake"],
//     endDate: "27/11/2023",
//     startDate: "20/11/2023",
//     comboPrice: 1500,
//     isAppLive: true,
//     isExpired: false,
//   ),
//   ComboModel(
//     comboProducts: ["Black forest cake", "white forest cake"],
//     endDate: "7/1/2023",
//     startDate: "2/1/2023",
//     comboPrice: 1200,
//     isAppLive: false,
//     isExpired: true,
//   ),
//   ComboModel(
//     comboProducts: ["Black forest cake", "Cookies", "white forest cake"],
//     endDate: "27/11/2023",
//     startDate: "20/11/2023",
//     comboPrice: 1800,
//     isAppLive: true,
//     isExpired: false,
//   ),
//   ComboModel(
//     comboProducts: ["Cookies", "Black forest cake", "white forest cake"],
//     endDate: "27/11/2023",
//     startDate: "20/11/2023",
//     comboPrice: 1500,
//     isAppLive: false,
//     isExpired: false,
//   ),
//   ComboModel(
//     comboProducts: ["Cookies", "Black forest cake", "white forest cake"],
//     endDate: "27/11/2023",
//     startDate: "20/11/2023",
//     comboPrice: 1500,
//     isAppLive: true,
//     isExpired: true,
//   ),
//   ComboModel(
//     comboProducts: ["Black forest cake", "white forest cake"],
//     endDate: "7/1/2023",
//     startDate: "2/1/2023",
//     comboPrice: 1200,
//     isAppLive: false,
//     isExpired: false,
//   ),
//   ComboModel(
//     comboProducts: ["Black forest cake", "Cookies", "white forest cake"],
//     endDate: "27/11/2023",
//     startDate: "20/11/2023",
//     comboPrice: 1800,
//     isAppLive: true,
//     isExpired: false,
//   ),
//   ComboModel(
//     comboProducts: ["Cookies", "Black forest cake", "white forest cake"],
//     endDate: "27/11/2023",
//     startDate: "20/11/2023",
//     comboPrice: 1500,
//     isAppLive: false,
//     isExpired: true,
//   ),
// ];
