import 'package:crickz/homepage.dart';
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
            decoration: const BoxDecoration(
              color: Colors.white70
            ),
            child: widget.won.toString().isEmpty?
            Column(
              mainAxisAlignment: MainAxisAlignment.center,children: [
              Text("MATCH TIED", style: TextStyle(fontFamily: "regular",
                  fontSize: 25.sp,letterSpacing: 2.w,
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
              SizedBox(height: 80.h,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage()));
                  }, child: Text("NEXT MATCH", style: TextStyle(fontFamily: "regular",
                  fontSize: 16.sp,
                  color: Colors.white,letterSpacing: 5.w,
                  fontWeight: FontWeight.w500)))
            ]
            ) :
            Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text(widget.won, style: TextStyle(fontFamily: "regular",
                  fontSize: 27.sp,
                  color: Colors.black,
                  letterSpacing: 5.w,
                  fontWeight: FontWeight.w500),),
              SizedBox(height:10.h),
              Text("BEATS", style: TextStyle(fontFamily: "regular",
                  fontSize: 15.sp,letterSpacing: 2.w,
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
                SizedBox(height:10.h),
              Text(widget.lose, style: TextStyle(fontFamily: "regular",
                  fontSize: 27.sp,letterSpacing: 5.w,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),),
                SizedBox(height:10.h),
                Text("BY", style: TextStyle(fontFamily: "regular",
                    fontSize: 15.sp,letterSpacing: 5.w,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
                SizedBox(height:10.h),
                Text(widget.by.toString(), style: TextStyle(fontFamily: "regular",
                    fontSize: 20.sp,
                    color: Colors.black,letterSpacing: 5.w,
                    fontWeight: FontWeight.w500)),
                SizedBox(height: 80.h,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage()));
                }, child: Text("NEXT MATCH", style: TextStyle(fontFamily: "regular",
                    fontSize: 16.sp,
                    color: Colors.white,letterSpacing: 5.w,
                    fontWeight: FontWeight.w500)))
            ],),
          ),
        ),
      ),
    );
  }
}
