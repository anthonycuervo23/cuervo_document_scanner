// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  String name;
  String flavour;
  String category;
  List<String> image;
  List<QuantityModel> availableQuantity;
  List<QuantityModel> selectedQuantity;
  int productId;
  bool isVeg;

  ProductModel({
    required this.productId,
    required this.name,
    required this.flavour,
    required this.category,
    required this.image,
    required this.availableQuantity,
    required this.isVeg,
    required this.selectedQuantity,
  });

  @override
  List<Object?> get props => [
        productId,
        name,
        flavour,
        category,
        image,
        availableQuantity,
        isVeg,
      ];
}

class QuantityModel extends Equatable {
  int price;
  int piecs;
  int quantity;
  String quantityType;
  QuantityModel({
    required this.price,
    required this.quantity,
    required this.quantityType,
    required this.piecs,
  });
  @override
  List<Object?> get props => [
        price,
        quantity,
        quantityType,
        piecs,
      ];
}

class CupponModel extends Equatable {
  int offerPersentage;
  int savedAmount;
  int maxAmt;
  CupponModel({required this.offerPersentage, required this.savedAmount,required this.maxAmt});
  @override
  List<Object?> get props => [
        offerPersentage,
        savedAmount,
      ];
}

List category = ["cake", "cookies", "mask", "donates"];

List<ProductModel> dummyProductsData = [
  ProductModel(
    productId: 1,
    isVeg: true,
    name: "StrawBerry Lava",
    flavour: "straw berry",
    category: "cake",
    image: const [
      "https://imgcdn.floweraura.com/cherry-kissed-black-forest-birthday-cake-9801200ca-A.jpg",
      "https://res.cloudinary.com/insignia-flowera-in/images/f_auto,q_auto/w_300,h_300,c_scale/v1698919476/simple-pineapple-cake_82061f2b2/simple-pineapple-cake-300x300.jpg",
      "https://assets.winni.in/c_limit,dpr_1,fl_progressive,q_80,w_1000/74421_belgium-chocolate-truffle-cake.jpeg",
      "https://images.unsplash.com/photo-1606983340126-99ab4feaa64a?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aGFwcHklMjBiaXJ0aGRheSUyMGNha2V8ZW58MHx8MHx8fDA%3D"
    ],
    availableQuantity: [
      QuantityModel(price: 250, quantity: 300, quantityType: "gm", piecs: 1),
      QuantityModel(price: 350, quantity: 500, quantityType: "gm", piecs: 1),
    ],
    selectedQuantity: [
      QuantityModel(price: 250, quantity: 300, quantityType: "gm", piecs: 1),
    ],
  ),
  ProductModel(
    productId: 2,
    isVeg: false,
    name: "Brown valvet",
    flavour: "black forest",
    category: "cake",
    image: const [
      "https://livforcake.com/wp-content/uploads/2017/07/black-forest-cake-thumb.jpg",
      "https://www.shutterstock.com/image-photo/chocolate-cake-nuts-on-black-260nw-2258209285.jpg",
      "https://img.freepik.com/premium-photo/chocolate-cake-with-chocolate-icing-chocolate-drizzles_835197-244.jpg",
      "https://assets.epicurious.com/photos/62cda7af268a310d85053fea/1:1/w_2560%2Cc_limit/SwissRoll_RECIPE_062922_36484.jpg"
    ],
    availableQuantity: [
      QuantityModel(price: 350, quantity: 500, quantityType: "gm", piecs: 1),
      QuantityModel(price: 600, quantity: 1, quantityType: "kg", piecs: 1)
    ],
    selectedQuantity: [
      QuantityModel(price: 350, quantity: 500, quantityType: "gm", piecs: 1),
    ],
  ),
  ProductModel(
    isVeg: true,
    productId: 3,
    name: "Cookie 1",
    flavour: "chocolate",
    category: "cookies",
    image: const ["https://chelsweets.com/wp-content/uploads/2022/11/recipe-card-penguin-cake-closer-735x980.jpg"],
    availableQuantity: [
      QuantityModel(price: 150, quantity: 250, quantityType: "gm", piecs: 1),
      QuantityModel(price: 300, quantity: 500, quantityType: "gm", piecs: 1),
    ],
    selectedQuantity: [
      QuantityModel(price: 150, quantity: 250, quantityType: "gm", piecs: 1),
    ],
  ),
  ProductModel(
    productId: 4,
    isVeg: false,
    name: "Cookie 2",
    flavour: "straw berry",
    category: "cookies",
    image: const ["https://cdn.giftstoindia24x7.com/ASP_Img/IMG2000/GTI0241.jpg"],
    availableQuantity: [
      QuantityModel(price: 150, quantity: 250, quantityType: "gm", piecs: 1),
      QuantityModel(price: 300, quantity: 500, quantityType: "gm", piecs: 1),
    ],
    selectedQuantity: [
      QuantityModel(price: 150, quantity: 250, quantityType: "gm", piecs: 1),
    ],
  ),
  ProductModel(
    isVeg: true,
    productId: 5,
    name: "Donates",
    flavour: "dark chocolate",
    category: "donates",
    image: const [
      "https://liliyum.com/cdn/shop/products/cloudcake_dfab5652-cf36-409b-942f-c8ae6436eecb_800x.jpg?v=1664974840"
    ],
    availableQuantity: [
      QuantityModel(price: 120, quantity: 200, quantityType: "gm", piecs: 1),
      QuantityModel(price: 180, quantity: 350, quantityType: "gm", piecs: 1),
    ],
    selectedQuantity: [
      QuantityModel(price: 120, quantity: 200, quantityType: "gm", piecs: 1),
    ],
  ),
  ProductModel(
    isVeg: false,
    productId: 6,
    name: "mask",
    flavour: "vanilla",
    category: "mask",
    image: const ["https://whipped.in/cdn/shop/products/zyro-image_36_1800x1800.jpg?v=1686824457"],
    availableQuantity: [
      QuantityModel(price: 100, quantity: 200, quantityType: "gm", piecs: 1),
      QuantityModel(price: 150, quantity: 350, quantityType: "gm", piecs: 1),
    ],
    selectedQuantity: [
      QuantityModel(price: 100, quantity: 200, quantityType: "gm", piecs: 1),
    ],
  ),
];

List<CupponModel> cupons = [
  CupponModel(offerPersentage: 10, savedAmount: 100, maxAmt: 125),
  CupponModel(offerPersentage: 20, savedAmount: 200, maxAmt: 250),
  CupponModel(offerPersentage: 50, savedAmount: 300, maxAmt: 312),
  CupponModel(offerPersentage: 16, savedAmount: 400, maxAmt: 495),
];
