import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:uber_shop_app/views/screens/auth/login_screen.dart';
import 'package:uber_shop_app/views/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Platform.isAndroid ? await Firebase.initializeApp(
  //   options: FirebaseOptions(
  //   apiKey: "AIzaSyDJOGoNtiaGFMUekjJKOpiUb2dcaiUUMuE",
  //   appId: "1:677592659654:android:41bd30a3e56326cddc09c7",
  //   messagingSenderId: "677592659654",
  //   projectId: "store-9321c",
  //   storageBucket: "gs://store-9321c.appspot.com",
  // ),
  // )
  //   : await Firebase.initializeApp();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}


