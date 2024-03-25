import 'package:final_year_project/DATA/Models/settings_model.dart';
import 'package:final_year_project/UI/utils/text_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final settingsProvider = Provider<List<Settings>>((ref) {
  return [
    Settings(type: TextUtils.profileTitle, settingIcon: Icons.person),
    Settings(
        type: TextUtils.appearanceTitle, settingIcon: Icons.palette_outlined),
    Settings(
        type: TextUtils.notificationTitle,
        settingIcon: Icons.notifications_active_outlined),
    Settings(
        type: TextUtils.purchasesTitle,
        settingIcon: Icons.account_balance_wallet_outlined),
    Settings(
        type: TextUtils.reportsTitle, settingIcon: Icons.bug_report_outlined),
    Settings(type: TextUtils.aboutTitle, settingIcon: Icons.info_outline),
  ];
});
