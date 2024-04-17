import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageTopBar extends StatelessWidget {
  const HomePageTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.lock,
              color: Colors.white),
          onPressed: () {},
        ),
        Text('Username'),
        SizedBox(width: Get.width * 0.12,),
        IconButton(
          icon: const Icon(Icons.alternate_email,
              color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.add_box_outlined,
              color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.line_weight_sharp,
              color: Colors.white),
          onPressed: () {},
        ),

      ],
    );
  }
}