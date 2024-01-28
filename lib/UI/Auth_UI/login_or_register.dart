import 'package:final_year_project/UI/Auth_UI/auth_pages/login_page.dart';
import 'package:final_year_project/UI/Auth_UI/auth_pages/registration_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool displayLoginPage = true;

  void toggleAuthPages() {
    setState(() {
      displayLoginPage = !displayLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (displayLoginPage) {
      return LoginPage(() => toggleAuthPages());
    } else {
      return RegistrationPage(() => toggleAuthPages());
    }
  }
}
