import 'package:flutter/material.dart';

class FamilyRelationshipDetails {
  String name;
  FamilyRelationshipDetails({
    required this.name,
  });

  toLowerCase() {}
}

List<FamilyRelationshipDetails> familyDetails = [
  FamilyRelationshipDetails(name: "Father"),
  FamilyRelationshipDetails(name: "Mother"),
  FamilyRelationshipDetails(name: "Wife"),
  FamilyRelationshipDetails(name: "Daughter"),
  FamilyRelationshipDetails(name: "Father"),
  FamilyRelationshipDetails(name: "Mother"),
  FamilyRelationshipDetails(name: "Wife"),
  FamilyRelationshipDetails(name: "Daughter"),
];

class FamilyDetails {
  TextEditingController familyMemberName;
  String realationShip;
  String? dateOfBirth;
  String? dateOfAnniversary;
  bool realationShipToggle;

  FamilyDetails({
    required this.familyMemberName,
    required this.realationShip,
    this.dateOfBirth,
    this.dateOfAnniversary,
    required this.realationShipToggle,
  });
}
