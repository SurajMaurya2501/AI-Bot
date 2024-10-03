import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_gemini_ai/controller/login_controller.dart';
import 'package:firebase_gemini_ai/controller/sign_up_controller.dart';
import 'package:firebase_gemini_ai/view/signup.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final loginController = LoginController();
  final signUpController = SignUpController();
  bool isLoading = true;
  late AnimationController _controller;
  late Animation<double> animation;
  late Animation<Color?> _colorAnimation;

  int counter = 0;
  String text = "Let's Create";

  List<String> slogans = [
    'Let\'s Create',
    'Let\'s Brainstorm',
    'Let\'s Collaborate',
    'ChatGem',
    'Let\'s Build',
    'Let\'s Inspire',
    'Let\'s Discover',
    'ChatGem',
    'Let\'s Dive in',
    'Let\'s Achieve',
    'Let\'s Transform',
    'ChatGem',
  ];

  @override
  void initState() {
    customAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  int currentLength = animation.value.toInt();
                  String visibleText = text.substring(0, currentLength);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        visibleText,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      AnimatedBuilder(
                        animation: _colorAnimation,
                        builder: (context, child) {
                          return CircleAvatar(
                            radius: 15,
                            backgroundColor: _colorAnimation.value,
                          );
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
            height: 230,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 56, 56, 56),
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(
                  30.0,
                ),
                topEnd: Radius.circular(
                  30.0,
                ),
              ),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    loginController.signInWithGoogle(context).whenComplete(
                      () {
                        setState(() {
                          isLoading = false;
                        });
                      },
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/google.png",
                          height: 25,
                          width: 25,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text(
                          "Continue with Google",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpAndLoginScreen(
                          isLoginPage: false,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 79, 79, 79),
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Sign up with email",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpAndLoginScreen(
                          isLoginPage: true,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 79, 79, 79),
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void customAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    animation = Tween<double>(begin: 0, end: text.length.toDouble()).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _colorAnimation =
        ColorTween(begin: Colors.yellowAccent, end: Colors.blue).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          Timer(
            const Duration(seconds: 1),
            () {
              _controller.reverse();
            },
          );
        } else if (status == AnimationStatus.dismissed) {
          if (counter != slogans.length - 1) {
            counter++;
            text = slogans[counter];
            animation =
                Tween<double>(begin: 0, end: text.length.toDouble()).animate(
              CurvedAnimation(
                parent: _controller,
                curve: Curves.linear,
              ),
            );
          } else {
            counter = 0;
            text = slogans[counter];
            animation = Tween<double>(begin: 0, end: text.length.toDouble())
                .animate(CurvedAnimation(
              parent: _controller,
              curve: Curves.linear,
            ));
          }
          _controller.forward();
        }
      },
    );
  }
}
