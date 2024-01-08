import 'package:bakery_shop_admin_flutter/utils/app_functions.dart';

class ApiConstatnts {
  static const String baseUrl = 'https://bakery.oceanapplications.com/api/account_panel/v1/';
  static const String liveBaseUrl = '';
  static const String xLocalization = 'en';
  static const String accept = 'application/json';

  var headers = {
    "X-localization": xLocalization,
    "Accept": accept,
    "Content-Type": accept,
    "Authorization": 'Bearer ${AppFunctions().getUserToken() ?? ''}',
  };
}
