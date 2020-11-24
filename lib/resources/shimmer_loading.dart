import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[400],
    highlightColor: Colors.white,
    child: Text('Loading'),
  );
}
