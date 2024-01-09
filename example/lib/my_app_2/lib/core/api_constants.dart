import 'package:bakery_shop_flutter/utils/app_functions.dart';

class ApiConstatnts {
  static const String baseUrl = 'https://bakery.oceanapplications.com/api/v1/';
  static const String liveBaseUrl = 'https://bakery.oceanapplications.com/api/v1/';
  static const String xLocalization = 'en';
  static const String accept = 'application/json';

  var headers = {
    "X-localization": xLocalization,
    "Accept": accept,
    "Content-Type": accept,
    "Authorization": 'Bearer ${AppFunctions().getUserToken() ?? ''}',
  };
}
