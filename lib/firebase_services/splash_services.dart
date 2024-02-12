import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/auth/home_screen.dart';
import 'package:task_manager/ui/auth/login_screen.dart';


class SplashServices{
  void isLogin(BuildContext context){
    final auth= FirebaseAuth.instance;
    final user= auth.currentUser;
    if(user != null){
      Timer(const Duration(seconds: 3), () =>{
        // Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImageScreen())),
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
        // Navigator.push(context, MaterialPageRoute(builder: (context) => FireStoreMark())),
      });
    }
    else
    {
      Timer(const Duration(seconds: 3), () =>{
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())),
      });
    }
  }
}