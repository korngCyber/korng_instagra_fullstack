import 'package:flutter/material.dart';
import '../../app/controller/auth/login_controller.dart';
import 'register_screen.dart';
import 'textfield_class.dart';
import 'package:get/get.dart';

class MyLoginScreen extends StatelessWidget {
  MyLoginScreen({Key? key}) : super(key: key);
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: 'korng@gmail.com');
  final passwordController = TextEditingController(text: '1111111111');
  final _loginController = Get.put(LoginController());

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
                        height: 200,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
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
                    hintText: 'Password',
                    prefixIcon: const Icon(
                      Icons.key,
                      color: Colors.black,
                    ),
                    contoller: passwordController,
                    obsecurity: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "invalid password";
                      }

                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Forget Password',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                          _loginController.login(
                            email: email,
                            password: password,
                          );
                        }
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "or you can sign in with",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/600px-Facebook_Logo_%282019%29.png",
                        ),
                      ),
                      SizedBox(width: 15),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          "https://blog.hubspot.com/hs-fs/hubfs/image8-2.jpg?width=600&name=image8-2.jpg",
                        ),
                      ),
                      SizedBox(width: 15),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          "https://sf-static.tiktokcdn.com/obj/eden-sg/uhtyvueh7nulogpoguhm/tiktok-icon2.png",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(MyRegister());
                        },
                        child: const Text(
                          "Sign Up",
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
