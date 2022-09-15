import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/main.dart';
import 'constants.dart';

// Smooth_Page_Indicator Package
Widget DefaultSmoothIndicator({
  required PageController controller,
  required int length,
  Color activeColor = mainColor,
  required double size,
  required double radius,
  double spacing = 10
}){
  return SmoothPageIndicator(
    controller: controller,
    count: length,
    axisDirection: Axis.horizontal,
    effect: SlideEffect(
        spacing: 10,
        radius: radius,
        dotWidth: size,
        dotHeight: size,
        paintStyle:  PaintingStyle.stroke,
        strokeWidth:  1.5,
        dotColor:  Colors.grey,
        activeDotColor: activeColor
    ),
  );
}

void showSnackBar({required String message,required BuildContext context,required Color color}){
  var snackBar = SnackBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    content: Text(message,textAlign: TextAlign.center,),
    clipBehavior: Clip.hardEdge,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 70,vertical: 15),
    padding: const EdgeInsets.all(10),
    backgroundColor: color,
    duration: const Duration(seconds: 1),);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}