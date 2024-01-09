import 'package:flutter/material.dart';

class FamilyDetails {
  TextEditingController name;
  TextEditingController realationShip;
  String? dateOfBirth;
  String? dateOfAnniversary;

  FamilyDetails({
    required this.name,
    required this.realationShip,
    required this.dateOfBirth,
    required this.dateOfAnniversary,
  });
}
