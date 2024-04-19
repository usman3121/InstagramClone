import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/services/controller/post_controller.dart';

class InstagramPostMenu extends StatelessWidget {
  
 final  Post_Controller postController;
  String? postId;
  InstagramPostMenu({super.key, required this.postId, required this.postController});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      elevation: 0.0,
      backgroundColor: Colors.black12,
      child: contentBox(context),
    );
  }


  Widget contentBox(BuildContext context) {
    return Container(
      height: Get.height *0.65,
      width: Get.width*0.65,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,

        color: Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: CircleAvatar(backgroundColor: Colors.blue,radius: 25,child: Icon(Icons.bookmark_border,color: Colors.white,),),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: CircleAvatar(backgroundColor: Colors.blue,radius: 25,child: Icon(Icons.add_to_home_screen,color: Colors.white,),),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: CircleAvatar(backgroundColor: Colors.blue,radius: 25,child: Icon(Icons.qr_code_scanner,color: Colors.white,),),
            ),

          ],),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Text("Save"),
              ),
              Text("Remix"),
              Text("QR code"),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.star_border_outlined,color: Colors.white,),
            title: const Text('Add to Favourite',style: TextStyle(color: Colors.white,),),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.person,color: Colors.white,),
            title: const Text('Unfollow',style: TextStyle(color: Colors.white,),),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.cut_outlined,color: Colors.white,),
            title: const Text('Create a cutout sticker',style: TextStyle(color: Colors.white,),),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.question_mark_outlined,color: Colors.white,),
            title: const Text('Why you are seeing this post',style: TextStyle(color: Colors.white,),),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.heart_broken,color: Colors.white,),
            title: const Text('Hide like commenting',style: TextStyle(color: Colors.white,),),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.comments_disabled_outlined,color: Colors.white,),
            title: const Text('Turn off commenting',style: TextStyle(color: Colors.white,),),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline_outlined,color: Colors.red,),
            title: const Text('Delete',style: TextStyle(color: Colors.white,),),
            onTap: () async {

                await postController!.deletePost(postId ?? '');
                print(postId.toString());


              //postController.deletePost();

            },
          ),
        ],
      ),
    );
  }
}
