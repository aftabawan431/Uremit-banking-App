import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/features/receivers/presentation/widgets/loading_payment_header.dart';

import '../../../../app/globals.dart';
import '../../../../utils/constants/app_level/app_assets.dart';

class PaymentHeader extends StatelessWidget {
  PaymentHeader({Key? key,this.isDashboard=false}) : super(key: key);
  bool isDashboard;

  ReceiverViewModel get receiverViewModel => sl();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: receiverViewModel.isPaymentHeaderNotifier,
        builder: (_, value, __) {
          if (value) {
            return const LoadingPaymentHeader();
          } else {
            return Container(
              height: 100.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF99A0BA),
                    Color(0xFF515E8C),
                  ],
                ),
              ),
              margin: EdgeInsets.symmetric(horizontal:!isDashboard? 22.w:0.w),
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,                children: [
                  Text(
                    'Exchange Rate',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith( fontWeight: FontWeight.bold,  color: Colors.amber,),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: 5.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Send Amount',
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Total = ${receiverViewModel.paymentHeaderResponseModel!.paymentHeaderResponseModelBody.senderCountryUnitValue.isEmpty ? '0' : receiverViewModel.paymentHeaderResponseModel!.paymentHeaderResponseModelBody.senderCountryUnitValue}',
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              // Text(
                              //   'Total Fees = 180 AUD',
                              //   style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12),
                              // ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: SvgPicture.asset(
                            AppAssets.icArrowSvg,
                            height: 35.h,
                          ),
                        ),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Receiver Gets',
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Total = ${receiverViewModel.paymentHeaderResponseModel!.paymentHeaderResponseModelBody.birthCountryExchangeValue.isEmpty ? '0' : receiverViewModel.paymentHeaderResponseModel!.paymentHeaderResponseModelBody.birthCountryExchangeValue}',
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
