import 'package:crickz/main.dart';
import 'package:crickz/scorecard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final battingteam = TextEditingController();
  final bowlingteam = TextEditingController();
  final overs = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(10.h),
        height: double.infinity.h,
        width: double.infinity.w,
        decoration:  BoxDecoration(color: Colors.white10,
            image: DecorationImage(image: AssetImage(backroundImg),fit: BoxFit.cover),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 120.h,
            ),
            Container(
              padding: EdgeInsets.all(15.h),
              height: 300.h,
              decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 40.h,width: 65.w,
                        child: TextField(
                          cursorWidth: 0.w,
                          textAlign: TextAlign.center,
                          style:const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                          keyboardType: TextInputType.number,
                          controller: overs,
                          decoration: InputDecoration(
                              hintText: "Overs",
                              hintStyle: const TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.w500),
                              filled: true,
                              fillColor: Colors.white70,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(13)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(13)),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade300,
                              fixedSize: Size(40.h, 40.h),
                              shape: const CircleBorder()),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: Scorecard(
                                        overs: overs.text.toString(),
                                        bowlingteam: bowlingteam.text.toString(),
                                        battingteam: battingteam.text.toString()),
                                    type: PageTransitionType.rightToLeft));
                          },
                          child: const Icon(Icons.arrow_forward_ios_rounded))
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  SizedBox(
                    height: 40.h,width: 220.w,
                    child: TextField(
                      cursorWidth: 0.w,
                      textAlign: TextAlign.center,
                      style:const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                      cursorColor: Colors.black,
                      controller: battingteam,
                      decoration: InputDecoration(
                          hintText: "Batters",
                          hintStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  Image.asset(
                    vsImg,
                    height: 80.h,
                  ),
                  SizedBox(
                    height: 40.h,width: 220.w,
                    child: TextField(
                      cursorWidth: 0.w,
                      textAlign: TextAlign.center,
                      style:const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                      controller: bowlingteam,
                      decoration: InputDecoration(
                          hintText: "Bowlers",
                          hintStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

// showDialog(context: context, builder: (context) {
// return  AlertDialog(
// title:Column(
// children: [
// const Text("How many overs you want to playy?"),
// SizedBox(
// height: 33.h,width: 70.w,
// child: TextField(
// cursorColor: Colors.white,
// autofocus: true,
// controller: overs,
// decoration: InputDecoration(
// labelText: "Overs",
// labelStyle: const TextStyle(
// color: Colors.black, fontWeight: FontWeight.w500),
// filled: true,
// fillColor: Colors.white70,
// enabledBorder: OutlineInputBorder(
// borderSide: const BorderSide(color: Colors.black),
// borderRadius: BorderRadius.circular(13)),
// disabledBorder: OutlineInputBorder(
// borderSide: const BorderSide(color: Colors.black),
// borderRadius: BorderRadius.circular(13)),
// border: OutlineInputBorder(
// borderSide: const BorderSide(color: Colors.black),
// borderRadius: BorderRadius.circular(10))),
// ),
// ),
// ],
// ),
// actions: [
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.red.shade300,
// fixedSize: Size(40.h, 40.h),
// shape: const CircleBorder()),
// onPressed: () {
//
// },
// child: const Icon(Icons.arrow_forward_ios_rounded))
// ],
// );
// },);
