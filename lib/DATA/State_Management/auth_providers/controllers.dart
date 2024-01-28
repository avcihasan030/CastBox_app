import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final passwordControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final nameControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final confirmPasswordControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});
