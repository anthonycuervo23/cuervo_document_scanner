// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class OfferDetailsModel extends Equatable {
  String offerTital;
  String offerDescripption;
  String cuponText;
  String price;
  String validUntil;
  String maxPrice;
  int offerId;
  String orderLimit;
  String date;
  String endDate;

  OfferDetailsModel(
      {required this.offerTital,
      required this.offerDescripption,
      required this.cuponText,
      required this.price,
      required this.validUntil,
      required this.maxPrice,
      required this.date,
      required this.offerId,
      required this.endDate,
      required this.orderLimit});

  @override
  List<Object?> get props => [
        offerTital,
        offerDescripption,
        cuponText,
        price,
        validUntil,
        maxPrice,
        date,
        endDate,
        offerId,
        orderLimit,
      ];
}

List<OfferDetailsModel> offerData = [
  OfferDetailsModel(
    offerId: 1,
    offerTital: "Flat 20% Off",
    offerDescripption: "Offer valid once per customer during campaign period.",
    cuponText: "BAKE5240",
    price: "500",
    validUntil: "Valid until:",
    maxPrice: "200",
    date: "25/12/2023",
    endDate: "28/12/2023",
    orderLimit: "5",
  ),
  OfferDetailsModel(
    offerId: 2,
    offerTital: "15% Off up to ₹125",
    offerDescripption: "Offer valid once per customer during campaign period.",
    cuponText: "BAKE5240",
    price: "500",
    validUntil: "Valid until:",
    maxPrice: "200",
    date: "25/12/2023",
    endDate: "29/12/2023",
    orderLimit: "3",
  ),
  OfferDetailsModel(
    offerId: 3,
    offerTital: "Flat 20% Off",
    offerDescripption: "Offer valid once per customer during campaign period.",
    cuponText: "BAKE5240",
    price: "500",
    validUntil: "Valid until:",
    maxPrice: "200",
    date: "25/12/2023",
    endDate: "28/12/2023",
    orderLimit: "10",
  ),
  OfferDetailsModel(
    offerId: 4,
    offerTital: "Flat ₹250 Off",
    offerDescripption: "Offer valid once per customer during campaign period.",
    cuponText: "BAKE5240",
    price: "200",
    validUntil: "Valid until:",
    maxPrice: "400",
    endDate: "25/12/2023",
    date: "28/12/2023",
    orderLimit: "3",
  ),
  OfferDetailsModel(
    offerId: 5,
    offerTital: "Flat 20% Off",
    offerDescripption: "Offer valid once per customer during campaign period.",
    cuponText: "BAKE5240",
    price: "800",
    endDate: "25/12/2023",
    validUntil: "Valid until:",
    maxPrice: "200",
    date: "28/12/2023",
    orderLimit: "2",
  ),
];
