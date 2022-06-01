import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:uremit/utils/constants/app_level/app_assets.dart';

import '../../../../receivers/models/receiver_list_response_model.dart';
import '../../../../receivers/presentation/manager/receiver_view_model.dart';
import '../../../payment_details/presentation/manager/payment_details_view_model.dart';
import '../manager/receipt_screen_view_model.dart';

class SummaryReceiptDetails extends StatelessWidget {
  const SummaryReceiptDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          child: Column(
            children: [
              Text(
                'Transactions Pending'.toUpperCase(),
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Colors.black,
                  fontSize: 20.sp
                    ),
              ),
              SizedBox(height: 5.h),

              // Text(
              //   'dfuee25415112'.toUpperCase(),
              //   style: Theme.of(context).textTheme.subtitle2?.copyWith(
              //         color: Colors.black,
              //       ),
              // ),
              // SizedBox(height: 5.h),
              Text(
               DateFormat.yMEd().format(DateTime.now()),
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        _dottedLine(),
        SizedBox(height: 10.h),
        Text(
          'Your Transfer Details',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: Colors.black,
              ),
        ),
        SizedBox(height: 10.h),
        _dottedLine(),
        SimpleShadow(
          opacity: 0.2,
          color: Colors.black12,
          offset: const Offset(0, 0),
          sigma: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF7FCFF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
                child: Column(
              children: [
                _detailItem(
                    context,
                    'You Sent',
                    context
                        .read<PaymentDetailsViewModel>()
                        .sendMoneyController
                        .text +
                        ' AUD'),
                SizedBox(height: 5.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Fee Included',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                _bankDetailItem(context, 'Administrative',
                    '${context.read<ReceiptScreenViewModel>().adminFee} AUD'),
                if (context
                    .read<PaymentDetailsViewModel>()
                    .receiverPayoutPartner
                    .value !=
                    null)
                  SizedBox(height: 5.h),
                if (context
                    .read<PaymentDetailsViewModel>()
                    .receiverPayoutPartner
                    .value !=
                    null)
                  _bankDetailItem(context, 'Payout Partner',
                      '${context.read<PaymentDetailsViewModel>().receiverPayoutPartner.value!.fee} AUD'),
                SizedBox(height: 10.h),
                _bankDetailItem(context, 'Payment Gateway',
                    '${context.read<ReceiptScreenViewModel>().selectedPaymentMethod.value!.charges} AUD'),
                SizedBox(height: 15.h),

                _detailItem(context, 'Total Fees',
                    '${context.read<ReceiptScreenViewModel>().totalFee.value} AUD'),
                SizedBox(height: 15.h),
                ValueListenableBuilder<int>(
                  valueListenable: context.read<ReceiptScreenViewModel>().totalFee,
                  builder: (_,value,ch){
                    return _detailItem(context, 'Amount we\'ll convert',
                        '${int.parse(context.read<PaymentDetailsViewModel>().sendMoneyController.text) - value} AUD');
                  },

                ),
                SizedBox(height: 10.h),
                _detailItem(context, 'Exchange Rate(Not guaranteed)',
                    '${context.read<PaymentDetailsViewModel>().getExchageRate()} PKR'),
                SizedBox(height: 15.h),
                _detailItem(
                    context, 'Calculation', '${context.read<PaymentDetailsViewModel>().sendMoneyController.text} AUD x ${context.read<PaymentDetailsViewModel>().getExchageRate()} PKR', Colors.blue),
                SizedBox(height: 15.h),
                _detailItem(
                    context,
                    '${context.read<ReceiverViewModel>().selectedReceiver.value!.nickName} gets approximately',
                    '${(int.parse(context.read<PaymentDetailsViewModel>().sendMoneyController.text)*context.read<PaymentDetailsViewModel>().getExchageRate()).toInt()} PKR'),
                SizedBox(height: 5.h),
                _detailItem(
                    context, 'Should arrive', 'by ${context.read<ReceiptScreenViewModel>().selectedPaymentMethod.value!.arrivalTime}', Colors.grey),
                SizedBox(height: 14.h),
              ],
            )),
          ),
        ),
        _dottedLine(),
        Stack(
          alignment: Alignment.center,
          children: [
            ValueListenableBuilder<bool>(
                valueListenable:
                context.read<PaymentDetailsViewModel>().isAccountDeposit,
                builder: (_, value, __) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 14.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recipient Details',
                          style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.black),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Text(
                              'Change ',
                              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.change_circle_outlined,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    _detailItem(
                        context,
                        'Name',
                        '${context.read<ReceiverViewModel>().selectedReceiver.value!.nickName}',
                        Colors.grey),
                    SizedBox(height: 15.h),
                    _detailItemWithDropdown(context, 'Account Details', Colors.grey),                    SizedBox(height: 5.h),
                  ],
                );
              }
            ),
            // Positioned(
            //   left: 30,
            //   top: 0,
            //   right: 0,
            //   bottom: 20,
            //   child: SvgPicture.asset(
            //     AppAssets.icStampSvg,
            //     height: 100.h,
            //   ),
            // ),
          ],
        )
      ],
    );
  }
  Widget _detailItemWithDropdown(BuildContext context, String title,
      [Color color = Colors.black]) {
    return ValueListenableBuilder<ReceiverBank?>(
        valueListenable: context.read<ReceiverViewModel>().selectedReceiverBank,
        builder: (_, value, __) {
          return GestureDetector(
            onTap: () {

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(value == null ? 'No Bank Found' : value.accountNumber),

                  ],
                )
              ],
            ),
          );
        });
  }
  Widget _dottedLine() {
    return const DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 2.0,
      dashLength: 8.0,
      dashColor: Colors.grey,
      dashRadius: 0.0,
      dashGapLength: 4.0,
      dashGapColor: Colors.transparent,
    );
  }

  Widget _detailItem(BuildContext context, String title, String details, [Color color = Colors.black]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.bold)),
        Text(details, style: Theme.of(context).textTheme.bodyText2?.copyWith(color: color, fontSize: 12.sp, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _bankDetailItem(BuildContext context, String title, String details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.blue, fontSize: 12.sp, fontWeight: FontWeight.bold)),
        Text(details, style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black, fontSize: 12.sp)),
      ],
    );
  }
}
