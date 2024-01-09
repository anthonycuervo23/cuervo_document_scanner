// ignore_for_file: constant_identifier_names

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ManageImageCache {
  static const HOME_PAGE_IMAGE_KEY = 'HOME_PAGE_IMAGE_KEY';
  static const HOME_PAGE_EVENT_KEY = 'HOME_PAGE_EVENT_KEY';
  static const UPCOMMING_EVENT_IMAGE_KEY = 'UPCOMMING_EVENT_IMAGE_KEY';
  static const VIEW_SINGLE_POST_IMAGE_KEY = 'VIEW_SINGLE_POST_IMAGE_KEY';
  static const VIEW_SINGLE_POST_IMAGE_THUMB_KEY = 'VIEW_SINGLE_POST_IMAGE_THUMB_KEY';

  static const CUSTOM_TEMPLATES_IMAGE_KEY = 'CUSTOM_TEMPLATES_IMAGE_KEY';
  static const SINGLE_TEMPLATES_IMAGE_KEY = 'SINGLE_TEMPLATES_IMAGE_KEY';
  static const MARKETPLACE_IMAGE_KEY = 'MARKETPLACE_IMAGE_KEY';
  static const MARKETPLACE_BUISNESS_LIST_IMAGE_KEY = 'MARKETPLACE_BUISNESS_LIST_IMAGE_KEY';
  static const BUSINESS_PROFILE_SCREEN_IMAGE_KEY = 'BUSINESS_PROFILE_SCREEN_IMAGE_KEY';
  static const MY_BUSINESS_IMAGE_KEY = 'MY_BUSINESS_IMAGE_KEY';
  static const SLIDER_IMAGE_KEY = 'SLIDER_IMAGE_KEY';
  static const BUSINES_VISITING_CARD_IMAGE_KEY = 'BUSINES_VISITING_CARD_IMAGE_KEY';
  static const SINGLE_BUSSINESS_VISITING_CARD_IMAGE_KEY = 'SINGLE_BUSSINESS_VISITING_CARD_IMAGE_KEY';
  static const LOGO_PAGE_IMAGE_KEY = 'LOGO_PAGE_IMAGE_KEY';
  static const SINGLE_LOGO_PAGE_CARD_IMAGE_KEY = 'SINGLE_LOGO_PAGE_CARD_IMAGE_KEY';
  static const SINGLE_LOGO_THUMB_CARD_IMAGE_KEY = 'SINGLE_LOGO_THUMB_CARD_IMAGE_KEY';
  static const FRAME_IMAGE_KEY = 'FRAME_IMAGE_KEY';
  static const SINGLE_FRAME_IMAGE_KEY = 'SINGLE_FRAME_IMAGE_KEY';
  static const MY_DIGITAL_CARD_IMAGE_KEY = 'MY_DIGITAL_CARD_IMAGE_KEY';
  static const MISCELLANEOUS_IMAGE_KEY = 'MISCELLANEOUS_IMAGE_KEY';
  static const ADS_IMAGE_KEY = 'ADS_IMAGE_KEY';

  static CacheManager customCacheManager({required String key, int? days, int? maxCacheObject}) {
    return CacheManager(
      Config(
        key,
        stalePeriod: Duration(days: days ?? 1),
        maxNrOfCacheObjects: maxCacheObject ?? 100,
        repo: JsonCacheInfoRepository(databaseName: key),
      ),
    );
  }

  static final homePageImage = customCacheManager(
    key: HOME_PAGE_IMAGE_KEY,
    days: 1,
    maxCacheObject: 200,
  );

  static final upcommingEventImage = customCacheManager(
    key: UPCOMMING_EVENT_IMAGE_KEY,
    days: 1,
    maxCacheObject: 30,
  );

  static final viewSinglePostImage = customCacheManager(
    key: VIEW_SINGLE_POST_IMAGE_KEY,
    days: 1,
    maxCacheObject: 100,
  );

  static final viewSinglePostThumbImage = customCacheManager(
    key: VIEW_SINGLE_POST_IMAGE_THUMB_KEY,
    days: 1,
    maxCacheObject: 150,
  );

  static final customTemplatesImageManager = customCacheManager(
    key: CUSTOM_TEMPLATES_IMAGE_KEY,
    days: 1,
    maxCacheObject: 100,
  );

  static final singleTemplatesImage = customCacheManager(
    key: SINGLE_TEMPLATES_IMAGE_KEY,
    days: 1,
    maxCacheObject: 100,
  );

  static final marketPlaceImage = customCacheManager(
    key: MARKETPLACE_IMAGE_KEY,
    days: 1,
    maxCacheObject: 100,
  );

  static final marketBusinessListImage = customCacheManager(
    key: MARKETPLACE_BUISNESS_LIST_IMAGE_KEY,
    days: 1,
    maxCacheObject: 100,
  );

  static final businessProfileScreenImage = customCacheManager(
    key: BUSINESS_PROFILE_SCREEN_IMAGE_KEY,
    days: 1,
    maxCacheObject: 100,
  );

  static final myBusinessImage = customCacheManager(
    key: MY_BUSINESS_IMAGE_KEY,
    days: 1,
    maxCacheObject: 20,
  );

  static final sliderImage = customCacheManager(
    key: SLIDER_IMAGE_KEY,
    days: 1,
    maxCacheObject: 30,
  );

  static final businessVisitingCardImage = customCacheManager(
    key: BUSINES_VISITING_CARD_IMAGE_KEY,
    days: 1,
    maxCacheObject: 50,
  );

  static final singleBusinessVisitingCardImage = customCacheManager(
    key: SINGLE_BUSSINESS_VISITING_CARD_IMAGE_KEY,
    days: 1,
    maxCacheObject: 200,
  );

  static final singleLogoPageCardImage = customCacheManager(
    key: SINGLE_LOGO_PAGE_CARD_IMAGE_KEY,
    days: 1,
    maxCacheObject: 50,
  );

  static final singleLogoThumbCardImage = customCacheManager(
    key: SINGLE_LOGO_THUMB_CARD_IMAGE_KEY,
    days: 1,
    maxCacheObject: 100,
  );

  static final frameImage = customCacheManager(
    key: FRAME_IMAGE_KEY,
    days: 1,
    maxCacheObject: 100,
  );

  static final singleFrameImage = customCacheManager(
    key: SINGLE_FRAME_IMAGE_KEY,
    days: 1,
    maxCacheObject: 50,
  );

  static final myDigitalCardImage = customCacheManager(
    key: MY_DIGITAL_CARD_IMAGE_KEY,
    days: 1,
    maxCacheObject: 100,
  );

  static final miscellaneousImage = customCacheManager(
    key: MISCELLANEOUS_IMAGE_KEY,
    days: 1,
    maxCacheObject: 100,
  );

  static final adsImageManager = customCacheManager(
    key: ADS_IMAGE_KEY,
    days: 1,
    maxCacheObject: 100,
  );
}
