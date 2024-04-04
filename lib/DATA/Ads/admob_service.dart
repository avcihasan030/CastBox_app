import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static final String appIdCanli = 'ca-app-pub-5782365253720362/6073651777';
  static final String appIdTest = 'ca-app-pub-3940256099942544/6300978111';

  // String appId = 'ca-app-pub-5782365253720362~9497089139';
  // String adId = 'ca-app-pub-5782365253720362/6073651777';
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5782365253720362/6073651777';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    return null;
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint("Ad loaded!"),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint("Ad failed to load: $error");
    },
    onAdOpened: (ad) => debugPrint("Ad opened"),
    onAdClicked: (ad) => debugPrint("Ad closed"),
  );
}
