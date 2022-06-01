import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/globals.dart';
import 'package:uremit/app/widgets/customs/custom_app_bar.dart';
import 'package:uremit/features/payment/payment_details/presentation/manager/payment_details_view_model.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/manager/receipt_screen_view_model.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/widgets/summary_reciept_details.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';

import '../../../../../app/widgets/clippers/receipt_details_clipper.dart';
import '../../../../../utils/router/app_state.dart';

class SummaryDetailsScreenPageContent extends StatefulWidget {
  const SummaryDetailsScreenPageContent({Key? key}) : super(key: key);

  @override
  _SummaryDetailsScreenPageContentState createState() => _SummaryDetailsScreenPageContentState();
}

class _SummaryDetailsScreenPageContentState extends State<SummaryDetailsScreenPageContent> {
  @override
  // void initState() {
  //   context.read<ReceiptScreenViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
  //   context.read<ReceiptScreenViewModel>().getPaymentMethods();
  //   super.initState();
  // }
  PaymentDetailsViewModel paymentDetailsViewModel = sl();
  ReceiptScreenViewModel receiptScreenViewModel = sl();
  ReceiverViewModel receiverViewModel = sl();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer(Duration(seconds: 3),(){
    //   paymentDetailsViewModel.clearAllTextFields();
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Timer(const Duration(milliseconds: 500), () {
      paymentDetailsViewModel.clearAllTextFields();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: paymentDetailsViewModel),
        ChangeNotifierProvider.value(value: receiptScreenViewModel),
        ChangeNotifierProvider.value(value: receiverViewModel),
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(title: 'Summary'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipPath(
                  clipper: ReceiptDetailsClipper(),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.white,
                      // gradient: const LinearGradient(
                      //   begin: Alignment.topRight,
                      //   end: Alignment.bottomLeft,
                      //   colors: [
                      //     Color(0xFF404152),
                      //     Color(0xFF383A45),
                      //   ],
                      // ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        const SummaryReceiptDetails(),
                        // const UpdatePendingTransaction(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          height: 40.h,
                          width: 140.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Center(
                            child: Text(
                              'Download',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          height: 40.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Center(
                            child: Text(
                              'Share',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    GetIt.I.get<AppState>().moveToBackScreen();
                  },
                  child: Container(
                    height: 40.h,
                    width: 140.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Center(
                      child: Text(
                        'Next',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }
}
