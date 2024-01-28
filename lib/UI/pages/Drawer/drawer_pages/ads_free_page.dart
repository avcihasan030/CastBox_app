import 'package:easy_localization/easy_localization.dart';
import 'package:final_year_project/UI/utils/blur_effect.dart';
import 'package:final_year_project/UI/utils/text_utils.dart';
import 'package:flutter/material.dart';

class AdsFreePage extends StatelessWidget {
  const AdsFreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(TextUtils.adsFreeTitle).tr(),
          backgroundColor: Colors.transparent),
     // drawer: const NavigationDrawerWidget(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/remove_ads.jpeg'),
                  fit: BoxFit.cover),
            ),
            child: const BlurEffect(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(3),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black26)),
                    onPressed: () {},
                    child: const Text(
                      "7 Days Free Trial",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 25),
                  TextButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(3),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black26)),
                    onPressed: () {},
                    child: const Text(
                      "TRY 21.99 / Month",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
