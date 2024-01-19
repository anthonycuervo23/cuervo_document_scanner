import 'dart:convert';

class DeepLinkData {
  DeepLinkData(this._clickEvent);
  final Map<String, dynamic> _clickEvent;
  Map<String, dynamic> get clickEvent => _clickEvent;
  String? get deepLinkValue => _clickEvent["deep_link_value"].toString();
  String? get matchType => _clickEvent["match_type"].toString();
  String? get clickHttpReferrer => _clickEvent["click_http_referrer"].toString();
  String? get mediaSource => _clickEvent["media_source"].toString();
  String? get campaign => _clickEvent["campaign"].toString();
  String? get campaignId => _clickEvent["campaign_id"].toString();
  String? get afSub1 => _clickEvent["af_sub1"].toString();
  String? get afSub2 => _clickEvent["af_sub2"].toString();
  String? get afSub3 => _clickEvent["af_sub3"].toString();
  String? get afSub4 => _clickEvent["af_sub4"].toString();
  String? get afSub5 => _clickEvent["af_sub5"].toString();
  bool get isDeferred => bool.tryParse(_clickEvent["is_deferred"]) ?? false;
  String? get deepLinkPath => _clickEvent["deep_link_path"]?.toString();

  @override
  String toString() {
    return 'DeepLink: ${jsonEncode(_clickEvent)}';
  }

  String? getStringValue(String key) {
    return _clickEvent[key] as String;
  }
}
