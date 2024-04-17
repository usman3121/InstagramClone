import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/services/controller/imageController.dart';
import 'package:instagram/services/controller/stories_bar.dart';
import 'package:instagram/ui/screens/homepage_profile_screens/edit_profile.dart';
import '../../../services/controller/post_controller.dart';
import '../../../services/controller/registration_controller.dart';
import '../../../services/controller/stories_controller.dart';
import '../../../services/model/user_model.dart';
import '../../components/homepagetopbar.dart';
import '../../components/tabs.dart';
import 'open_post_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final RegistrationController controller = Get.put(RegistrationController());
  final Stories_Controller storiesController = Get.put(Stories_Controller());
  final Post_Controller postController = Get.put(Post_Controller());
  final ImagePickerController imageController =
      Get.put(ImagePickerController());
  List<UserModel> userData = [];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    RxList data = await postController.getUserData();
    setState(() {
      userData = data as List<UserModel>;
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
              const HomePageTopBar(),
              if (userData.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          //userData.first.profileImagePath??
                          userData.last.profileImagePath ??
                              'https://via.placeholder.com/150',
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("${userData.length}"),
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
                    Text(userData.isNotEmpty ? userData[0].userName ?? '' : ''),
                    Text(userData.isNotEmpty ? userData[0].bio ?? '' : ''),
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
                          print(
                              "user id is : ${postController.getCurrentUserID()}");
                          Get.to(EditProfile(
                            bio: userData[0].userName,
                            username: userData[0].userName,
                            docId: postController.getCurrentUserID(),
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
                                child: FutureBuilder<RxList<UserModel>>(
                                  future: postController.getUserData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(
                                          child:
                                              Text('Error: ${snapshot.error}'));
                                    } else if (snapshot.hasData) {
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
                                                post.profileImagePath ??
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
