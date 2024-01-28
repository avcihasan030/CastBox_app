import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_year_project/DATA/Auth/auth_gate.dart';
import 'package:final_year_project/DATA/State_Management/api_providers/spotify_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late Future<String> _accessTokenFuture;
  String imgUrl = 'https://th.bing.com/th/id/OIG.sDuadoPVg4d99oUZqNJY?w=270&h=270&c=6&r=0&o=5&dpr=1.3&pid=ImgGn';

  @override
  void initState() {
    super.initState();
    _accessTokenFuture = ref.read(accessTokenProvider.future);

    /// Splash screen açıldıktan sonra bekleyip ardından ana sayfaya yönlendir
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FutureBuilder(
            future: _accessTokenFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return const AuthGate();
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  fit: BoxFit.fill,
                  height: 100,
                  width: 100,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "CastBox",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
