// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum PayMentType { Cash, Cheque, Credit_card, Online }

// enum CategoryType { Main_Category, Sub_Category, nd_Sub_Category }

class SelectCategoryModel {
  ExpenseCategory category;
  final List<ItemDetailModel> itemList;
  final ExpansesModel expansesModel;
  double grandTotal;

  SelectCategoryModel({
    required this.itemList,
    required this.expansesModel,
    required this.grandTotal,
    required this.category,
  });
}

class ExpansesModel {
  final String expenseInvoiceNumber;
  final String partyName;
  final String expenseCategory;
  final String date;
  final PayMentType paymentType;
  final String notes;
  final String imagePath;

  ExpansesModel({
    required this.expenseInvoiceNumber,
    required this.partyName,
    required this.expenseCategory,
    required this.date,
    required this.paymentType,
    required this.notes,
    required this.imagePath,
  });
}

class SelectBankModel {
  final String bankName;
  final String date;
  final String openingBalance;

  SelectBankModel({
    required this.bankName,
    required this.date,
    required this.openingBalance,
  });
}

class ItemDetailModel {
  final String balance;
  final String date;
  final String time;
  final List<ItemModel> itemList;
  double total;

  ItemDetailModel({
    required this.balance,
    required this.date,
    required this.time,
    required this.itemList,
    required this.total,
  });
}

class ItemModel {
  final String itemName;
  final String itemQty;
  final String itemRate;

  ItemModel({
    required this.itemName,
    required this.itemQty,
    required this.itemRate,
  });
}

class ItemListModel {
  final TextEditingController itemController;
  final TextEditingController qtyController;
  final TextEditingController amountController;

  ItemListModel({
    required this.itemController,
    required this.qtyController,
    required this.amountController,
  });
}

class ExpenseCategory {
  final String categoryName;
  final String categoryType;
  ExpenseCategory({required this.categoryName, required this.categoryType});
}

List<SelectCategoryModel> listOfExpanses = [
  SelectCategoryModel(
    grandTotal: 4740,
    category: ExpenseCategory(
      categoryName: availableExpenseCategory[1].categoryName,
      categoryType: availableExpenseCategory[1].categoryType,
    ),
    itemList: [
      ItemDetailModel(
        balance: "0.0",
        date: "07 Dec 2023",
        time: "11:10 PM",
        total: 2550,
        itemList: [
          ItemModel(
            itemName: "Sugar (1kg)",
            itemQty: "2",
            itemRate: "250",
          ),
          ItemModel(
            itemName: "Sugar (2kg)",
            itemQty: "2",
            itemRate: "350",
          ),
          ItemModel(
            itemName: "Sugar (3kg)",
            itemQty: "3",
            itemRate: "450",
          ),
          ItemModel(
            itemName: "Sugar (3kg)",
            itemQty: "3",
            itemRate: "450",
          ),
          ItemModel(
            itemName: "Sugar (3kg)",
            itemQty: "3",
            itemRate: "450",
          ),
        ],
      ),
      ItemDetailModel(
        balance: "0.0",
        date: "08 Dec 2023",
        time: "12:10 PM",
        total: 2000,
        itemList: [
          ItemModel(
            itemName: "Sugar (100gm)",
            itemQty: "1",
            itemRate: "200",
          ),
          ItemModel(
            itemName: "Sugar (200gm)",
            itemQty: "2",
            itemRate: "300",
          ),
          ItemModel(
            itemName: "Sugar (300gm)",
            itemQty: "3",
            itemRate: "400",
          ),
          ItemModel(
            itemName: "Sugar (300gm)",
            itemQty: "3",
            itemRate: "400",
          ),
          ItemModel(
            itemName: "Sugar (300gm)",
            itemQty: "3",
            itemRate: "400",
          ),
        ],
      ),
      ItemDetailModel(
        balance: "0.0",
        date: "09 Dec 2023",
        time: "10:10 PM",
        total: 190,
        itemList: [
          ItemModel(
            itemName: "Salt (1kg)",
            itemQty: "1",
            itemRate: "25",
          ),
          ItemModel(
            itemName: "Salt (2kg)",
            itemQty: "2",
            itemRate: "30",
          ),
          ItemModel(
            itemName: "Salt (3kg)",
            itemQty: "3",
            itemRate: "35",
          ),
          ItemModel(
            itemName: "Salt (3kg)",
            itemQty: "3",
            itemRate: "35",
          ),
          ItemModel(
            itemName: "Salt (3kg)",
            itemQty: "3",
            itemRate: "35",
          ),
        ],
      ),
    ],
    expansesModel: ExpansesModel(
      expenseInvoiceNumber: "",
      partyName: "",
      expenseCategory: "",
      date: "",
      paymentType: PayMentType.Credit_card,
      notes: "Make a good Cake",
      imagePath: "https://d1avenlh0i1xmr.cloudfront.net/6cf6c95a-77de-4b85-9955-b4e96fd698db/untitled.png",
    ),
  ),
];

final List<String> availablCategoryType = ["Main Category", "Sub Category", "2nd Sub Category"];
List<ExpenseCategory> availableExpenseCategory = [
  ExpenseCategory(categoryName: "Category 1", categoryType: availablCategoryType[1]),
  ExpenseCategory(categoryName: "Category 2", categoryType: availablCategoryType[2]),
  ExpenseCategory(categoryName: "Category 3", categoryType: availablCategoryType[0]),
  ExpenseCategory(categoryName: "Category 4", categoryType: availablCategoryType[2]),
];
