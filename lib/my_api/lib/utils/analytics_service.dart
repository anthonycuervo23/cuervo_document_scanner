import 'package:bakery_shop_admin_flutter/global.dart';
import 'package:bakery_shop_admin_flutter/utils/appsflyer_constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: analytics);

  Future logScreens({required String name}) async {
    await analytics.setCurrentScreen(screenName: name);
  }

  Future logFirstLoad() async {
    await analytics.logEvent(name: 'custom_first_open');
  }

  Future<void> logAppEvent({String? eventName, Map<String, dynamic>? eventValues}) async {
    // AppsFlyer Tracking

    if (1 == 1) return;

    Map<String, dynamic>? data = {};
    data.addAll(eventValues ?? {});
    data.addAll(
      {
        "device_data": deviceData,
        "login_number": userLoginData?.mobileNo.toString() ?? '',
        "login_email": userLoginData?.email.toString() ?? '',
        "screen_name": currentRouteName,
        "screen_args": routeArguments.toString(),
      },
    );

    try {
      await appsflyerSdk.logEvent(eventName ?? currentRouteName ?? '', data);
      // ignore: empty_catches
    } on Exception {}

    // Google Analytics Tracking
    try {
      await analytics.logEvent(name: eventName ?? currentRouteName ?? '', parameters: data);
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> tourStarted() async {
    Map<String, dynamic> params = <String, dynamic>{};
    params.addAll({"af_success": "true"}); // tour completed status
    logAppEvent(eventName: "caf_tutorial_started", eventValues: params);
  }

  Future<void> tourBusinessCreated() async {
    Map<String, dynamic> params = <String, dynamic>{};
    params.addAll({"af_success": "true"}); // tour completed status
    logAppEvent(eventName: "caf_tour_business_created", eventValues: params);
  }

  Future<void> tourCompleted() async {
    Map<String, dynamic> params = <String, dynamic>{};
    params.addAll({"af_success": "true"}); // tour completed status
    logAppEvent(eventName: "af_tutorial_completion", eventValues: params);
  }

  Future<void> completeRegistration({required String registrationMethod}) async {
    Map<String, dynamic> registrationParams = <String, dynamic>{};
    registrationParams
        .addAll({AppsFlyerEventParamsConstants.REGISTRATION_METHOD: registrationMethod}); // Type of signup method
    logAppEvent(eventName: AppsFlyerEventNameConstants.COMPLETE_REGISTRATION, eventValues: registrationParams);
  }

  Future<void> postShare({required String description}) async {
    Map<String, dynamic> params = <String, dynamic>{};
    params.addAll({"af_description": description}); // Type of share description
    logAppEvent(eventName: "af_share", eventValues: params);
  }

  Future<void> postDownload({required String description}) async {
    Map<String, dynamic> params = <String, dynamic>{};
    params.addAll({"af_content": description}); // Type of share description
    logAppEvent(eventName: "media_downloaded", eventValues: params);
  }

  Future<void> appOpenFromNotification() async {
    logAppEvent(eventName: "af_opened_from_push_notification", eventValues: {});
  }

  Future<void> login() async {
    logAppEvent(eventName: AppsFlyerEventNameConstants.LOGIN, eventValues: {});
  }

  Future<void> searchEvent({required String serarchString, required String contentList}) async {
    Map<String, dynamic> searchParams = <String, dynamic>{};
    searchParams.addAll({AppsFlyerEventParamsConstants.SERACH_STRING: serarchString}); // Search term
    searchParams.addAll({AppsFlyerEventParamsConstants.CONTENT_LIST: contentList}); // List of content IDs
    logAppEvent(eventName: AppsFlyerEventNameConstants.SEARCH, eventValues: searchParams);
  }

  Future<void> contentView({
    String price = '0',
    String content = '',
    String contentId = '',
    String contentType = '',
    String currency = '',
    String selectedBusinessId = '',
    String viewType = '',
  }) async {
    Map<String, dynamic> contentViewParams = <String, dynamic>{};

    contentViewParams.addAll({AppsFlyerEventParamsConstants.PRICE: price}); // Product price
    contentViewParams.addAll({
      AppsFlyerEventParamsConstants.CONTENT: content
    }); // International Article Number (EAN) when applicable, or other product or content identifier
    contentViewParams.addAll({AppsFlyerEventParamsConstants.CONTENT_ID: contentId}); // Product ID
    contentViewParams.addAll({AppsFlyerEventParamsConstants.CONTENT_TYPE: contentType}); // Product category
    contentViewParams
        .addAll({AppsFlyerEventParamsConstants.CURRENCY: currency}); // Currency in the product details page
    contentViewParams.addAll({AppsFlyerEventParamsConstants.BUSINESS_ID: selectedBusinessId}); // Selected Business Id
    contentViewParams.addAll({AppsFlyerEventParamsConstants.CONTENT_VIEW_TYPE: viewType}); // Content View Type

    logAppEvent(eventName: AppsFlyerEventNameConstants.CONTENT_VIEW, eventValues: contentViewParams);
  }

  /*
    * Event parameters for af_list_view event
      contentType: type of list
      contentList: content ids
    */
  Future<void> listingView({String contentType = '', String contentList = ''}) async {
    Map<String, dynamic> listingViewParams = <String, dynamic>{};
    listingViewParams.addAll({AppsFlyerEventParamsConstants.CONTENT_TYPE: contentType}); // Type of list
    listingViewParams
        .addAll({AppsFlyerEventParamsConstants.CONTENT_LIST: contentList}); // List of content IDs from the category
    logAppEvent(eventName: AppsFlyerEventNameConstants.LISTVIEW, eventValues: listingViewParams);
  }

  Future<void> addToWishlist({
    String price = '',
    String contentId = '',
    String contentType = '',
    String currency = '',
  }) async {
    Map<String, dynamic> addToWishListParams = <String, dynamic>{};
    addToWishListParams.addAll({AppsFlyerEventParamsConstants.PRICE: price}); // Price of the product
    addToWishListParams.addAll({AppsFlyerEventParamsConstants.CONTENT_ID: contentId}); // Product ID
    addToWishListParams.addAll({AppsFlyerEventParamsConstants.CONTENT_TYPE: contentType}); // Product category
    addToWishListParams
        .addAll({AppsFlyerEventParamsConstants.CURRENCY: currency}); // Currency displayed on the product details page
    logAppEvent(eventName: AppsFlyerEventNameConstants.LISTVIEW, eventValues: addToWishListParams);
  }

  Future<void> addToCart({
    String price = '',
    String content = '',
    String contentId = '',
    String contentType = '',
    String currency = '',
    String quantity = '',
  }) async {
    Map<String, dynamic> addToWishListParams = <String, dynamic>{};
    addToWishListParams.addAll({AppsFlyerEventParamsConstants.PRICE: price}); // Product price
    addToWishListParams.addAll({
      AppsFlyerEventParamsConstants.CONTENT: content
    }); // International Article Number (EAN) when applicable, or other product or content identifier
    addToWishListParams.addAll({AppsFlyerEventParamsConstants.CONTENT_ID: contentId}); // Product ID
    addToWishListParams.addAll({AppsFlyerEventParamsConstants.CONTENT_TYPE: contentType}); // Product type
    addToWishListParams.addAll({AppsFlyerEventParamsConstants.CURRENCY: currency}); // Product currency
    addToWishListParams.addAll({
      AppsFlyerEventParamsConstants.QUANTITY: quantity
    }); // How many items of the same product were added to the cart
    logAppEvent(eventName: AppsFlyerEventNameConstants.ADD_TO_CART, eventValues: addToWishListParams);
  }

  Future<void> initiatedCheckout({
    String price = '',
    String contentId = '',
    String contentType = '',
    String currency = '',
    String quantity = '',
    Map<String, dynamic> paymentParams = const {},
  }) async {
    Map<String, dynamic> checkoutParams = <String, dynamic>{};
    checkoutParams.addAll({AppsFlyerEventParamsConstants.PRICE: price}); // Total price in the cart
    checkoutParams.addAll({AppsFlyerEventParamsConstants.CONTENT_ID: contentId}); // ID of products in the cart
    checkoutParams.addAll({AppsFlyerEventParamsConstants.CONTENT_TYPE: contentType}); // List of product categories
    checkoutParams.addAll({AppsFlyerEventParamsConstants.CURRENCY: currency}); // Currency during time of checkout
    checkoutParams.addAll({AppsFlyerEventParamsConstants.QUANTITY: quantity}); // Total number of items in the cart
    checkoutParams.addAll(
        {AppsFlyerEventParamsConstants.PAYMENT_PLAN_PARAMS: paymentParams}); // Total number of items in the cart
    logAppEvent(eventName: AppsFlyerEventNameConstants.INITIATED_CHECKOUT, eventValues: checkoutParams);
  }

  Future<void> failedPurchase({
    String revenue = '',
    String price = '',
    String content = '',
    String contentId = '',
    String contentType = '',
    String currency = '',
    String quantity = '',
    String orderId = '',
    String receiptId = '',
    Map<String, dynamic> paymentResponce = const {},
  }) async {
    Map<String, dynamic> purchaseParams = <String, dynamic>{};

    purchaseParams.addAll({
      AppsFlyerEventParamsConstants.REVENUE: revenue
    }); // Estimated revenue from the purchase. The revenue value should not contain comma separators, currency,
    purchaseParams.addAll({AppsFlyerEventParamsConstants.PRICE: price}); // Overall purchase sum
    purchaseParams.addAll({
      AppsFlyerEventParamsConstants.CONTENT: content
    }); // International Article Number (EAN) when applicable, or other product or content identifier
    purchaseParams.addAll({AppsFlyerEventParamsConstants.CONTENT_ID: contentId}); // Item ID
    purchaseParams.addAll({AppsFlyerEventParamsConstants.CONTENT_TYPE: contentType}); // Item category
    purchaseParams.addAll({AppsFlyerEventParamsConstants.CURRENCY: currency}); // Currency code
    purchaseParams.addAll({AppsFlyerEventParamsConstants.QUANTITY: quantity}); // Number of items in the cart
    purchaseParams.addAll(
        {AppsFlyerEventParamsConstants.ORDER_ID: orderId}); // ID of the order that is generated after the purchase
    purchaseParams.addAll({AppsFlyerEventParamsConstants.RECEIPT_ID: receiptId}); // Order ID
    purchaseParams.addAll({AppsFlyerEventParamsConstants.PAYMENT_RESPONCE: paymentResponce}); // Payment Responce
    logAppEvent(eventName: AppsFlyerEventNameConstants.FAILED_PURCHASE, eventValues: purchaseParams);
  }

  Future<void> purchase({
    String revenue = '',
    String price = '',
    String content = '',
    String contentId = '',
    String contentType = '',
    String currency = '',
    String quantity = '',
    String orderId = '',
    String receiptId = '',
    Map<String, dynamic> paymentResponce = const {},
  }) async {
    Map<String, dynamic> purchaseParams = <String, dynamic>{};

    purchaseParams.addAll({
      AppsFlyerEventParamsConstants.REVENUE: revenue
    }); // Estimated revenue from the purchase. The revenue value should not contain comma separators, currency,
    purchaseParams.addAll({AppsFlyerEventParamsConstants.PRICE: price}); // Overall purchase sum
    purchaseParams.addAll({
      AppsFlyerEventParamsConstants.CONTENT: content
    }); // International Article Number (EAN) when applicable, or other product or content identifier
    purchaseParams.addAll({AppsFlyerEventParamsConstants.CONTENT_ID: contentId}); // Item ID
    purchaseParams.addAll({AppsFlyerEventParamsConstants.CONTENT_TYPE: contentType}); // Item category
    purchaseParams.addAll({AppsFlyerEventParamsConstants.CURRENCY: currency}); // Currency code
    purchaseParams.addAll({AppsFlyerEventParamsConstants.QUANTITY: quantity}); // Number of items in the cart
    purchaseParams.addAll(
        {AppsFlyerEventParamsConstants.ORDER_ID: orderId}); // ID of the order that is generated after the purchase
    purchaseParams.addAll({AppsFlyerEventParamsConstants.RECEIPT_ID: receiptId}); // Order ID
    purchaseParams.addAll({AppsFlyerEventParamsConstants.PAYMENT_RESPONCE: paymentResponce}); // Payment Responce
    logAppEvent(eventName: AppsFlyerEventNameConstants.PURCHASE, eventValues: purchaseParams);
  }

  Future<void> firstPurchase({
    String revenue = '',
    String price = '',
    String content = '',
    String contentId = '',
    String contentType = '',
    String currency = '',
    String quantity = '',
    String orderId = '',
    String receiptId = '',
    Map<String, dynamic> paymentResponce = const {},
  }) async {
    Map<String, dynamic> purchaseParams = <String, dynamic>{};

    purchaseParams.addAll({AppsFlyerEventParamsConstants.REVENUE: revenue}); // Revenue from purchase
    purchaseParams.addAll({AppsFlyerEventParamsConstants.PRICE: price}); // Overall purchase sum
    purchaseParams.addAll({
      AppsFlyerEventParamsConstants.CONTENT: content
    }); // International Article Number (EAN) when applicable, or other product or content identifier
    purchaseParams.addAll({AppsFlyerEventParamsConstants.CONTENT_ID: contentId}); // Item ID
    purchaseParams.addAll({AppsFlyerEventParamsConstants.CONTENT_TYPE: contentType}); // Item category
    purchaseParams.addAll({AppsFlyerEventParamsConstants.CURRENCY: currency}); // Currency
    purchaseParams.addAll({AppsFlyerEventParamsConstants.QUANTITY: quantity}); // Quantity of items in the cart
    purchaseParams.addAll(
        {AppsFlyerEventParamsConstants.ORDER_ID: orderId}); // ID of the order that is generated after the purchase
    purchaseParams.addAll({AppsFlyerEventParamsConstants.RECEIPT_ID: receiptId}); // Order ID
    purchaseParams.addAll({AppsFlyerEventParamsConstants.PAYMENT_RESPONCE: paymentResponce}); // Order ID
    logAppEvent(eventName: AppsFlyerEventNameConstants.FIRST_PURCHASE, eventValues: purchaseParams);
  }

  Future<void> removeFromCart({
    String contentId = '',
    String contentType = '',
  }) async {
    Map<String, dynamic> purchaseParams = <String, dynamic>{};
    purchaseParams.addAll({AppsFlyerEventParamsConstants.CONTENT_ID: contentId}); // Item or product ID
    purchaseParams.addAll({AppsFlyerEventParamsConstants.CONTENT_TYPE: contentType}); // Item or product category
    logAppEvent(eventName: AppsFlyerEventNameConstants.REMOVE_FROM_CART, eventValues: purchaseParams);
  }
}
