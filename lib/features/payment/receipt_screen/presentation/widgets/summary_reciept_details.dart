import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:uremit/features/payment/receiver_info/presentation/manager/receiver_info_view_model.dart';

import '../../../../home/presentation/manager/home_view_model.dart';
import '../../../../receivers/models/receiver_list_response_model.dart';
import '../../../../receivers/presentation/manager/receiver_view_model.dart';
import '../../../payment_details/presentation/manager/payment_details_view_model.dart';
import '../manager/receipt_screen_view_model.dart';

class SummaryReceiptDetails extends StatelessWidget {
  const SummaryReceiptDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiptScreenViewModel>(builder: (_, provider, __) {
      final transaction = provider.getTransactionByTxnResponseModel;
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            child: Column(
              children: [
                ValueListenableBuilder<String>(
                  valueListenable:
                      context.read<ReceiptScreenViewModel>().transactionStatus,
                  builder: (_, value, __) {
                    return Text(
                      'Transaction $value'.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.black, fontSize: 20.sp),
                    );
                  },
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
                      provider.fromChangePaymentMethod
                          ? provider.updateTransaction!.sendingAmount.toString()
                          : context
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
                      '${context.read<ReceiverInfoViewModel>().adminFeeGet} AUD'),
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
                  // _bankDetailItem(context, 'Payout Partner', '${0.0} AUD'),
                  SizedBox(height: 10.h),
                  _bankDetailItem(context, 'Payment Gateway',
                      '${context.read<ReceiptScreenViewModel>().selectedPaymentMethod.value!.charges} AUD'),
                  // _bankDetailItem(context, 'Payment Gateway', '${0.0} AUD'),
                  SizedBox(height: 15.h),

                  _detailItem(context, 'Total Fee',
                      '${context.read<ReceiptScreenViewModel>().totalFee.value} AUD'),
                  SizedBox(height: 15.h),
                  ValueListenableBuilder<double>(
                    valueListenable:
                        context.read<ReceiptScreenViewModel>().totalFee,
                    builder: (_, value, ch) {
                      return _detailItem(
                          context,
                          'Amount we\'ll convert',
                          provider.fromChangePaymentMethod
                              ? '${provider.deliveringAmountUpdateTransaction()}'
                              : '${context.read<ReceiptScreenViewModel>().deliveringAmount()} AUD');
                    },
                  ),
                  SizedBox(height: 10.h),
                  _detailItem(
                      context,
                      'Exchange Rate(Not guaranteed)',
                      provider.fromChangePaymentMethod
                          ? '${provider.updateTransaction!.exchangeRate}'
                          : '${context.read<PaymentDetailsViewModel>().getExchageRate()} PKR'),
                  SizedBox(height: 15.h),
                  _detailItem(
                      context,
                      'Calculation',
                      provider.fromChangePaymentMethod
                          ? '${provider.updateTransaction!.sendingAmount.toStringAsFixed(2)} - ${provider.totalFee.value.toStringAsFixed(2)} AUD x ${provider.updateTransaction!.exchangeRate}'
                          : '${(double.parse(context.read<PaymentDetailsViewModel>().sendMoneyController.text) - context.read<ReceiptScreenViewModel>().totalFee.value).toStringAsFixed(2)} AUD x ${context.read<PaymentDetailsViewModel>().getExchageRate()} PKR',
                      Colors.blue),
                  SizedBox(height: 15.h),
                  _detailItem(
                      context,
                      '${context.read<ReceiverViewModel>().selectedReceiver.value!.nickName} gets approximately',
                      provider.fromChangePaymentMethod
                          ? '${provider.deliveringAmountUpdateTransaction()}'
                          : '${((double.parse(context.read<PaymentDetailsViewModel>().sendMoneyController.text) - context.read<ReceiptScreenViewModel>().totalFee.value) * context.read<PaymentDetailsViewModel>().getExchageRate().toInt()).toStringAsFixed(2)} PKR'),
                  SizedBox(height: 5.h),
                  _detailItem(
                      context, 'Should arrive', 'By Same Day', Colors.grey),
                  SizedBox(height: 5.h),
                  _detailItem(
                      context, 'Reference', context
                      .read<HomeViewModel>()
                      .profileHeader!
                      .profileHeaderBody
                      .first
                      .fullName),
                  SizedBox(height: 5.h),
                  _detailItem(
                      context, 'Transaction Number', transaction!.txn),
                  SizedBox(height: 5.h),
                  _detailItem(
                      context, 'Payment Method', transaction.payoutMethod),SizedBox(height: 5.h),
                  _detailItem(
                      context, 'Payment Gateway', transaction.paymentGateway),SizedBox(height: 5.h),
                  _detailItem(
                      context, 'Status of Transaction', transaction.status),
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sender Details',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        _detailItem(context, 'Sender ID', '${transaction!.senderID}',
                            Colors.grey),
                        SizedBox(height: 5.h),
                        _detailItem(context, 'Sender Name', '${transaction.senderName}',
                            Colors.grey),
                        SizedBox(height: 5.h),
                        _detailItem(context, 'Sender Address', '${transaction.senderAddress}',
                            Colors.grey),
                        SizedBox(height: 5.h),
                        _detailItem(context, 'Sender Phone', '${transaction.senderPhone}',
                            Colors.grey),
                        SizedBox(height: 5.h),
                        SizedBox(height: 10.h),
                        _dottedLine(),
                        SizedBox(height: 10.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Recipient Details',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        _detailItem(context, 'IBAN', '${transaction!.txn}',
                            Colors.grey),
                        SizedBox(height: 5.h),
                        _detailItem(context, 'Full Name',
                            '${transaction.beneficiaryName}', Colors.grey),
                        SizedBox(height: 5.h),
                        _detailItem(context, 'Mobile',
                            '${transaction.beneficiaryMobile}', Colors.grey),
                        SizedBox(height: 5.h),
                        _detailItem(context, 'BANK CODE (BIC/SWIFT)',
                            '${transaction.bankCode}', Colors.grey),
                        SizedBox(height: 5.h),
                        _detailItem(context, 'Bank Name',
                            transaction.beneficiaryBankName, Colors.grey),
                        SizedBox(height: 5.h),
                        _detailItem(context, 'BeneficiaryAddress',
                            transaction.beneficiaryAddress, Colors.grey),
                        SizedBox(height: 5.h),
                        // _detailItem(
                        //     context,
                        //     'Name',
                        //     '${context.read<ReceiverViewModel>().selectedReceiver.value!.nickName}',
                        //     Colors.grey),
                        // SizedBox(height: 5.h),
                        _detailItemWithDropdown(
                            context, 'Account Details', Colors.grey),
                        SizedBox(height: 5.h),
                      ],
                    );
                  }),
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
    });
  }

  Widget _detailItemWithDropdown(BuildContext context, String title,
      [Color color = Colors.black]) {
    return ValueListenableBuilder<ReceiverBank?>(
        valueListenable: context.read<ReceiverViewModel>().selectedReceiverBank,
        builder: (_, value, __) {
          return GestureDetector(
            onTap: () {},
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

  Widget _detailItem(BuildContext context, String title, String details,
      [Color color = Colors.black]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold)),
        Text(details,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: color, fontSize: 12.sp, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _bankDetailItem(BuildContext context, String title, String details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: Colors.blue,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold)),
        Text(details,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.black, fontSize: 12.sp)),
      ],
    );
  }
}
