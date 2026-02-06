import 'package:flutter/material.dart';

double textSize(BuildContext context, double factor) {
  final media = MediaQuery.of(context);
  return media.textScaler.scale(media.size.width * factor);
}

double uiSize(BuildContext context, double factor){
  return MediaQuery.sizeOf(context).width * factor;
}
