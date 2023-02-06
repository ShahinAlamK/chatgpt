import 'package:flutter/material.dart';

class SizeConfig{
  static MediaQueryData ? _mediaQueryData;
  static double ? height;
  static double ? width;
  static double ? blockHorizontal;
  static double ? blockVartical;
  init(BuildContext context){
    _mediaQueryData=MediaQuery.of(context);
    height =_mediaQueryData!.size.height;
    width =_mediaQueryData!.size.width;
    blockHorizontal = width!/100;
    blockVartical = height!/100;
  }
  }