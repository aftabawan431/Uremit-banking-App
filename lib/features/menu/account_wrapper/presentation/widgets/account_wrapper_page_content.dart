import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/custom_app_bar.dart';
import 'package:uremit/app/widgets/customs/tabview/custom_tab_view.dart';
import 'package:uremit/features/menu/account_wrapper/presentation/manager/account_wrapper_view_model.dart';
import 'package:uremit/features/menu/account_wrapper/presentation/widgets/profile_header.dart';
import 'package:uremit/features/menu/profile/presentation/pages/profile_page.dart';
import 'package:uremit/features/menu/security/presentation/pages/security_page.dart';
import 'package:uremit/features/menu/update_profile/presentation/pages/update_profile_page.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../app/globals.dart';
import '../../../../home/presentation/manager/home_view_model.dart';
import '../../../documents/presentation/pages/documents_page.dart';

int? changeIndex;

class AccountWrapperPageContent extends StatefulWidget {
  const AccountWrapperPageContent({Key? key}) : super(key: key);

  @override
  _AccountWrapperPageContentState createState() => _AccountWrapperPageContentState();
}

class _AccountWrapperPageContentState extends State<AccountWrapperPageContent> {
  int index = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    index = 0;
  }

  @override
  void initState() {
    // if (changeIndex != null) {
    //   index = changeIndex!;
    //   changeIndex = null;
    //
    // }

    context.read<AccountWrapperViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    super.initState();
  }

  HomeViewModel get _homeViewModel => sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(title: 'My Profile'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChangeNotifierProvider.value(value: _homeViewModel, child: const ProfileHeader()),
          SizedBox(height: 10.h),
          CustomTabView(
            key: context.read<AccountWrapperViewModel>().bottomNavigationKey,
            index: index,
            height: 50.0,
            pages: const [
              ProfilePage(),
              UpdateProfilePage(),
              SecurityPage(),
              DocumentsPage(),
            ],
            titles: const ['Profile', 'Update Profile', 'Security', 'Document Required'],
            color: Colors.white,
            buttonBackgroundColor: Theme.of(context).indicatorColor,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            letIndexChange: (index) => true,
          )
        ],
      ),
    );
  }
}
