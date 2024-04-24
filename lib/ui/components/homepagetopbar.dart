import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/ui/screens/homepage_profile_screens/controller/post_controller.dart';
import 'package:instagram/ui/screens/registry/controller/registration_controller.dart';

import '../../services/model/user_model.dart';

class HomePageTopBar extends StatelessWidget {
   HomePageTopBar({
    super.key,
    required this.userData,
  });

  final List<UserModel> userData;
 RegistrationAndLoginController controller = Get.put(RegistrationAndLoginController());

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.lock, color: Colors.white),
          onPressed: () {},
        ),
        if (userData.isNotEmpty)
        Text(
          userData.first.userName ?? "",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        SizedBox(
          width: Get.width * 0.08,
        ),
        IconButton(
          icon: const Icon(Icons.alternate_email, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.add_box_outlined, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.line_weight_sharp, color: Colors.white),
          onPressed: () {
            controller.logout();
          },
        ),
      ],
    );
  }
}
