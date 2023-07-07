import 'dart:io';

import 'package:crickz/winningscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

import 'main.dart';

class TargetScreen extends StatefulWidget {
  final bat;
  final bowl;
  final overs;
  final target;
  const TargetScreen({Key? key, this.bat, this.bowl, this.overs, this.target})
      : super(key: key);

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  var targetfixedover;
  var targetruns;

  @override
  void initState() {
    targetfixedover=widget.overs.toString();
    super.initState();
  }

  List targetovercount = [];
  List targetextras = [];
  List targetsummary = [
    0,
    1,
    2,
    3,
    4,
    6,
    "W",
    "W+1",
    "W+2",
  ];
  List targetballscount = [];
  List targetthisover = [];
  List target = [];
  List targetwicket = [];

  popUp() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            'You want to exit?',
            style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  exit(0);
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500),
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  "No",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500),
                ))
          ],
        );
      },
    );
  }
  int totaltargetsummary() {
    var sum = 0;
    for (int count in target) {
      sum += count;
    }
    return sum;
  }
  int ballcount() {
    int sum = 0;
    for (int count in targetballscount) {
      sum += count;
    }
    return sum;
  }
  int targetoverscount() {
    int sum = 0;
    for (int count in targetovercount) {
      sum += count;
    }
    return sum;
  }
  won(){
    if(totaltargetsummary()>=widget.target ||
        targetfixedover==targetoverscount().toString()){
      Navigator.push(context,
          PageTransition(
              child:  WinningScreen(
                won: widget.bat,
                lose: widget.bowl,
                by:targetwicket.isEmpty? "10 wickets": "${10 - targetwicket.length} wickets",
              ),
              type: PageTransitionType.bottomToTop));
    }
  }
  lose(){
    if( targetwicket.length==9 ||
        targetfixedover==targetoverscount().toString()){
      Navigator.push(context,
          PageTransition(
              child:  WinningScreen(
                won: widget.bowl,
                lose: widget.bat,
                by: "${widget.target-totaltargetsummary()} runs"
              ),
              type: PageTransitionType.bottomToTop));
    }
  }

  @override
  Widget build(BuildContext context) {
    print("$targetfixedover==${targetoverscount().toString()}");
    if (ballcount() == 6) {
      targetballscount.clear();
      targetovercount.add(1);
    }
    targetruns=totaltargetsummary() + targetextras.length;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
            onWillPop: () {
              return popUp();
            },
            child: Column(children: [
              Container(
                  padding: EdgeInsets.all(10.h),
                  height: 200.h,
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(scorebgImg),fit: BoxFit.fill),
                     ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${widget.bat}",
                            style: TextStyle(
                                fontSize: 23.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            "${totaltargetsummary() + targetextras.length} /",
                            style: TextStyle(
                                fontSize: 35.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${targetwicket.length.toString() ?? 0}",
                            style: TextStyle(
                                fontSize: 25.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "${widget.bowl}",
                            style: TextStyle(
                                fontSize: 23.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            "${targetoverscount()}.${ballcount()} / ${widget.overs}",
                            style: TextStyle(
                                fontSize: 22.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "  ov",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   "Extras: ${targetextras.length}",
                          //   style: TextStyle(
                          //       fontSize: 20.sp,
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.w500),
                          // ),
                           Spacer(),
                          Text(
                            "TARGET ~ ${widget.target}",
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          //SizedBox(width: 4.w,)
                        ],
                      ),
                    ],
                  )),
              Container(height:450.h,
                width: double.infinity.w,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  image: DecorationImage(
                      image: AssetImage(backroundImg), fit: BoxFit.cover),
                ),
                child: Container(
                  height: 250.h,
                  width: double.infinity.w,
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                  ),
                  child: Column(children: [
                    Text(
                      "THIS OVER",
                      style: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(5.h),
                      height: 48.h,
                      width: 340.w,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        gradient: LinearGradient(colors: [
                          Colors.white,
                          Colors.teal.shade500,
                          Colors.white
                        ]),
                      ),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: targetthisover.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(),
                                  color: targetthisover[index] == "W"
                                      ? Colors.red.shade300
                                      : Colors.white70),
                              child: Center(
                                child: Text(
                                  targetthisover[index].toString(),
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      height: 240.h,width: 300.w,
                      child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 120,
                              mainAxisExtent: 74,
                              childAspectRatio: 5 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                          itemCount: targetsummary.length,
                          itemBuilder: (context, index) {
                            targetthisover.length == 6 ? targetthisover.clear() : null;
                            return InkWell(
                              onTap: () {
                                if (index <= 5) {
                                  target.add(targetsummary[index]);
                                  targetthisover.add(targetsummary[index]);
                                  targetballscount.add(1);
                                } else {
                                  null;
                                }
                                setState(() {
                                  won();
                                  lose();
                                  if (ballcount() == 6) {
                                    targetballscount.clear();
                                    targetovercount.add(1);
                                  }
                                  if (targetsummary[index] == "W") {
                                    targetwicket.add(1);
                                    target.add(0);
                                    targetthisover.add("W");
                                    targetballscount.add(1);
                                  }
                                  if (targetsummary[index] == "W+1") {
                                    targetwicket.add(1);
                                    target.add(1);
                                    targetthisover.add("W+1");
                                    targetballscount.add(1);
                                  }
                                  if (targetsummary[index] == "W+2") {
                                    targetwicket.add(1);
                                    target.add(2);
                                    targetthisover.add("W+2");
                                    targetballscount.add(1);
                                  }
                                  print(targetthisover);
                                });
                              },
                              child: Container(
                                height: 48.h,
                                width: 48.w,
                                decoration: BoxDecoration(
                                    color: const Color(0xff3CC0D2),
                                    shape: BoxShape.circle,
                                    border: Border.all()),
                                child: Center(
                                    child: Text(
                                      targetsummary[index].toString(),
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              targetballscount.isNotEmpty
                                  ? targetballscount.removeLast()
                                  : snackBar();
                              target.isNotEmpty
                                  ? target.removeLast()
                                  : null;
                              targetthisover.last == "W" ? targetwicket.removeLast() : null;
                              targetthisover.last == "W+1" ? targetwicket.removeLast() : null;
                              targetthisover.last == "W+2" ? targetwicket.removeLast() : null;
                              print("last index > ${targetthisover.last}");
                              if (targetthisover.isNotEmpty &&
                                  targetthisover.last == "WD") {
                                targetthisover.removeLast();
                                targetextras.removeLast();
                              } else {
                                targetthisover.removeLast();
                              }
                            });
                          },
                          child: Container(
                            height: 70.h,
                            width: 70.h,
                            decoration: BoxDecoration(
                                color: const Color(0xff3CC0D2),
                                shape: BoxShape.circle,
                                border: Border.all()),
                            child: Center(
                                child: Text(
                                  "UNDO",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     setState(() {
                        //       // thisover.add("WD");
                        //       targetextras.add(1);
                        //       target.add(0);
                        //       targetballscount.add(0);
                        //     });
                        //   },
                        //   child: Container(
                        //     height: 70.h,
                        //     width: 70.h,
                        //     decoration: BoxDecoration(
                        //         color: const Color(0xff3CC0D2),
                        //         shape: BoxShape.circle,
                        //         border: Border.all()),
                        //     child: Center(
                        //         child: Text(
                        //           "WIDE",
                        //           style: TextStyle(
                        //               fontSize: 20.sp,
                        //               color: Colors.black,
                        //               fontWeight: FontWeight.w500),
                        //         )),
                        //   ),
                        // )
                      ],
                    )
                  ],),
                ),
              ),

            ]),
          ),
        ),
      );
  }

  snackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        width: 350.w,
        content: SizedBox(
            height: 26.h,
            child: Text(
              "Sorry, you can't edit previous overs",
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)))));
  }
}
