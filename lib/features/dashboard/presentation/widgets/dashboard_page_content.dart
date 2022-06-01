import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/globals.dart';
import 'package:uremit/app/widgets/customs/custom_app_bar.dart';
import 'package:uremit/features/authentication/rates/presentation/manager/rates_view_model.dart';
import 'package:uremit/features/dashboard/presentation/manager/dashboard_view_model.dart';
import 'package:uremit/features/dashboard/presentation/widgets/banner_slider.dart';
import 'package:uremit/features/dashboard/presentation/widgets/loading/loading_banner.dart';
import 'package:uremit/features/dashboard/presentation/widgets/loading/loading_transaction_glance.dart';
import 'package:uremit/features/dashboard/presentation/widgets/loading/loading_transaction_item.dart';
import 'package:uremit/features/dashboard/presentation/widgets/transaction_glance.dart';
import 'package:uremit/features/dashboard/presentation/widgets/transaction_item.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../utils/router/app_state.dart';
import '../../../../utils/router/models/page_action.dart';
import '../../../../utils/router/models/page_config.dart';

class DashboardPageContent extends StatefulWidget {
  const DashboardPageContent({Key? key}) : super(key: key);

  @override
  _DashboardPageContentState createState() => _DashboardPageContentState();
}

class _DashboardPageContentState extends State<DashboardPageContent> {
  @override
  void initState() {
    context.read<DashboardViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    context.read<DashboardViewModel>().getPromotionList();
    context.read<DashboardViewModel>().getTransactionList();
    RatesViewModel ratesViewModel = sl();

    if (ratesViewModel.isButtonPressed == true) {
      // it is checking if user was on rates exchange screen then he logged in, if so then we must redirect him to the payment wrapper screen
      Timer(const Duration(seconds: 2), () {
        AppState appState = GetIt.I.get<AppState>();
        appState.currentAction = PageAction(state: PageState.addPage, page: PageConfigs.paymentWrapperPageConfig);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(title: 'Dashboard', showBackButton: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: context.read<DashboardViewModel>().isPromotionLoadingNotifier,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: value ? const LoadingBanner() : const BannerSlider(),
                  );
                },
              ),
              SizedBox(height: 22.h),
              Text('Transactions', style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white)),
              SizedBox(height: 22.h),
              ValueListenableBuilder<bool>(
                valueListenable: context.read<DashboardViewModel>().isTransactionListLoadingNotifier,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: value ? const LoadingTransactionGlance() : const TransactionGlance(),
                  );
                },
              ),
              SizedBox(height: 22.h),
              Row(
                children: [
                  Text('All Transactions', style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white)),
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 3,
                    child: CupertinoTextField(
                      suffix: Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Icon(CupertinoIcons.search, color: const Color(0xFF818492), size: 18.w),
                      ),
                      padding: EdgeInsets.only(left: 14.w, right: 4.w, top: 8.h, bottom: 8.h),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      onChanged: context.read<DashboardViewModel>().onSearchTransactionChange,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: const Color(0xFF818492)),
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      style: TextStyle(color: const Color(0xFF818492), fontSize: 12.sp),
                      placeholder: 'Search',
                      placeholderStyle: TextStyle(color: const Color(0xFF818492), fontSize: 12.sp),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  )
                ],
              ),
              // TextButton(
              //     onPressed: () {
              //       context.read<DashboardViewModel>().getTransactionList();
              //     },
              //     child: Text(
              //       'Get',
              //     )),
              SizedBox(height: 16.h),
              Flexible(
                fit: FlexFit.loose,
                child: ValueListenableBuilder<bool>(
                  valueListenable: context.read<DashboardViewModel>().isTransactionListLoadingNotifier,
                  builder: (_, value, __) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: value ? const LoadingTransactionItem() : TransactionItem(),
                      // Align(
                      //         alignment: Alignment.topLeft,
                      //         child: Text('No Recent Transactions Perform', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white70)),
                      //       ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
