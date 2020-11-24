import 'package:flutter/material.dart';

import 'views/home_view.dart';

void main() {
  runApp(MaterialApp(routes: <String, WidgetBuilder>{
    '/': (context) => HomeView(),
  }));
}
