// ignore_for_file: unnecessary_null_comparison

import 'dart:math';
import 'package:bakery_shop_admin_flutter/features/customer/data/models/customer_detail_model.dart';
import 'package:bakery_shop_admin_flutter/features/settings/data/models/create_new_model.dart';
import 'package:bakery_shop_admin_flutter/features/shared/domain/entities/app_error.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/counter/counter_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/shared/presentation/cubit/toggle_cubit/toggle_cubit.dart';
import 'package:bakery_shop_admin_flutter/features/supplier/data/models/supplier_model.dart';
import 'package:bakery_shop_admin_flutter/widgets/snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
part 'create_customer_state.dart';

enum CreateNewNavigate { customer, supplier }

enum CheckScreen { product, addProduct }

enum Addresstype { home, work, other }

class CreateCustomerCubit extends Cubit<CreateCustomerState> {
  late ToggleCubit toggleCubit;
  late CounterCubit counterCubit;
  CreateCustomerCubit({required this.counterCubit, required this.toggleCubit}) : super(CreateCustomerLoadingState());

  TextEditingController customerName = TextEditingController();
  TextEditingController customerMobileNumber = TextEditingController();
  TextEditingController customerEmailId = TextEditingController();
  TextEditingController customerGstNumber = TextEditingController();
  TextEditingController customerPanNumber = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController nearbyLanmarkController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  List<FamilyRelationshipDetails> templist = [];
  List<FamilyDetails> familyDetailData = [];
  String? customerDob;
  String? customerAnniversaryDate;
  String formattedDate = '';

  TextEditingController supplierNameController = TextEditingController();
  TextEditingController suppliermobileNumberController = TextEditingController();
  TextEditingController supplieremilController = TextEditingController();
  TextEditingController supplierGstNumberController = TextEditingController();
  TextEditingController supplierpanNumberController = TextEditingController();
  TextEditingController supplierflatNoController = TextEditingController();
  TextEditingController supplierareaController = TextEditingController();
  TextEditingController supplierlandmarkController = TextEditingController();
  TextEditingController shippingAddress = TextEditingController();

  void loadData() {
    emit(
      const CreateCustomerLoadedState(
        selectIndexType: 0,
        familyDetailData: [],
        searcheditems: [],
        selectTabValue: 0,
      ),
    );
  }

  void addFamilyDetails() {
    var loadedState = state as CreateCustomerLoadedState;
    if (familyDetailData.every((element) => element.familyMemberName.text.isNotEmpty)) {
      familyDetailData.add(
        FamilyDetails(
          familyMemberName: TextEditingController(text: ''),
          realationShip: '',
          realationShipToggle: false,
        ),
      );
    } else {
      CustomSnackbar.show(
        snackbarType: SnackbarType.ERROR,
        message: "Enter Name First",
      );
    }
    emit(loadedState.copywith(familyDetailData: familyDetailData, random: Random().nextDouble()));
  }

  void deleteFamilyMember({required int index}) {
    var loadedState = state as CreateCustomerLoadedState;
    familyDetailData.removeAt(index);
    emit(loadedState.copywith(familyDetailData: familyDetailData, random: Random().nextDouble()));
  }

  void changeRelationshipOptions({
    required String selectRelationshipOption,
    required CreateCustomerLoadedState state,
    required int index,
  }) {
    state.familyDetailData[index].realationShip = selectRelationshipOption;
    emit(state.copywith(familyDetailData: state.familyDetailData, random: Random().nextDouble()));
  }

  void serchRelationshipName({required String searchText}) {
    templist.clear();
    var loadedState = state as CreateCustomerLoadedState;
    if (searchText.isNotEmpty) {
      for (var tempProduct in familyDetails) {
        if (((tempProduct.name).toLowerCase()).contains(searchText.toLowerCase().trim())) {
          templist.add(tempProduct);
        }
      }
      emit(loadedState.copywith(
        searcheditems: templist,
        random: Random().nextDouble(),
      ));
    } else {
      emit(loadedState.copywith(
        searcheditems: const [],
        random: Random().nextDouble(),
      ));
    }
  }

  void selectDate({DateTime? date}) {
    var loadedState = state as CreateCustomerLoadedState;
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    formattedDate = formatter.format(date!);
    emit(loadedState.copywith(random: Random().nextDouble()));
  }

  void selectRelationship({required CreateCustomerLoadedState state, required int index}) {
    emit(state.copywith(familyDetailData: state.familyDetailData, random: Random().nextDouble()));
  }

  void selectType({required int selectIndex}) {
    CreateCustomerLoadedState createNewCustomerLoadedState;

    createNewCustomerLoadedState = state as CreateCustomerLoadedState;

    if (createNewCustomerLoadedState != null) {
      emit(createNewCustomerLoadedState.copywith(selectIndexType: selectIndex, random: Random().nextDouble()));
    }
  }

  void supplerEditTextFild({required SupplierDetailModel supplierDetailModel}) {
    supplierNameController = TextEditingController(text: supplierDetailModel.name);
    suppliermobileNumberController = TextEditingController(text: supplierDetailModel.mobileNumber);
    supplieremilController = TextEditingController(text: supplierDetailModel.email);
    supplierGstNumberController = TextEditingController(text: supplierDetailModel.gstNo);
    supplierpanNumberController = TextEditingController(text: supplierDetailModel.panNo);
    supplierareaController = TextEditingController(text: supplierDetailModel.address);
  }

  void referestControllerData({required CustomerDetailModel customerDetailModel}) {
    customerName = TextEditingController(text: customerDetailModel.name);
    customerMobileNumber = TextEditingController(text: customerDetailModel.mobileNumber);
    customerEmailId = TextEditingController(text: customerDetailModel.emailAddress);
    customerDob = customerDetailModel.dateofBirth;
    customerGstNumber = TextEditingController(text: customerDetailModel.gstNo);
    customerPanNumber = TextEditingController(text: customerDetailModel.panNo);
    customerAnniversaryDate = customerDetailModel.anniversaryDate;
  }

  String saveNewSupplier({SupplierDetailModel? supplierDetailModels}) {
    DateTime dateTime = DateTime.now();
    DateFormat formatter = DateFormat('dd MMM yyyy | hh:mm aaa');
    formattedDate = formatter.format(dateTime);
    String status = "Enter Value";
    if (supplierNameController.text.isNotEmpty &&
        suppliermobileNumberController.text.isNotEmpty &&
        supplieremilController.text.isNotEmpty &&
        supplierareaController.text.isNotEmpty &&
        supplierGstNumberController.text.isNotEmpty &&
        supplierpanNumberController.text.isNotEmpty) {
      if (supplierDetailModels == null) {
        SupplierDetailModel supplierDetailModel = SupplierDetailModel(
          id: supplierList.last.id + 1,
          name: supplierNameController.text,
          dateTime: formattedDate,
          mobileNumber: suppliermobileNumberController.text,
          email: supplieremilController.text,
          totalOrderAmount: 0,
          address: supplierareaController.text,
          gstNo: supplierGstNumberController.text,
          panNo: supplierpanNumberController.text,
          productList: [],
        );
        supplierList.add(supplierDetailModel);
        status = "Save";
      } else {
        SupplierDetailModel supplierDetailModel = SupplierDetailModel(
          id: supplierDetailModels.id,
          name: supplierNameController.text,
          dateTime: formattedDate,
          mobileNumber: suppliermobileNumberController.text,
          email: supplieremilController.text,
          totalOrderAmount: 0,
          address: supplierareaController.text,
          gstNo: supplierGstNumberController.text,
          panNo: supplierpanNumberController.text,
          productList: supplierDetailModels.productList,
          amountStatusModel: supplierDetailModels.amountStatusModel,
          balance: supplierDetailModels.balance,
          balanceType: supplierDetailModels.balanceType,
          gst: supplierDetailModels.gst,
          gstAmount: supplierDetailModels.gstAmount,
          orderDate: supplierDetailModels.orderDate,
          orderId: supplierDetailModels.orderId,
          profileImage: supplierDetailModels.profileImage,
          totalAmount: supplierDetailModels.totalAmount,
        );
        int index = supplierList.indexOf(supplierDetailModels);
        supplierList[index] = supplierDetailModel;
        status = "Save";
      }
    }
    return status;
  }

  void saveCustomer() {
    DateTime dateTime = DateTime.now();
    CustomerDetailModel customerDetailModel = CustomerDetailModel(
      balanceType: CustomerBalanceType.ToCollect,
      name: customerName.text,
      emailAddress: customerEmailId.text,
      mobileNumber: customerMobileNumber.text,
      profileImage: "profileImage",
      customerType: CustomerType.New,
      customerBalanceType: CustomerBalanceType.ToPay,
      date: "${dateTime.day}/${dateTime.month}/${dateTime.year}",
      time: "${dateTime.hour}:${dateTime.minute}",
      balance: 0,
      isPending: true,
      dateofBirth: customerDob!,
      anniversaryDate: customerAnniversaryDate!,
      referralCode: "referralCode",
      points: 10,
      totalOrderAmount: 0,
      gstNo: customerGstNumber.text,
      panNo: customerPanNumber.text,
      referList: [],
      familyDetails: [],
      orders: [],
      address: [],
    );
    if (kDebugMode) {
      print(customerDetailModel);
    }
  }

  void showButtonTabbar({required CreateCustomerLoadedState state, required int selectTabValue}) {
    emit(state.copywith(selectTabValue: selectTabValue, random: Random().nextDouble()));
  }

  void update({required CreateCustomerLoadedState state}) {
    emit(state.copywith(random: Random().nextDouble()));
  }
}
