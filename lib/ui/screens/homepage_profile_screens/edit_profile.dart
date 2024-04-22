import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/services/controller/post_controller.dart';
import 'package:instagram/services/controller/registration_controller.dart';

class EditProfile extends StatefulWidget {
  final String? username, bio, docId;

  const EditProfile({super.key, this.username, this.bio, this.docId});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  RegistrationController registerController = Get.put(RegistrationController());
  Post_Controller userModel = Get.put(Post_Controller());

  @override
  void initState() {
    registerController.usernameController.text = widget.username ?? 'username';
    registerController.bioController.text = widget.bio ?? 'bio';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Edit profile",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            userModel.getUpdatedUserData(
                registerController.usernameController.text.toString(),
                widget.docId ?? '',
                registerController.bioController.text.toString());
            print(
                'userNameController is: ${registerController.usernameController.text}, '
                    'widget id is: ${widget.docId ?? ''}, '
                    'bioController is: ${registerController.bioController.text}');

            Get.back();
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.06,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150',
                ),
              ),
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "Edit Picture or avatar",
                  style: TextStyle(fontSize: 13, color: Colors.blue),
                )),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Change the color here
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Change the color here
                  ),
                  label: Text(
                    "Name",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: registerController.usernameController,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Change the color here
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Change the color here
                  ),
                  label: Text(
                    "Username",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: registerController.bioController,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Change the color here
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Change the color here
                  ),
                  label: Text(
                    "Bio",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}