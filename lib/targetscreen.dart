import 'dart:async';
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
  var runs;
  var fixedovrs;

  @override
  void initState() {
    fixedovrs = widget.overs.toString();
    super.initState();
  }

  List overcount = [];
  List extras = [];
  List summary = [
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
  List ballscount = [];
  List thisover = [];
  List target = [];
  List wicket = [];

  popUp() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            'You want to exit?',
            style: TextStyle(fontFamily: "regular",
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
                  style: TextStyle(fontFamily: "regular",
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
                  style: TextStyle(fontFamily: "regular",
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
    for (int count in ballscount) {
      sum += count;
    }
    return sum;
  }
  String total ="";
  won(){
    if(totaltargetsummary() == widget.target || totaltargetsummary() > widget.target){
      print("Chasing Win");
       Navigator.push(context,
           PageTransition(
               child:  WinningScreen(
                 won: widget.bat,
                 lose: widget.bowl,
                 by:wicket.isEmpty? "10 wickets": "${10 - wicket.length} wickets",
               ),
               type: PageTransitionType.bottomToTop));
    }
  }
  lose(){
    if(totaltargetsummary()==widget.target-1){
      Timer(const Duration( milliseconds:300), () {
        Navigator.push(context,
            PageTransition(
                child:  const WinningScreen(
                   won: "",
                ),
                type: PageTransitionType.bottomToTop));
      });
    }
    else if(fixedovrs == overcount.length.toString() && totaltargetsummary() < widget.target){
        Timer(const Duration( milliseconds:300), () {
          Navigator.push(context,
              PageTransition(
                  child:  WinningScreen(
                      won: widget.bowl,
                      lose: widget.bat,
                      by: "${widget.target-totaltargetsummary()} runs"
                  ),
                  type: PageTransitionType.bottomToTop));
        });
    }
    else if(wicket.length ==9){
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
    print("${totaltargetsummary()} >= ${widget.target}");
    print("Wicket${wicket.length}==${10}");
    print("Overs${overcount.length}==${widget.overs}");
    if (ballcount() == 6) {
      ballscount.clear();
      overcount.add(1);
    }
    runs=totaltargetsummary() + extras.length;
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
                            style: TextStyle(fontFamily: "regular",
                                fontSize: 23.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            "${totaltargetsummary()} /",
                            style: TextStyle(fontFamily: "regular",
                                fontSize: 35.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${wicket.length.toString() ?? 0}",
                            style: TextStyle(fontFamily: "regular",
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
                            style: TextStyle(fontFamily: "regular",
                                fontSize: 23.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            "${overcount.length.toString()}.${ballcount()} / ${widget.overs.toString()}",
                            style: TextStyle(
                                fontFamily: "regular",
                                fontSize: 22.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "  ov",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: "regular",
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           const Spacer(),
                           Text(
                            "TARGET ~ ${widget.target}",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: "regular",
                                color: Colors.blue.shade600,
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
                      style: TextStyle(fontFamily: "regular",
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
                          itemCount: thisover.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(),
                                  color:thisover[index] == "W"
                                      ? Colors.red.shade300
                                      : Colors.white70),
                              child: Center(
                                child: Text(
                                  thisover[index].toString(),
                                  style: TextStyle(fontFamily: "regular",
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
                          itemCount: summary.length,
                          itemBuilder: (context, index) {
                            if(thisover.length==6){
                              thisover.clear();
                            }
                            return InkWell(
                              onTap: () {
                                ballscount.add(1);
                                if (index <= 5) {
                                  target.add(summary[index]);
                                  thisover.add(summary[index]);
                                }
                                else {
                                  null;
                                }
                                setState(() {
                                  if (ballcount() == 6) {
                                    ballscount.clear();
                                    overcount.add(1);
                                  }
                                  if (summary[index] == "W") {
                                    wicket.add(1);
                                    target.add(0);
                                    thisover.add("W");
                                  }
                                  if (summary[index] == "W+1") {
                                    wicket.add(1);
                                    target.add(1);
                                    thisover.add("W+1");
                                  }
                                  if (summary[index] == "W+2") {
                                    wicket.add(1);
                                    target.add(2);
                                    thisover.add("W+2");
                                  }
                                });
                                won();
                                lose();
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
                                      summary[index].toString(),
                                      style: TextStyle(fontFamily: "regular",
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
                        thisover.isEmpty || thisover.length==6 ? const SizedBox() :  InkWell(
                          onTap: () {
                            setState(() {
                              ballscount.isNotEmpty
                                  ? ballscount.removeLast()
                                  : snackBar();
                              target.isNotEmpty
                                  ? target.removeLast()
                                  : null;
                              thisover.last == "W" ? wicket.removeLast() : null;
                              thisover.last == "W+1" ? wicket.removeLast() : null;
                              thisover.last == "W+2" ? wicket.removeLast() : null;
                              print("last index > ${thisover.last}");
                              if (thisover.isNotEmpty &&
                                  thisover.last == "WD") {
                                thisover.removeLast();
                                extras.removeLast();
                              } else {
                                thisover.removeLast();
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
                                  style: TextStyle(fontFamily: "regular",
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
                        //           style: TextStyle(fontFamily: "regular",
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
        width: 250.w,
        content: SizedBox(
            height: 13.h,
            child: Center(
              child: Text(
                "Sorry, you can't edit previous overs",
                style: TextStyle(fontFamily: "regular",
                    fontSize: 10.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            )),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)))));
  }
}
