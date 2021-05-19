import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

Widget skeletonText(double width, double height) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: SkeletonAnimation(
        borderRadius: BorderRadius.circular(5.0),
        shimmerColor: Colors.grey,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0), color: Colors.grey[300]),
        )),
  );
}