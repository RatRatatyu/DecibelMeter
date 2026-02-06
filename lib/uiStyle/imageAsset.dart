import 'package:flutter/material.dart';
import 'package:sound_metter/uiStyle/style.dart';


class ImageAssets extends StatelessWidget{
  const ImageAssets({super.key, required this.image, required this.x});
  final String image;
  final double x;

  @override
  Widget build(BuildContext context){


    return Image.asset(image, width: uiSize(context, x),  fit: BoxFit.contain,);
  }
}