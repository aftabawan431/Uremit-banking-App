import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/bottom_sheets/widgets/profile_avatar.dart';
import 'package:uremit/features/home/presentation/manager/home_view_model.dart';
import 'package:uremit/utils/constants/app_level/app_assets.dart';
import 'package:uremit/utils/router/app_state.dart';
import 'package:uremit/utils/router/models/page_action.dart';
import 'package:uremit/utils/router/models/page_config.dart';
import 'package:uremit/utils/router/uremit_router_delegate.dart';

import '../../../features/authentication/login/presentation/manager/login_view_model.dart';
import '../../../utils/constants/enums/page_state_enum.dart';
import '../../../utils/globals/app_globals.dart';
import '../../globals.dart';

final HomeViewModel _viewModel = sl();

class MenuBottomSheet {
  final BuildContext context;

  MenuBottomSheet(this.context);

  Future show() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.r), topRight: Radius.circular(50.r)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50.r), topRight: Radius.circular(50.r)),
            ),
            padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 22.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: context.read<HomeViewModel>().isLoadingNotifier,
                  builder: (_, value, __) {
                    if (value) {
                      return const Text('Loading...');
                    } else {
                      if (context.read<HomeViewModel>().profileHeader == null) {
                        return const Text('Something went wrong');
                      }
                      return Row(
                        children: [
                          ChangeNotifierProvider.value(value: _viewModel, child: const ProfileAvatar()),
                          SizedBox(width: 22.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(context.read<HomeViewModel>().profileHeader!.profileHeaderBody.first.fullName,
                                    style: Theme.of(context).textTheme.subtitle1, maxLines: 1, overflow: TextOverflow.ellipsis),
                                SizedBox(height: 5.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(AppAssets.icVerifiedSvg),
                                    SizedBox(width: 8.w),
                                    Text('Verified', style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.green), maxLines: 1, overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                _detailItem(context: context, title: 'Full Name', details: context.read<HomeViewModel>().profileHeader!.profileHeaderBody.first.fullName),
                                SizedBox(height: 2.h),
                                _detailItem(context: context, title: 'Email', details: context.read<HomeViewModel>().profileHeader!.profileHeaderBody.first.email),
                                SizedBox(height: 2.h),
                                _detailItem(context: context, title: 'Phone Number', details: context.read<HomeViewModel>().profileHeader!.profileHeaderBody.first.phoneNo),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: 22.h),
                const Divider(),
                SizedBox(height: 22.h),
                SizedBox(
                  height: 430.h,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      _menuItem(
                        context: context,
                        title: 'My Account',
                        leading: AppAssets.icAccountSvg,
                        onTap: () {
                          globalHomeContext = null;
                          AppState appState = sl();
                          appState.currentAction = PageAction(state: PageState.addPage, page: PageConfigs.accountWrapperPageConfig);
                          // Timer(const Duration(milliseconds: 400),(){
                          //   globalHomeContext=context;
                          // });
                        },
                      ),
                      _menuItem(context: context, title: 'Invite Friends', leading: AppAssets.icInviteSvg),
                      _menuItem(context: context, title: 'Track Your Transaction', leading: AppAssets.icTrackSvg),
                      _menuItem(context: context, title: 'Privacy Policy', leading: AppAssets.icPrivacyPolicySvg),
                      _menuItem(context: context, title: 'Contact Us', leading: AppAssets.icContactSvg),
                      _menuItem(context: context, title: 'Terms & Conditions', leading: AppAssets.icDocumentSvg),
                      // _menuItem(context: context, title: 'Document Required', leading: AppAssets.icDocumentSvg),
                      _menuItem(
                        context: context,
                        title: 'Logout',
                        leading: AppAssets.icLogoutSvg,
                        onTap: () async {
                          await _showMyDialog();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      globalHomeContext = null;

    });
  }

  Widget _menuItem({required BuildContext context, required String title, required String leading, Function()? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(leading),
      title: Text(title, style: Theme.of(context).textTheme.bodyText1),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _detailItem({required BuildContext context, required String title, required String details}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
        SizedBox(width: 5.w),
        Expanded(child: Text(details, style: Theme.of(context).textTheme.caption, maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.end)),
      ],
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: SvgPicture.asset(AppAssets.uremitSvg),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    'Would you like to Logout?',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Yes'),
                onPressed: () async {
                  print('Confirmed');
                  AppState appState = sl();
                  LoginViewModel loginViewModal = sl();
                  await loginViewModal.logOut();
                  sessionTimer!.cancel();
                  appState.currentAction = PageAction(state: PageState.replaceAll, page: PageConfigs.authWrapperPageConfig);
                  // onErrorMessage?.call(OnErrorMessageModel(message: 'OTP sent!', backgroundColor: Colors.grey));

                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  print('Cancel');
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
