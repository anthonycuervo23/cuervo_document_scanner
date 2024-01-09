// ignore_for_file: constant_identifier_names

class AppsFlyerEventNameConstants {
  AppsFlyerEventNameConstants._();

  static const String COMPLETE_REGISTRATION = "af_complete_registration";
  static const String LOGIN = "af_login";
  static const String SEARCH = "af_search";
  static const String CONTENT_VIEW = "af_content_view";
  static const String LISTVIEW = "af_list_view";
  static const String ADD_TO_WISH_LIST = "af_add_to_wish_list";
  static const String ADD_TO_CART = "af_add_to_cart";
  static const String INITIATED_CHECKOUT = "af_initiated_checkout";
  static const String PURCHASE = "af_purchase";
  static const String FIRST_PURCHASE = "first_purchase";
  static const String REMOVE_FROM_CART = "remove_from_cart";
  static const String FAILED_PURCHASE = "caf_failed_purchase";
}

class AppsFlyerEventParamsConstants {
  AppsFlyerEventParamsConstants._();

  static const String REGISTRATION_METHOD = "af_registration_method";
  static const String CONTENT_LIST = "af_content_list";
  static const String SERACH_STRING = "af_search_string";
  static const String PRICE = "af_price";
  static const String CONTENT = "af_content";
  static const String CONTENT_ID = "af_content_id";
  static const String CONTENT_TYPE = "af_content_type";
  static const String CURRENCY = "af_currency";
  static const String QUANTITY = "af_quantity";
  static const String REVENUE = "af_revenue";
  static const String ORDER_ID = "af_order_id";
  static const String RECEIPT_ID = "af_receipt_id";
  static const String BUSINESS_ID = "caf_business_id";
  static const String CONTENT_VIEW_TYPE = "caf_content_view_type";
  static const String PAYMENT_PLAN_PARAMS = "caf_payment_plan_params";
  static const String PAYMENT_RESPONCE = "caf_payment_responce";
}

class AppsflyerParamsConstants {
  AppsflyerParamsConstants._();

  static const String brandDomain = 'https://link.oceanmtechdmt.in/';
  static const String templateId = 'Lp1g';
  static const String brandBaseURL = brandDomain + templateId;
  static const String afXp = 'custom';
  static const bool isRetargeted = true;
  static const String afDP = 'oceanmtechdmt://mainactivity';
  static const String oneLinkAPIEndpoint = 'https://onelink.appsflyer.com/shortlink/v1/$templateId';
  static const String bitlyEndpoint = 'https://api-ssl.bitly.com/v4/shorten';
  static const String apiKey = '';
  static const String afDefaultOgTitle = 'Oceanmtech DMT Application';
  static const String afDefaultOgDescription = 'Make your business branded posts in 10 seconds.';
  static const String afDefaultOgImage = 'https://www.oceanmtech.com/images/logo.png';
  static const String bitlyAPIKey = '8076ed1421f6c1a97d13a1728f86ebc1ef4c1eaa';

  static const String afSinglePostPath = 'single-post';
  static const String afPackageListPath = 'package-list';
  static const String afHelpAndSupportPath = 'help-and-support';
  static const String afWpEnquiryPath = 'wp-enquiry';
  static const String afDigitalVisitingCardPath = 'digital-visiting-card';
  static const String afMydigitalVisitingCardPath = 'my-digital-visiting-card';
  static const String afCatalogPath = 'catalog';
  static const String afBusinessListPath = 'business-list';
  static const String afAddBusinessDetailsPath = 'add-business-details';
  static const String afUserProfilePath = 'user-profile';
  static const String afCustomTemplatePath = 'custom-template';
  static const String afCreateCustomPostPath = 'create-custom-post';
  static const String afLogoTemplatePath = 'logo-template';
  static const String afCustomFramesPath = 'custom-frames';
  static const String afCustomVideoPath = 'custom-video';
  static const String afImageToVideoPath = 'image-to-video';
  static const String afAppNotificationsPath = 'app-notifications';
  static const String afReelsPath = 'reels';
  static const String afReferralPath = 'referral';
  static const String afApplanguagesPath = 'app-languages';
  static const String afFaqsPath = 'faqs';
  static const String afVideoTemplatePath = 'video-template';

  // AppsFlyer Variables

  static const String deepLinkValue = 'deep_link_value';
  static const String matchType = 'match_type';
  static const String clickHttpReferrer = 'click_http_referrer';
  static const String mediaSource = 'media_source';
  static const String campaign = 'campaign';
  static const String campaignId = 'campaign_id';
  static const String afSub1 = 'af_sub1';
  static const String afSub2 = 'af_sub2';
  static const String afSub3 = 'af_sub3';
  static const String afSub4 = 'af_sub4';
  static const String afSub5 = 'af_sub5';
  static const String deferred = 'deferred';
  static const String deepLinkPath = 'deep_link_path';
  static const String afOgTitle = 'af_og_title';
  static const String afOgDescription = 'af_og_description';
  static const String afOgImage = 'af_og_image';
  static const String afForceDeeplink = 'af_force_deeplink';

  // af_xp=custom&pid=dmt_reels&c=dmt_reels&is_retargeting=true&af_dp=oceanmtechdmt%3A%2F%2Fmainactivity&id=42
}
