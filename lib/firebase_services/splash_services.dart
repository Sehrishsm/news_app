




import 'package:new_app/ui/auth/login_screen.dart';
import 'package:new_app/ui/firestore/firestore_list_screen.dart';
import 'package:new_app/ui/post/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:new_app/ui/upload%20image.dart';


class SplashServices{

  void IsLogin(BuildContext context){

    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if(user != null){
      Timer(Duration(seconds: 3),
              ()=>Navigator.push(context, MaterialPageRoute(builder: (context) =>PostScreen()))
      );
    }else{
      Timer(Duration(seconds: 3),
              ()=>Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginScreen()))
      );

    }


  }
}