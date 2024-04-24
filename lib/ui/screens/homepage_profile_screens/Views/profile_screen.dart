import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/ui/widgets/stories_bar.dart';
import 'package:instagram/ui/screens/homepage_profile_screens/Views/edit_profile.dart';
import '../../../../services/authentication/firebaseservices.dart';
import '../../../../services/authentication/userServices.dart';
import '../controller/edit_profile_controller.dart';
import '../controller/post_controller.dart';
import '../../registry/controller/registration_controller.dart';
import '../../../../services/model/post_model.dart';
import '../../../../services/model/user_model.dart';
import '../../../components/homepagetopbar.dart';
import '../../../components/tabs.dart';
import 'open_post_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final RegistrationAndLoginController controller =
      Get.put(RegistrationAndLoginController());
  final PostController postController = Get.put(PostController());
  FirebaseServices services = Get.put(FirebaseServices());
  List<UserModel> userData = [];
  List<PostModel> postData = [];
  final UserServices userService = Get.put(UserServices());
  final FirebaseServices firebaseServices = Get.put(FirebaseServices());
  RegistrationAndLoginController registerController =
      Get.put(RegistrationAndLoginController());
  final EditProfileController editController = Get.put(EditProfileController());

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchPostData();
  }

  Future<void> fetchUserData() async {
    List data = await postController.getUserData();
    setState(() {
      userData = data as List<UserModel>;
    });
  }

  Future<void> fetchPostData() async {
    List data = await postController.getPosts();
    setState(() {
      postData = data as List<PostModel>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              HomePageTopBar(userData: userData),
              if (userData.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          postData.last.imageUrl ??
                              'https://via.placeholder.com/150',
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("${postData.length}"),
                            const Text("posts"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("${userData.first.followers ?? ''}"),
                            const Text("followers"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("${userData.first.following ?? ''}"),
                            const Text("following"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Obx(() => Text(editController.userName.toString())),
                    Obx(() => Text(editController.bio.toString())),
              /*      if (userData.isNotEmpty && userData[0].bio != null)
                      Obx(() => Text(userData[0].bio.toString())),
                    if (userData.isNotEmpty && userData[0].userName != null)
                      Text(userData[0].userName.toString()),*/
                                              /*
                                Obx(() => Text(registerController
                                    .usernameController.value.text
                                    .toString())),
                                Obx(() => Text(registerController.bioController.value.text
                                    .toString())),*/
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey[800] ?? Colors.grey),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size.fromHeight(30)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          print('bio is: ${userData[0].bio}, '
                              'username  is: ${userData[0].userName ?? ''}, '
                              'user id is is: ${firebaseServices.getCurrentUserID()}');
                          Get.to(EditProfile(
                            bio: userData[0].bio,
                            username: userData[0].userName,
                            docId: userService.firebaseServices.getCurrentUserID(),
                          ));
                        },
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey[800] ?? Colors.grey),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size.fromHeight(30)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Share profile",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StoriesBar(
                postController: postController,
              ),
              DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white,
                      tabs: [
                        Tab(
                          icon: Icon(Icons.grid_on_outlined),
                        ),
                        Tab(
                          icon: Icon(Icons.movie_creation_outlined),
                        ),
                        Tab(
                          icon: Icon(Icons.person_2_outlined),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height -
                          200, // Adjust height as needed
                      child: TabBarView(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: StreamBuilder<List<PostModel>>(
                                  stream: postController.fetchPost(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text('Error: ${snapshot.error}'));
                                    } else if (snapshot.hasData &&
                                        snapshot.data!.isNotEmpty) {
                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(const OpenPostScreen());
                                        },
                                        child: GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 8.0,
                                            mainAxisSpacing: 8.0,
                                          ),
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            final post = snapshot.data![index];
                                            return Card(
                                              color: Colors.black,
                                              child: Image.network(
                                                post.imageUrl ??
                                                    'https://via.placeholder.com/150',
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                          child: Text('No posts available'));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const tabTest(),
                          const tabTest(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
