import 'package:final_year_project/UI/Auth_UI/login_or_register.dart';
import 'package:final_year_project/UI/pages/Home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          /// if user is logged in
          if (snapshot.hasData) {
            return const HomePage();
          }
          /// if user is not logged in
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
