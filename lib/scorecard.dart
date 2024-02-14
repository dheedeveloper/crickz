import 'dart:async';
import 'dart:io';
import 'package:crickz/targetscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'main.dart';

class Scorecard extends StatefulWidget {
  final battingteam;
  final bowlingteam;
  final overs;

  const Scorecard({Key? key, this.battingteam, this.bowlingteam, this.overs})
      : super(key: key);

  @override
  State<Scorecard> createState() => _ScorecardState();
}

class _ScorecardState extends State<Scorecard> {

  String fixedover="";
  int runs=0;

  @override
  void initState() {
    fixedover=widget.overs;
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
  List score = [];
  List wicket = [];
  inningsEnd(){
    if(fixedover==overcount.length.toString()){
     Timer(const Duration(milliseconds:300), () {
       Navigator.push(context,
           PageTransition(
               child: TargetScreen(
                 overs: fixedover,
                 bat: widget.bowlingteam,
                 bowl: widget.battingteam,
                 target: runs+1,),
               type: PageTransitionType.rightToLeft));
     });
    }
  }
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
  int totalsummary() {
    var sum = 0;
    for (int count in score) {
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


  @override
  Widget build(BuildContext context) {
    runs = totalsummary() + extras.length;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: () {
          return popUp();
        },
        child: Container(
          height: double.infinity.h,
          width: double.infinity.w,
          decoration: BoxDecoration(
            color: Colors.white70,
            image: DecorationImage(
                image: AssetImage(backroundImg), fit: BoxFit.cover),
          ),
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
                      Row(crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${widget.battingteam}",
                            style: TextStyle(fontFamily: "regular",
                                fontSize: 23.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            "$runs /",
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
                            "${widget.bowlingteam}",
                            style: TextStyle(fontFamily: "regular",
                                fontSize: 23.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            "${overcount.length}.${ballcount()} / ${widget.overs}",
                            style: TextStyle(fontFamily: "regular",
                                fontSize: 22.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "  ov",
                            style: TextStyle(fontFamily: "regular",
                                fontSize: 15.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      // Text(
                      //   "Extras: ${extras.length}",
                      //   style: TextStyle(fontFamily: "regular",
                      //       fontSize: 20.sp,
                      //       color: Colors.black,
                      //       fontWeight: FontWeight.w500),
                      // ),
                    ],
                  )),
              Container(
                height: 450.h,
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
                          itemCount:  thisover.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(),
                                  color: thisover[index] == "W"
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
                      height: 20.h,
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
                                  score.add(summary[index]);
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
                                    score.add(0);
                                    thisover.add("W");
                                  }
                                  if (summary[index] == "W+1") {
                                    wicket.add(1);
                                    score.add(1);
                                    thisover.add("W+1");
                                  }
                                  if (summary[index] == "W+2") {
                                    wicket.add(1);
                                    score.add(2);
                                    thisover.add("W+2");
                                  }
                                });
                                inningsEnd();
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
                       thisover.isEmpty ? const SizedBox() : InkWell(
                          onTap: () {
                            setState(() {
                              ballscount.isNotEmpty
                                  ? ballscount.removeLast()
                                  : snackBar();
                              score.isNotEmpty
                                  ? score.removeLast()
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
                      ],
                    )
                  ],),
                ),
              ),
            ]),

        ),
      ),
    )
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
              style: TextStyle(fontFamily: "regular",
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)))));
  }
}
