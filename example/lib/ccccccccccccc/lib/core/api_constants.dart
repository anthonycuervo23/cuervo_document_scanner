class ApiConstatnts {
  // ApiConstatnts._();

  // Dev: 'https://dev.captainscore.com/api/v7'
  // Live: 'https://dmt.captainscore.in/api/v7'

  static const String baseUrl = 'https://dmt.captainscore.in/api/v7';
  static const String liveBaseUrl = 'https://dmt.captainscore.in/api/v7';

  static const String liveBaseUrl1 = 'https://captainscore.in/dmt/api/v7';
  static const String liveBaseUrl2 = 'https://test.captainscore.in/api/v7';
  static const String xLocalization = 'en';
  static const String accept = 'application/json';

  var headers = {
    "X-localization": xLocalization,
    "Accept": accept,
    "Content-Type": accept,
  };
}
