import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_app/app/controller/auth/signup_controller.dart';
import 'package:instagram_app/screen/auth/textfield_class.dart';

class MyRegister extends StatelessWidget {
  MyRegister({super.key});
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final _registerController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: Get.height,
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/instagram_logo.png",
                        height: 180,
                      ),
                    ],
                  ),
                  GetBuilder<SignUpController>(builder: (_) {
                    if (_registerController.profileImage == null) {
                      return Stack(
                        children: [
                          const CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.pinkAccent,
                            child: Icon(
                              Icons.safety_divider,
                              size: 45,
                            ),
                          ),
                          Positioned(
                            bottom: 1,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.purple,
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt),
                                onPressed: () {
                                  _registerController.pickImage();
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Stack(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundImage: _registerController.profileImage !=
                                  null
                              ? FileImage(_registerController.profileImage!)
                              : null, // Check if profileImage is not null before using it
                        ),
                        Positioned(
                          bottom: 1,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.pinkAccent,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt),
                              onPressed: () {
                                _registerController.pickImage();
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  BorderInput(
                    hintText: 'Email or Username',
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    contoller: emailController,
                    obsecurity: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Doesn't match to email";
                      }
                      if (!GetUtils.isEmail(value)) {
                        return "Email is not valid";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BorderInput(
                    contoller: passwordController,
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.key, color: Colors.black),
                    suffixIcon:
                        const Icon(Icons.remove_red_eye, color: Colors.black),
                    obsecurity: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Doesn't match to email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BorderInput(
                    contoller: nameController,
                    hintText: 'Name',
                    prefixIcon: const Icon(Icons.person_2, color: Colors.black),
                    obsecurity: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name is needed";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 60,
                    width: 370,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          String email = emailController.text;
                          String password = passwordController.text;
                          String name = nameController.text;
                          _registerController.register(
                              email: email, password: password, name: name);
                        }
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "I already have an account.",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Text(
                        "Need to sign in?",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
