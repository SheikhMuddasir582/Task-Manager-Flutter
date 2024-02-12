import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_manager/firebase_services/splash_services.dart';
import 'package:task_manager/ui/auth/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen= SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Timer(const Duration(seconds: 3), () =>Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),);
    //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    splashScreen.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
            'Task Manager',
            style: TextStyle(fontSize: 30),
          )),
    );
  }
}