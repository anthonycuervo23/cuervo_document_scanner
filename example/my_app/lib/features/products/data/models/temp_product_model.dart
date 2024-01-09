import 'package:intl/intl.dart';

class TempProductDataModel {
  String name;
  String image;
  List<TempProductData> productList;

  TempProductDataModel({required this.name, required this.image, required this.productList});
}

class TempProductData {
  int productId;
  String productName;
  String productImage;
  double productRating;
  bool isVegProduct;
  bool isBestSeller;
  int ratingPeopleCount;
  int selectedRedio = 0;
  bool isFavorite;
  int productCartCount = 0;
  double productCartPrice = 0;
  bool? isNewArrival = false;
  String? offerStartingDate;
  String? offerEndingDate;
  List<TempProductQuatityModel> productQuantityList;
  List<String>? comboOffersProductName;

  TempProductData({
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.isVegProduct,
    required this.productRating,
    required this.productQuantityList,
    required this.ratingPeopleCount,
    required this.isFavorite,
    required this.productCartCount,
    required this.productCartPrice,
    required this.selectedRedio,
    required this.isBestSeller,
    this.offerStartingDate,
    this.offerEndingDate,
    this.comboOffersProductName,
    this.isNewArrival,
  });

  TempProductData copyWith({
    int? productId,
    String? productName,
    String? productImage,
    double? productRating,
    bool? isVegProduct,
    bool? isBestSeller,
    int? ratingPeopleCount,
    int? selectedRedio,
    bool? isFavorite,
    int? productCartCount,
    double? productCartPrice,
    bool? isNewArrival,
    String? offerStartingDate,
    String? offerEndingDate,
    List<TempProductQuatityModel>? productQuantityList,
    List<String>? comboOffersProductName,
  }) {
    return TempProductData(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      productRating: productRating ?? this.productRating,
      isVegProduct: isVegProduct ?? this.isVegProduct,
      isBestSeller: isBestSeller ?? this.isBestSeller,
      ratingPeopleCount: ratingPeopleCount ?? this.ratingPeopleCount,
      selectedRedio: selectedRedio ?? this.selectedRedio,
      isFavorite: isFavorite ?? this.isFavorite,
      productCartCount: productCartCount ?? this.productCartCount,
      productCartPrice: productCartPrice ?? this.productCartPrice,
      isNewArrival: isNewArrival ?? this.isNewArrival,
      productQuantityList: productQuantityList ?? this.productQuantityList,
      offerEndingDate: offerEndingDate ?? this.offerEndingDate,
      offerStartingDate: offerStartingDate ?? this.offerStartingDate,
      comboOffersProductName: comboOffersProductName ?? this.comboOffersProductName,
    );
  }
}

class TempProductQuatityModel {
  int quantity;
  String quantityType;
  double price;
  double offerPrice;
  int cartCounts;
  double cartPrice;

  TempProductQuatityModel({
    required this.quantity,
    required this.quantityType,
    required this.price,
    required this.offerPrice,
    required this.cartCounts,
    required this.cartPrice,
  });
}

List<TempProductDataModel> categoriesAndProductList = [
  TempProductDataModel(
    name: "Cakes",
    image:
        "https://img.freepik.com/free-vector/birthday-cake-illustration-white_18591-82104.jpg?w=900&t=st=1696911159~exp=1696911759~hmac=18188d2b4377a3d5e40e109113a5c383813407d1223592cdf4ebd268cf847fac",
    productList: [
      TempProductData(
        productId: 1,
        selectedRedio: 0,
        productName: "Chocolate Cake",
        productImage:
            "https://img.freepik.com/free-photo/chocolate-cake-with-chocolate-sprinkles_144627-8998.jpg?w=1380&t=st=1696911221~exp=1696911821~hmac=c74e4b2a3a8ddb826686da2148005d35299e52e37903f581440f3228572776fa",
        productRating: 4.5,
        isVegProduct: false,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "kg",
            price: 800,
            offerPrice: 700,
            cartCounts: 0,
            cartPrice: 0,
          ),
          // ProductQuatityModel(quantity: 500, quantityType: "gm", price: 500),
        ],
        isFavorite: false,
        isBestSeller: true,
        ratingPeopleCount: 1020,
        productCartCount: 0,
        productCartPrice: 0,
      ),
      TempProductData(
        productId: 2,
        selectedRedio: 0,
        productName: "Fruits Cake",
        productImage:
            "https://img.freepik.com/free-photo/chocolate-cake-decorated-with-forest-fruits-blueberries-strawberries-blackberries-ai-generative_123827-24046.jpg?w=1380&t=st=1696911580~exp=1696912180~hmac=56c9e6570bbb2bf1af1e60de1367e35ec736edd16c912d77dfe0500ed86788f6",
        productRating: 4.0,
        isVegProduct: true,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 500,
            quantityType: "gm",
            price: 300,
            offerPrice: 250,
            cartCounts: 0,
            cartPrice: 0,
          ),
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "kg",
            price: 500,
            offerPrice: 450,
            cartCounts: 0,
            cartPrice: 0,
          ),
        ],
        isFavorite: false,
        isBestSeller: false,
        productCartCount: 0,
        ratingPeopleCount: 100,
        productCartPrice: 0,
      ),
      TempProductData(
        productId: 3,
        selectedRedio: 0,
        productName: "Barries Cake",
        productImage:
            "https://img.freepik.com/free-photo/delicious-chocolate-cake-with-flower_23-2150727532.jpg?t=st=1696911592~exp=1696915192~hmac=28282a4137eadb5f65dbeac2c9b6b88cd85da6d5367a315968d6159f3519f30a&w=740",
        productRating: 4.0,
        isVegProduct: true,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "kg",
            price: 1000,
            offerPrice: 800,
            cartCounts: 0,
            cartPrice: 0,
          ),
          // ProductQuatityModel(quantity: 500, quantityType: "gm", price: 600),
        ],
        isFavorite: false,
        isBestSeller: true,
        isNewArrival: true,
        productCartCount: 0,
        productCartPrice: 0,
        ratingPeopleCount: 1500,
      ),
      TempProductData(
        productId: 16,
        selectedRedio: 0,
        productName: "Chocolate Cake",
        productImage:
            "https://img.freepik.com/free-photo/chocolate-cake-with-chocolate-sprinkles_144627-8998.jpg?w=1380&t=st=1696911221~exp=1696911821~hmac=c74e4b2a3a8ddb826686da2148005d35299e52e37903f581440f3228572776fa",
        productRating: 4.5,
        isVegProduct: false,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "kg",
            price: 800,
            offerPrice: 700,
            cartCounts: 0,
            cartPrice: 0,
          ),
          // ProductQuatityModel(quantity: 500, quantityType: "gm", price: 500),
        ],
        isFavorite: false,
        isBestSeller: true,
        ratingPeopleCount: 1020,
        productCartCount: 0,
        productCartPrice: 0,
      ),
      TempProductData(
        productId: 17,
        selectedRedio: 0,
        productName: "Fruits Cake",
        productImage:
            "https://img.freepik.com/free-photo/chocolate-cake-decorated-with-forest-fruits-blueberries-strawberries-blackberries-ai-generative_123827-24046.jpg?w=1380&t=st=1696911580~exp=1696912180~hmac=56c9e6570bbb2bf1af1e60de1367e35ec736edd16c912d77dfe0500ed86788f6",
        productRating: 4.0,
        isVegProduct: true,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 500,
            quantityType: "gm",
            price: 300,
            offerPrice: 250,
            cartCounts: 0,
            cartPrice: 0,
          ),
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "kg",
            price: 500,
            offerPrice: 450,
            cartCounts: 0,
            cartPrice: 0,
          ),
        ],
        isFavorite: false,
        isBestSeller: false,
        productCartCount: 0,
        ratingPeopleCount: 100,
        productCartPrice: 0,
      ),
      TempProductData(
        productId: 18,
        selectedRedio: 0,
        productName: "Barries Cake",
        productImage:
            "https://img.freepik.com/free-photo/delicious-chocolate-cake-with-flower_23-2150727532.jpg?t=st=1696911592~exp=1696915192~hmac=28282a4137eadb5f65dbeac2c9b6b88cd85da6d5367a315968d6159f3519f30a&w=740",
        productRating: 4.0,
        isVegProduct: true,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "kg",
            price: 1000,
            offerPrice: 800,
            cartCounts: 0,
            cartPrice: 0,
          ),
          // ProductQuatityModel(quantity: 500, quantityType: "gm", price: 600),
        ],
        isFavorite: false,
        isBestSeller: true,
        isNewArrival: true,
        productCartCount: 0,
        productCartPrice: 0,
        ratingPeopleCount: 1500,
      ),
      TempProductData(
        productId: 19,
        selectedRedio: 0,
        productName: "Chocolate Cake",
        productImage:
            "https://img.freepik.com/free-photo/chocolate-cake-with-chocolate-sprinkles_144627-8998.jpg?w=1380&t=st=1696911221~exp=1696911821~hmac=c74e4b2a3a8ddb826686da2148005d35299e52e37903f581440f3228572776fa",
        productRating: 4.5,
        isVegProduct: false,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "kg",
            price: 800,
            offerPrice: 700,
            cartCounts: 0,
            cartPrice: 0,
          ),
          // ProductQuatityModel(quantity: 500, quantityType: "gm", price: 500),
        ],
        isFavorite: false,
        isBestSeller: true,
        ratingPeopleCount: 1020,
        productCartCount: 0,
        productCartPrice: 0,
      ),
      TempProductData(
        productId: 20,
        selectedRedio: 0,
        productName: "Fruits Cake",
        productImage:
            "https://img.freepik.com/free-photo/chocolate-cake-decorated-with-forest-fruits-blueberries-strawberries-blackberries-ai-generative_123827-24046.jpg?w=1380&t=st=1696911580~exp=1696912180~hmac=56c9e6570bbb2bf1af1e60de1367e35ec736edd16c912d77dfe0500ed86788f6",
        productRating: 4.0,
        isVegProduct: true,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 500,
            quantityType: "gm",
            price: 300,
            offerPrice: 250,
            cartCounts: 0,
            cartPrice: 0,
          ),
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "kg",
            price: 500,
            offerPrice: 450,
            cartCounts: 0,
            cartPrice: 0,
          ),
        ],
        isFavorite: false,
        isBestSeller: false,
        productCartCount: 0,
        ratingPeopleCount: 100,
        productCartPrice: 0,
      ),
      TempProductData(
        productId: 21,
        selectedRedio: 0,
        productName: "Barries Cake",
        productImage:
            "https://img.freepik.com/free-photo/delicious-chocolate-cake-with-flower_23-2150727532.jpg?t=st=1696911592~exp=1696915192~hmac=28282a4137eadb5f65dbeac2c9b6b88cd85da6d5367a315968d6159f3519f30a&w=740",
        productRating: 4.0,
        isVegProduct: true,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "kg",
            price: 1000,
            offerPrice: 800,
            cartCounts: 0,
            cartPrice: 0,
          ),
          // ProductQuatityModel(quantity: 500, quantityType: "gm", price: 600),
        ],
        isFavorite: false,
        isBestSeller: true,
        isNewArrival: true,
        productCartCount: 0,
        productCartPrice: 0,
        ratingPeopleCount: 1500,
      ),
    ],
  ),
  TempProductDataModel(
    name: "Pastries",
    image:
        "https://img.freepik.com/free-vector/red-velvet-cake-concept-illustration_114360-9877.jpg?w=740&t=st=1696911144~exp=1696911744~hmac=796432ab803f546df1f482cef9de222918ecab6225566893361498c14d174f4b",
    productList: [
      TempProductData(
        productId: 4,
        selectedRedio: 0,
        productName:
            "Coco Pastry Coco Pastry Coco Pastry Coco Pastry Coco Pastry Coco Pastry Coco Pastry Coco Pastry Coco Pastry Coco Pastry Coco Pastry Coco Pastry",
        productImage:
            "https://img.freepik.com/free-photo/close-up-fancy-dessert_23-2150527585.jpg?t=st=1696911288~exp=1696914888~hmac=a524ac01521d9ea560e4f37bdfd5336e10d238c7dec9d62996ae6b9e67c23426&w=740",
        productRating: 4.2,
        isVegProduct: true,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "piece",
            price: 80,
            offerPrice: 75,
            cartCounts: 0,
            cartPrice: 0,
          ),
          // ProductQuatityModel(quantity: 6, quantityType: "pieces", price: 450),
        ],
        isFavorite: false,
        isNewArrival: true,
        isBestSeller: true,
        productCartCount: 0,
        ratingPeopleCount: 1200,
        productCartPrice: 0,
      ),
      TempProductData(
        productId: 5,
        selectedRedio: 0,
        productName: "Orange Pastry",
        productImage:
            "https://img.freepik.com/free-photo/delicious-carrot-cake-with-cream_23-2150727524.jpg?t=st=1696910501~exp=1696914101~hmac=840330b453b1fe9d82e2ccd897233b2101862e7985713ec45915891d44ea66f1&w=1380",
        productRating: 4.5,
        isVegProduct: false,
        productCartPrice: 0,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "piece",
            price: 100,
            offerPrice: 95,
            cartCounts: 0,
            cartPrice: 0,
          ),
          TempProductQuatityModel(
            quantity: 6,
            quantityType: "pieces",
            price: 500,
            offerPrice: 475,
            cartCounts: 0,
            cartPrice: 0,
          ),
        ],
        isFavorite: false,
        isBestSeller: true,
        productCartCount: 0,
        ratingPeopleCount: 170,
      ),
      TempProductData(
        productId: 6,
        selectedRedio: 0,
        productName: "Red Velvet Pastry",
        productImage:
            "https://img.freepik.com/free-photo/red-velvet-cake-slices-with-yellof-cherry-top-mint-leaves_114579-2593.jpg?w=740&t=st=1696911759~exp=1696912359~hmac=2ccf691adade52f2df7c262289f055768de8ffe048d12db0e7ef32e545204c43",
        productRating: 4.3,
        isVegProduct: true,
        productCartPrice: 0,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "piece",
            price: 90,
            offerPrice: 75,
            cartCounts: 0,
            cartPrice: 0,
          ),
          TempProductQuatityModel(
            quantity: 6,
            quantityType: "pieces",
            price: 480,
            offerPrice: 355,
            cartCounts: 0,
            cartPrice: 0,
          ),
        ],
        isFavorite: false,
        isBestSeller: true,
        productCartCount: 0,
        ratingPeopleCount: 1190,
      ),
    ],
  ),
  TempProductDataModel(
    name: "Croissant",
    image:
        "https://img.freepik.com/free-vector/brown-freshly-baked-vintage-croissant_53876-111428.jpg?w=740&t=st=1696913280~exp=1696913880~hmac=27094917ef33cf886c8f22b5ce1b202dfd0d60ad982a9c6d42463e2044dd3732",
    productList: [
      TempProductData(
        productId: 7,
        selectedRedio: 0,
        productCartPrice: 0,
        productName: "Croissant",
        productImage:
            "https://img.freepik.com/free-photo/butter-croissant-table_1339-5772.jpg?w=740&t=st=1696911945~exp=1696912545~hmac=81897fe465f06dbd89ec29ed81cd34ba710edea80722ac2d275e2633871328c0",
        isVegProduct: true,
        productRating: 4.5,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "Piece",
            price: 50,
            offerPrice: 45,
            cartCounts: 0,
            cartPrice: 0,
          ),
          TempProductQuatityModel(
            quantity: 4,
            quantityType: "Pieces",
            price: 180,
            offerPrice: 160,
            cartCounts: 0,
            cartPrice: 0,
          ),
        ],
        isFavorite: false,
        isBestSeller: true,
        productCartCount: 0,
        ratingPeopleCount: 1000,
      ),
      TempProductData(
        productId: 8,
        selectedRedio: 0,
        productCartPrice: 0,
        productName: "Butter Croissant",
        productImage:
            "https://img.freepik.com/free-photo/croissants-old-wood-table_1150-12247.jpg?w=1380&t=st=1696911947~exp=1696912547~hmac=706e5a572eab6d5f059f27c55ae2f918b1c5103c72652c4077168f894184c2bb",
        isVegProduct: false,
        productRating: 3.5,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "Piece",
            price: 80,
            offerPrice: 75,
            cartCounts: 0,
            cartPrice: 0,
          ),
          TempProductQuatityModel(
            quantity: 4,
            quantityType: "Pieces",
            price: 280,
            offerPrice: 200,
            cartCounts: 0,
            cartPrice: 0,
          ),
        ],
        isFavorite: false,
        isBestSeller: true,
        productCartCount: 0,
        ratingPeopleCount: 120,
      ),
      TempProductData(
        productId: 9,
        selectedRedio: 0,
        productCartPrice: 0,
        productName: "Chocolate Croissant",
        productImage:
            "https://img.freepik.com/free-photo/closeup-shot-croissant-plate-covered-chocolate-cafe_181624-57999.jpg?w=740&t=st=1696911955~exp=1696912555~hmac=44f164f9268200a6abc2fcd1f0b70865b951a6a08000f3b1a4892f3547420310",
        isVegProduct: true,
        productRating: 4.5,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "Piece",
            price: 100,
            offerPrice: 85,
            cartCounts: 0,
            cartPrice: 0,
          ),
          // ProductQuatityModel(quantity: 4, quantityType: "Pieces", price: 400, offerPrice: 350),
        ],
        isFavorite: false,
        isBestSeller: true,
        isNewArrival: true,
        productCartCount: 0,
        ratingPeopleCount: 1020,
      ),
    ],
  ),
  TempProductDataModel(
    name: "Nuts Cake",
    image:
        "https://img.freepik.com/free-photo/assortment-pieces-cake_114579-28277.jpg?t=st=1696912216~exp=1696912816~hmac=ef04341f8c57ffbb16592551243050743afad187ac72dc01f39ffdd2b4d504f3",
    productList: [
      TempProductData(
        productId: 10,
        selectedRedio: 0,
        productCartPrice: 0,
        productName: "Walnut Cake",
        productImage:
            "https://img.freepik.com/free-photo/chocolate-cake-with-chocolate-sprinkles_144627-8998.jpg?w=1380&t=st=1696911221~exp=1696911821~hmac=c74e4b2a3a8ddb826686da2148005d35299e52e37903f581440f3228572776fa",
        productRating: 4.1,
        isVegProduct: true,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "kg",
            price: 700,
            offerPrice: 675,
            cartCounts: 0,
            cartPrice: 0,
          ),
          // ProductQuatityModel(quantity: 500, quantityType: "gm", price: 400),
        ],
        isFavorite: true,
        isBestSeller: true,
        productCartCount: 0,
        ratingPeopleCount: 120,
      ),
      TempProductData(
        productId: 11,
        selectedRedio: 0,
        productCartPrice: 0,
        productName: "Almond Cake",
        productImage:
            "https://img.freepik.com/free-photo/chocolate-cake-decorated-with-forest-fruits-blueberries-strawberries-blackberries-ai-generative_123827-24046.jpg?w=1380&t=st=1696911580~exp=1696912180~hmac=56c9e6570bbb2bf1af1e60de1367e35ec736edd16c912d77dfe0500ed86788f6",
        productRating: 4.0,
        isVegProduct: true,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "kg",
            price: 500,
            offerPrice: 485,
            cartCounts: 0,
            cartPrice: 0,
          ),
          TempProductQuatityModel(
            quantity: 500,
            quantityType: "gm",
            price: 300,
            offerPrice: 295,
            cartCounts: 0,
            cartPrice: 0,
          ),
        ],
        isFavorite: true,
        isBestSeller: false,
        isNewArrival: true,
        productCartCount: 0,
        ratingPeopleCount: 1060,
      ),
      TempProductData(
        productId: 12,
        selectedRedio: 0,
        productCartPrice: 0,
        productName: "salmon Cake",
        productImage:
            "https://img.freepik.com/free-photo/delicious-chocolate-cake-with-flower_23-2150727532.jpg?t=st=1696911592~exp=1696915192~hmac=28282a4137eadb5f65dbeac2c9b6b88cd85da6d5367a315968d6159f3519f30a&w=740",
        productRating: 4.0,
        isVegProduct: false,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 500,
            quantityType: "gm",
            price: 500,
            offerPrice: 475,
            cartCounts: 0,
            cartPrice: 0,
          ),
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "kg",
            price: 800,
            offerPrice: 765,
            cartCounts: 0,
            cartPrice: 0,
          ),
        ],
        isFavorite: true,
        isBestSeller: true,
        productCartCount: 0,
        ratingPeopleCount: 1510,
      ),
    ],
  ),
  TempProductDataModel(
    name: "Pastry",
    image:
        "https://img.freepik.com/free-vector/chocolate-cake-with-cherry-isolated_1284-42837.jpg?w=740&t=st=1696912837~exp=1696913437~hmac=3e7c8906b1a9f8729e60583e8ae085410c31258adf036270eb43f2d0b116feda",
    productList: [
      TempProductData(
        productId: 13,
        selectedRedio: 0,
        productCartPrice: 0,
        productName: "Chocolate Pastry",
        productImage:
            "https://img.freepik.com/free-photo/close-up-fancy-dessert_23-2150527585.jpg?t=st=1696911288~exp=1696914888~hmac=a524ac01521d9ea560e4f37bdfd5336e10d238c7dec9d62996ae6b9e67c23426&w=740",
        productRating: 4.2,
        isVegProduct: false,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "piece",
            price: 80,
            offerPrice: 75,
            cartCounts: 0,
            cartPrice: 0,
          ),
          // ProductQuatityModel(quantity: 6, quantityType: "pieces", price: 450),
        ],
        isFavorite: false,
        isBestSeller: true,
        productCartCount: 0,
        ratingPeopleCount: 1200,
      ),
      TempProductData(
        productId: 14,
        selectedRedio: 0,
        productName: "fruit Pastry",
        productImage:
            "https://img.freepik.com/free-photo/delicious-carrot-cake-with-cream_23-2150727524.jpg?t=st=1696910501~exp=1696914101~hmac=840330b453b1fe9d82e2ccd897233b2101862e7985713ec45915891d44ea66f1&w=1380",
        productRating: 4.5,
        productCartPrice: 0,
        isVegProduct: true,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 6,
            quantityType: "pieces",
            price: 500,
            offerPrice: 445,
            cartCounts: 0,
            cartPrice: 0,
          ),
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "piece",
            price: 100,
            offerPrice: 90,
            cartCounts: 0,
            cartPrice: 0,
          ),
        ],
        isFavorite: false,
        isBestSeller: true,
        productCartCount: 0,
        ratingPeopleCount: 150,
      ),
      TempProductData(
        productId: 15,
        selectedRedio: 0,
        productCartPrice: 0,
        productName: "Red Pastry",
        productImage:
            "https://img.freepik.com/free-photo/red-velvet-cake-slices-with-yellof-cherry-top-mint-leaves_114579-2593.jpg?w=740&t=st=1696911759~exp=1696912359~hmac=2ccf691adade52f2df7c262289f055768de8ffe048d12db0e7ef32e545204c43",
        productRating: 4.3,
        isVegProduct: true,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "piece",
            price: 50,
            offerPrice: 45,
            cartCounts: 0,
            cartPrice: 0,
          ),
          TempProductQuatityModel(
            quantity: 6,
            quantityType: "pieces",
            price: 250,
            offerPrice: 235,
            cartCounts: 0,
            cartPrice: 0,
          ),
        ],
        isFavorite: false,
        isBestSeller: false,
        isNewArrival: true,
        productCartCount: 0,
        ratingPeopleCount: 1130,
      ),
    ],
  ),
];

List<TempProductDataModel> comboOfferList = [
  TempProductDataModel(
    name: "Combos And Offers",
    image: "",
    productList: [
      TempProductData(
        productId: 22,
        productImage:
            "https://img.freepik.com/free-photo/fruit-cake-with-chocolate-chips-blueberries_176474-2965.jpg?w=740&t=st=1695962840~exp=1695963440~hmac=5ee6bb20fe755c1fd0c2facdc9bb6e89f669f0e627ecc7561fb898f9dce8697e",
        productName: "Rainbow Cake",
        isVegProduct: false,
        productRating: 5,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "KG",
            price: 1810,
            offerPrice: 1310,
            cartCounts: 0,
            cartPrice: 0,
          )
        ],
        ratingPeopleCount: 50,
        isFavorite: false,
        productCartCount: 0,
        productCartPrice: 0,
        selectedRedio: 0,
        isBestSeller: false,
        offerStartingDate:
            DateFormat.yMMMd().format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
        offerEndingDate: DateFormat.yMMMd().format(DateTime.now()),
        comboOffersProductName: [
          'Rainbow Cake',
          'Nutella Pastry',
          'CheeseCake',
          'Blue barrey Pastry barrey Pastry barrey Pastry',
          'CheeseCake'
        ],
      ),
      TempProductData(
        productId: 23,
        productImage:
            "https://img.freepik.com/free-photo/fruit-cake-with-chocolate-chips-blueberries_176474-2965.jpg?w=740&t=st=1695962840~exp=1695963440~hmac=5ee6bb20fe755c1fd0c2facdc9bb6e89f669f0e627ecc7561fb898f9dce8697e",
        productName: "Rainbow Cake",
        isVegProduct: false,
        productRating: 5,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "KG",
            price: 1810,
            offerPrice: 1310,
            cartCounts: 0,
            cartPrice: 0,
          )
        ],
        ratingPeopleCount: 50,
        isFavorite: false,
        productCartCount: 0,
        productCartPrice: 0,
        selectedRedio: 0,
        isBestSeller: false,
        offerStartingDate:
            DateFormat.yMMMd().format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
        offerEndingDate: DateFormat.yMMMd().format(DateTime.now()),
        comboOffersProductName: [
          'Rainbow Cake',
          'Nutella Pastry',
          'CheeseCake',
          'Blue barrey Pastry barrey Pastry barrey Pastry',
          'CheeseCake'
        ],
      ),
      TempProductData(
        productId: 24,
        productImage:
            "https://img.freepik.com/free-photo/fruit-cake-with-chocolate-chips-blueberries_176474-2965.jpg?w=740&t=st=1695962840~exp=1695963440~hmac=5ee6bb20fe755c1fd0c2facdc9bb6e89f669f0e627ecc7561fb898f9dce8697e",
        productName: "Rainbow Cake",
        isVegProduct: false,
        productRating: 5,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "KG",
            price: 1810,
            offerPrice: 1310,
            cartCounts: 0,
            cartPrice: 0,
          )
        ],
        ratingPeopleCount: 50,
        isFavorite: false,
        productCartCount: 0,
        productCartPrice: 0,
        selectedRedio: 0,
        isBestSeller: false,
        offerStartingDate:
            DateFormat.yMMMd().format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
        offerEndingDate: DateFormat.yMMMd().format(DateTime.now()),
        comboOffersProductName: [
          'Rainbow Cake',
          'Nutella Pastry',
          'CheeseCake',
          'Blue barrey Pastry barrey Pastry barrey Pastry',
          'CheeseCake'
        ],
      ),
      TempProductData(
        productId: 25,
        productImage:
            "https://img.freepik.com/free-photo/fruit-cake-with-chocolate-chips-blueberries_176474-2965.jpg?w=740&t=st=1695962840~exp=1695963440~hmac=5ee6bb20fe755c1fd0c2facdc9bb6e89f669f0e627ecc7561fb898f9dce8697e",
        productName: "Rainbow Cake",
        isVegProduct: false,
        productRating: 5,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "KG",
            price: 1810,
            offerPrice: 1310,
            cartCounts: 0,
            cartPrice: 0,
          )
        ],
        ratingPeopleCount: 50,
        isFavorite: false,
        productCartCount: 0,
        productCartPrice: 0,
        selectedRedio: 0,
        isBestSeller: false,
        offerStartingDate:
            DateFormat.yMMMd().format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
        offerEndingDate: DateFormat.yMMMd().format(DateTime.now()),
        comboOffersProductName: [
          'Rainbow Cake',
          'Nutella Pastry',
          'CheeseCake',
          'Blue barrey Pastry barrey Pastry barrey Pastry',
          'CheeseCake'
        ],
      ),
      TempProductData(
        productId: 26,
        productImage:
            "https://img.freepik.com/free-photo/fruit-cake-with-chocolate-chips-blueberries_176474-2965.jpg?w=740&t=st=1695962840~exp=1695963440~hmac=5ee6bb20fe755c1fd0c2facdc9bb6e89f669f0e627ecc7561fb898f9dce8697e",
        productName: "Rainbow Cake",
        isVegProduct: false,
        productRating: 5,
        productQuantityList: [
          TempProductQuatityModel(
            quantity: 1,
            quantityType: "KG",
            price: 1810,
            offerPrice: 1310,
            cartCounts: 0,
            cartPrice: 0,
          )
        ],
        ratingPeopleCount: 50,
        isFavorite: false,
        productCartCount: 0,
        productCartPrice: 0,
        selectedRedio: 0,
        isBestSeller: false,
        offerStartingDate:
            DateFormat.yMMMd().format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)),
        offerEndingDate: DateFormat.yMMMd().format(DateTime.now()),
        comboOffersProductName: [
          'Rainbow Cake',
          'Nutella Pastry',
          'CheeseCake',
          'Blue barrey Pastry barrey Pastry barrey Pastry',
          'CheeseCake'
        ],
      ),
    ],
  ),
];
