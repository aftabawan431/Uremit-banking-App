import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants/app_level/app_theme.dart';
import '../utils/globals/app_globals.dart';
import '../utils/router/uremit_back_button_dispatcher.dart';

import '../utils/router/uremit_router_delegate.dart';
import '../utils/router/uremit_router_parser.dart';
import 'globals.dart';

bool isSessionExpired = false;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late UremitRouterDelegate delegate;
  late UremitBackButtonDispatcher backButtonDispatcher;
  late UremitRouterParser parser = UremitRouterParser();

  @override
  void initState() {
    delegate = UremitRouterDelegate(sl());
    backButtonDispatcher = UremitBackButtonDispatcher(sl());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (c, wi) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Listener(
          onPointerDown: (_) {
            sessionSeconds = defaultSessionSec;
          }, // best place to reset timer imo
          onPointerMove: null,
          onPointerUp: null,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Uremit',
            theme: AppTheme.appTheme,
            routerDelegate: delegate,
            backButtonDispatcher: backButtonDispatcher,
            routeInformationParser: parser,
          ),
        ),
      ),
    );
  }
}
