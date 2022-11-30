import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

GlobalKey<NavigatorState> navigatorKeyGlobal = GlobalKey<NavigatorState>();
final sl = GetIt.instance;


const BoxDecoration backgroundGradient = BoxDecoration(
  gradient: RadialGradient(
    center: Alignment(0.5, -0.5),
    colors: [
      Color(0xFF261854),
      Color(0xFF000812),
    ],
    radius: 1,
  ),
);
