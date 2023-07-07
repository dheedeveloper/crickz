import 'dart:async';
import 'package:crickz/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) =>  const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const Homepage(),
              type: PageTransitionType.rightToLeft));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Container(
      height: double.infinity.h,
      width: double.infinity.w,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(backroundImg),fit:BoxFit.cover )
      ),
    ),));
  }
}

////........................Asset images...........................

String vsImg ="assets/images/vsImg.png";
String scorebgImg ="assets/images/scorebgimg.png";
String scorebgImage ="assets/images/scorebgimage.png";
String backroundImg ="assets/images/cric.png";
