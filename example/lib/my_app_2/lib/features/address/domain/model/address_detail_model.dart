import 'package:bakery_shop_flutter/features/address/presentation/cubit/add_address_cubit/add_address_cubit.dart';

class AddressDetailModel {
  AddAddressType addressType;
  String address;
  String mobileNo;
  String name;
  String distance;
  bool isCheckDefaultAddress = false;
  bool isAddress = false;
  bool isCartOtherOption = false;

  AddressDetailModel({
    required this.addressType,
    required this.address,
    required this.mobileNo,
    required this.name,
    required this.distance,
    required this.isCheckDefaultAddress,
    required this.isAddress,
    required this.isCartOtherOption,
  });
}

List<AddressDetailModel> listOfAddress = [
  AddressDetailModel(
    isAddress: true,
    isCheckDefaultAddress: true,
    isCartOtherOption: false,
    addressType: AddAddressType.home,
    address:
        "4012, palladium Mall, Above -Dairy Don, Yogi Chowk,Puna Gam Surat-395010.alladium Mall, Above -Dairy Don, Yogi Chowk,Punalladium Mall, Above -Dairy Don, Yogi Chowk,Punalladium Mall, Above -Dairy Don, Yogi Chowk,Punalladium Mall, Above -Dairy Don, Yogi Chowk,Pun",
    mobileNo: "+91 6325487549",
    name: "Mihir",
    distance: "4.5 km",
  ),
];
