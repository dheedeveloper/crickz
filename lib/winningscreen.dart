import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'main.dart';

class WinningScreen extends StatefulWidget {
  final won;
  final lose;
  final by;
  const WinningScreen({Key? key, this.won, this.lose, this.by}) : super(key: key);

  @override
  State<WinningScreen> createState() => _WinningScreenState();
}

class _WinningScreenState extends State<WinningScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity.h,
          width: double.infinity.w,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(backroundImg),fit: BoxFit.cover)
          ),
          child: Container(
            height: double.infinity.h,
            width: double.infinity.w,
            decoration: BoxDecoration(
              color: Colors.white70
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(widget.won, style: TextStyle(fontFamily: "regular",
                  fontSize: 27.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),),
              SizedBox(height:10.h),
              Text("Beats", style: TextStyle(fontFamily: "regular",
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w700)),
                SizedBox(height:10.h),
              Text(widget.lose, style: TextStyle(fontFamily: "regular",
                  fontSize: 27.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),),
                SizedBox(height:10.h),
                Text("By", style: TextStyle(fontFamily: "regular",
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w700)),
                SizedBox(height:10.h),
                Text(widget.by.toString(), style: TextStyle(fontFamily: "regular",
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w700)),
            ],),
          ),
        ),
      ),
    );
  }
}
