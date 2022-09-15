import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'constants.dart';
// DefaultButtons
Widget DefaultTextButton({required Text text , required dynamic onTap}){
  return InkWell(
    onTap: onTap,
    child: text,
  );
}

Widget DefaultButton({required Widget title,required dynamic onTap,Color splashColor = mainColor,double? width,double? height,dynamic shape,Color color = mainColor}){
  return MaterialButton(
    onPressed: onTap,
    splashColor: splashColor,
    minWidth: width,
    height: height,
    shape: shape,
    color: color,
    elevation: 0,
    child: title,
  );
}

// Default TextFormField
Widget DefaultTextFormField({
  required TextEditingController controller,
  Text? label,
  TextInputType? keyboardType,
  int? maxLength,
  required dynamic validator,
  IconData? prefixIcon,
  IconData? suffixIcon,
  bool outlineInputBorderStatus = true,
  required TextInputType type,
  bool secureText = false,
  String? hint,
  dynamic suffixTap,
  dynamic initialValue,
}){
  return TextFormField(
    controller: controller,
    initialValue: initialValue,
    maxLength: maxLength,
    keyboardType: keyboardType,
    validator: validator,
    obscureText: secureText,
    decoration: InputDecoration(
      label: label,
      hintText: hint,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: InkWell(onTap: suffixTap,child: Icon(suffixIcon),),
      border: outlineInputBorderStatus ? const OutlineInputBorder() : null,
    ),
  );
}
