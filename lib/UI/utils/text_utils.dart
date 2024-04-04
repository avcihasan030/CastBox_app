import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextUtils {
  TextUtils._();
  //final Color _defaultTitleTextColor = Colors.purple;
  static String mainTitle = 'Podcasts';
  static String featuredTabTitle = 'FEATURED';
  static String trendingTabTitle = 'TRENDING';
  static String categoryTabTitle = 'CATEGORIES';
  static String networkTabTitle = 'NETWORKS';
  static String trackTabTitle = 'TRACKS';
  static String recommendationsTabTitle = 'FOR YOU';
  static String regionTitle = "Region";
  static String selectRegion = "Select Region";
  static String tooltipTitle = "Show Menu";
  static String subscribedTitle = "Subscribed";
  static String historyTitle = "History";
  static String adsFreeTitle = "Ads Free";
  static String settingsTitle = "Settings";
  static String profileTitle = "Profile";
  static String appearanceTitle = "Appearance";
  static String notificationTitle = "Notification";
  static String languageTitle = "Language";
  static String purchasesTitle = "Purchases";
  static String reportsTitle = "Reports";
  static String aboutTitle = "About";
  static String sendText = "Send";
  static String cancel = "Cancel";
  static String infoText = "Report";
  static String hintText = "Please input write your reports here";

  static TextStyle getTabTitleTextStyle() => const TextStyle(fontSize: 18);

  static TextStyle getPlaylistTitleTextStyle() => const TextStyle();

  static TextStyle getPodcastTitleTextStyle() => const TextStyle();

  static TextStyle getCategoriesTitleTextStyle() => const TextStyle();

  static TextStyle getAppBarTitleTextStyle() =>
      const TextStyle(color: Colors.black, fontSize: 22);

  static getDescriptionLabelTextStyle() =>
      GoogleFonts.aboreto(color: Colors.black45, fontSize: 18);

  static getDescriptionTextStyle() =>
      GoogleFonts.aboreto(color: Colors.black87, fontSize: 14);

  static String getAppBarTitle(String title) {
    return title;
  }
}
