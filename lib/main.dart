import 'package:flutter/material.dart';
import 'package:flutter_apis/PostAPI/login.dart';
import 'package:flutter_apis/PostAPI/sign_up.dart';
import 'package:flutter_apis/PostAPI/upload_image.dart';
import 'package:flutter_apis/emaple_two.dart';
import 'package:flutter_apis/example_four.dart';
import 'package:flutter_apis/example_three.dart';
import 'package:flutter_apis/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      // home: HomeScreen(),
      // home: SignUpScreen(),
      home: UploadImage(),
    );
  }
}


