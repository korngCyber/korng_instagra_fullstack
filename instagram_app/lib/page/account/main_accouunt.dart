import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/app/controller/account/profile_controller.dart';

class MyMainAccount extends StatelessWidget {
  MyMainAccount({super.key});
  final _profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_profileController.user.email!),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline),
          ),
          IconButton(
            onPressed: () {
              _profileController.logOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: GetBuilder<ProfileController>(
        builder: (_) {
          return Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        // Add appropriate properties for the CircleAvatar
                        backgroundImage:
                            NetworkImage(_profileController.user.profileImage!),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          "${_profileController.user.name}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Add a SizedBox for spacing
                  const SizedBox(width: 16),
                  // Use ListTile properly with a subtitle or leading
                  const SizedBox(
                    height: 50,
                    width: 80,
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text("5"),
                      subtitle: Text(
                        "Posts",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                    width: 90,
                    child: ListTile(
                      title: Text("1k"),
                      subtitle: Text(
                        "Follows",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                    width: 99,
                    child: ListTile(
                      title: Text("10"),
                      subtitle: Text(
                        "Following",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 35,
                    width: 180,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Edit profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 180,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Edit profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
