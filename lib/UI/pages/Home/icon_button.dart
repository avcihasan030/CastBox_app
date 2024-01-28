import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => SearchPage(),
              // ));
            },
            icon: const Icon(Icons.search)),
        IconButton(onPressed: () {
          Navigator.pushNamed(context, 'chatting');
        }, icon: const Icon(Icons.chat)),
      ],
    );
  }
}
