import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/bottom_sheets/menu_bottom_sheet.dart';
import 'package:uremit/app/widgets/customs/bottom_nav_bar_icons_icons.dart';
import 'package:uremit/features/home/presentation/manager/home_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';
import 'package:uremit/utils/router/uremit_router_delegate.dart';

PersistentBottomSheetController? globalBottomSheetController;

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  void initState() {
    context.read<HomeViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    context.read<HomeViewModel>().getProfileHeader();
    Timer(const Duration(milliseconds: 300), () {
      context.read<HomeViewModel>().onBottomNavTap(0);
    });
    super.initState();
  }

  final iconList = <IconData>[
    BottomNavBarIcons.dashboard,
    BottomNavBarIcons.receivers,
    BottomNavBarIcons.card,
    BottomNavBarIcons.menu,
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: PageView(
        children: context.read<HomeViewModel>().pages,
        physics: const NeverScrollableScrollPhysics(),
        controller: context.read<HomeViewModel>().pageController,
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: ValueListenableBuilder<bool>(
          valueListenable: context.read<HomeViewModel>().fabClicked,
          builder: (_, value, __) {
            return FloatingActionButton(
              onPressed: context.read<HomeViewModel>().onFabTap,
              child: Icon(BottomNavBarIcons.payment, color: value ? Theme.of(context).primaryColor : Colors.grey, size: 34.w),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: context.read<HomeViewModel>().pageIndex,
        builder: (_, index, __) {
          return AnimatedBottomNavigationBar(
            icons: iconList,
            activeIndex: index,
            height: 64.h,
            elevation: 15,
            gapLocation: GapLocation.center,
            gapWidth: 64.w,
            notchSmoothness: NotchSmoothness.softEdge,
            leftCornerRadius: 25.r,
            rightCornerRadius: 25.r,
            iconSize: 26.w,
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Colors.grey,
            onTap: (index) {

              if (index == 3) {
                MenuBottomSheet _bottomSheet = MenuBottomSheet(context);
                globalHomeContext = context;
                _bottomSheet.show();
                return;
              }
              context.read<HomeViewModel>().onBottomNavTap(index);
            },
          );
        },
      ),
    );
  }
}
