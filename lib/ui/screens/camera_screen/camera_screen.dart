import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instagram/services/model/post_model.dart';
import 'package:instagram/ui/router/app_routes.dart';
import '../../../services/controller/imageController.dart';
import '../../../services/controller/post_controller.dart';
import '../../../services/model/user_model.dart';
import '../bottom_navigation_screen.dart';

class CameraScreen extends StatelessWidget {

  CameraScreen({super.key});
 final Post_Controller postController = Get.put(Post_Controller());
  final UserModel users = UserModel();
  final PostModel post =PostModel();
  @override
  Widget build(BuildContext context) {
    final ImagePickerController controller = Get.put(ImagePickerController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon:  Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //postController.addUserData();
                      postController.addPost();
                      //print("hello from user model : ${users.followers.toString()}");
                      print("hello from post model printing image url: ${post.imageUrl.toString()}");
                      Get.to(const BottomNavigationScreen());
                    },
                  ),
                  const Text(
                    'New Reel',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.15,
                child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 1,
                  children: [
                    GestureDetector(
                      onTap: () async{
                        await controller.pickImageFromCamera();
                         postController.addPost();
                      },
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[900],
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                            Text("Camera"),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()async{
                        await controller.pickImageFromGallery();
                        await postController.addPost();
                        print(postController.addPost.toString());
                        await Get.toNamed(App_Routes.HomePage);

                      },
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[900],
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.add_box_outlined,
                              color: Colors.white,
                            ),
                            Text("Drafts"),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[900],
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              color: Colors.white,
                            ),
                            Text("template"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 230),
                child: Text(
                  "Recents ⌄",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => SizedBox(
                  height: Get.height * 5,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: controller.galleryImages.length,
                    itemBuilder: (context, index) {
                      return Image.file(
                        File(controller.galleryImages[index]),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        //postController.addUserData();
        //postController.addPost();
        postController.update();
        //print("hello from user model : ${users.followers.toString()}");
        //Get.to(const BottomNavigationScreen());
      },child: Icon(Icons.add),),
    );
  }
}
