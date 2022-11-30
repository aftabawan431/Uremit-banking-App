import 'dart:typed_data';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:uremit/features/dashboard/models/get_transaction_list_response_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../app/globals.dart';
import '../../../../utils/constants/app_level/app_assets.dart';
import '../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../utils/router/app_state.dart';
import '../../../../utils/router/models/page_action.dart';
import '../../../../utils/router/models/page_config.dart';
import '../../../home/presentation/manager/home_view_model.dart';
import '../../../payment/receipt_screen/presentation/manager/receipt_screen_view_model.dart';
import '../../../receivers/presentation/manager/receiver_view_model.dart';

class TransactionDetails extends StatefulWidget {
  TransactionDetails({Key? key, required this.transaction}) : super(key: key);
  TransactionList transaction;

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  ScreenshotController screenshotController = ScreenshotController();
  Widget getTransactions() {
    var transactionLists = widget.transaction;
    return Container(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 40.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Transaction',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white54),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _timeItem(context, 'Date', transactionLists.date),
                    _timeItem(context, 'Time', transactionLists.time),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),
            _detailItem(
                context, 'You Sent', transactionLists.sendingAmount.toString()),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Our Fee',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Colors.white54,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                ),
                Text(transactionLists.totalFee.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: Colors.white, fontSize: 12.sp)),
              ],
            ),
            SizedBox(height: 5.h),
            _detailItem(context, 'We Converted',
                transactionLists.sendingAmount.toString()),
            SizedBox(height: 5.h),
            _detailItem(context, 'Exchange Rate',
                transactionLists.exchangeRate.toString()),
            SizedBox(height: 10.h),
            SizedBox(height: 10.h),
            _dottedLine(),
            SizedBox(height: 10.h),
            _detailItem(
                context,
                'Reference',
                context
                    .read<HomeViewModel>()
                    .profileHeader!
                    .profileHeaderBody
                    .first
                    .fullName),
            SizedBox(height: 5.h),
            _detailItem(context, 'Transaction Number', transactionLists.txn),
            SizedBox(height: 10.h),
            _dottedLine(),
            SizedBox(height: 10.h),
            _detailItem(context, 'Sender ID', transactionLists.senderID),
            SizedBox(height: 5.h),
            _detailItem(context, 'Sender Name', transactionLists.senderName),
            SizedBox(height: 5.h),
            _detailItem(context, 'Sender Address', transactionLists.senderAddress),
            SizedBox(height: 5.h),
            _detailItem(context, 'Sender Phone', transactionLists.senderPhone),
            SizedBox(height: 10.h),
            _dottedLine(),
            SizedBox(height: 10.h),
            _detailItem(
                context, 'Payment Method', transactionLists.payoutMethod),
            SizedBox(height: 5.h),
            _detailItem(
                context, 'Payment Gateway', transactionLists.paymentGateway),

            SizedBox(height: 5.h),
            _detailItem(context, 'Status of Transaction',
                transactionLists.status, Colors.green),
            SizedBox(height: 14.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: const Color(0xFF6E6F6F),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${transactionLists.receiverName} Bank Details',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: Colors.white54),
                  ),
                  SizedBox(height: 10.h),

                  // _bankDetailItem(context, 'Recipient Type', transactionLists.deliveredAmount.toString()),
                  // SizedBox(height: 5.h),
                  _bankDetailItem(context, 'IBAN', transactionLists.iban),
                  SizedBox(height: 5.h),
                  _bankDetailItem(context, 'BANK CODE (BIC/SWIFT)',
                      transactionLists.bankCode),
                  SizedBox(height: 5.h),
                  _bankDetailItem(
                      context, 'BANK Name', transactionLists.beneficiaryBankName),
                  SizedBox(height: 5.h),
                  _bankDetailItem(
                      context, 'Branch Code', transactionLists.beneficiaryBankBranchCode),
                  SizedBox(height: 5.h),
                  _bankDetailItem(
                      context, 'Beneficiary Address', transactionLists.beneficiaryAddress),
                ],
              ),
            ),
            SizedBox(height: 14.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var transactionLists = widget.transaction;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transaction',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: Colors.white54),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                final res = await Permission.storage.status;
                if (res == PermissionStatus.permanentlyDenied) {
                  return context.show(
                      message:
                          'Storage permission is permanently denied please allow from setting',
                      backgroundColor: Colors.red);
                } else if (res == PermissionStatus.denied) {
                  final response = await Permission.storage.request();
                  if (response != PermissionStatus.granted) {
                    return context.show(
                        message: 'Please allow permission to download image',
                        backgroundColor: Colors.red);
                  }
                }

                screenshotController
                    .captureFromWidget(getTransactions())
                    .then((Uint8List image) async {
                  final result = await ImageGallerySaver.saveImage(image,
                      quality: 80, name: DateTime.now().toString());
                  if (result['isSuccess']) {
                    context.show(
                        message: 'Receipt Saved',
                        backgroundColor: Colors.green);
                  } else {
                    context.show(
                        message: "Receipt couldn't be saved",
                        backgroundColor: Colors.red);
                  }

                  // Handle captured image
                });
              },
              child: SvgPicture.asset(AppAssets.icDownloadSvg, width: 30.w),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _timeItem(context, 'Date', transactionLists.date),
                _timeItem(context, 'Time', transactionLists.time),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.h),
        _detailItem(
            context, 'You Sent', transactionLists.sendingAmount.toString()),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Our Fee',
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: Colors.white54,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
            ),
            Text(transactionLists.totalFee.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: Colors.white, fontSize: 12.sp)),
          ],
        ),
        SizedBox(height: 5.h),
        _detailItem(
            context, 'We Converted', "${transactionLists.sendingAmount-transactionLists.totalFee}"),
        SizedBox(height: 5.h),
        _detailItem(
            context, 'Exchange Rate', transactionLists.exchangeRate.toString()),
        SizedBox(height: 10.h),
        SizedBox(height: 10.h),
        _dottedLine(),
        SizedBox(height: 10.h),
        _detailItem(
            context,
            'Reference',
            context
                .read<HomeViewModel>()
                .profileHeader!
                .profileHeaderBody
                .first
                .fullName),
        SizedBox(height: 5.h),
        _detailItem(context, 'Transaction Number', transactionLists.txn),
        SizedBox(height: 10.h),
        _dottedLine(),
        SizedBox(height: 10.h),

        _detailItem(context, 'Sender ID', transactionLists.senderID),
        SizedBox(height: 5.h),
        _detailItem(context, 'Sender Name', transactionLists.senderName),
        SizedBox(height: 5.h),
        _detailItem(context, 'Sender Address', transactionLists.senderAddress),
        SizedBox(height: 5.h),
        _detailItem(context, 'Sender Phone', transactionLists.senderPhone),
        SizedBox(height: 10.h),
        _dottedLine(),
        SizedBox(height: 10.h),


        _detailItem(context, 'Payment Method', transactionLists.payoutMethod),
        SizedBox(height: 5.h),
        _detailItem(context, 'Payment Gateway', transactionLists.paymentGateway),
        SizedBox(height: 5.h),
        transactionLists.status == 'Completed'
            ? _detailItem(context, 'Status of Transaction',
                transactionLists.status, Colors.green)
            : _detailItem(context, 'Status of Transaction',
                transactionLists.status, Colors.red),
        SizedBox(height: 14.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: const Color(0xFF6E6F6F),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Receiver Bank Details',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: Colors.white54),
              ),
              SizedBox(height: 10.h),
              // _bankDetailItem(context, 'Recipient Type', transactionLists.deliveredAmount.toString()),
              // SizedBox(height: 5.h),
              _bankDetailItem(context, 'IBAN', transactionLists.iban),
              SizedBox(height: 5.h),
              _bankDetailItem(context, 'Full Name', transactionLists.beneficiaryName),
              SizedBox(height: 5.h),
              _bankDetailItem(context, 'Mobile', transactionLists.beneficiaryMobile),
              SizedBox(height: 5.h),
              _bankDetailItem(
                  context, 'BANK CODE (BIC/SWIFT)', transactionLists.bankCode),

              SizedBox(height: 5.h),
              _bankDetailItem(
                  context, 'BANK Name', transactionLists.beneficiaryBankName),
              SizedBox(height: 5.h),
              _bankDetailItem(
                  context, 'Branch Code', transactionLists.beneficiaryBankBranchCode),
              SizedBox(height: 5.h),
              _bankDetailItem(
                  context, 'BeneficiaryAddress', transactionLists.beneficiaryAddress),
            ],
          ),
        ),
        SizedBox(height: 14.h),
        if (widget.transaction.status == 'Completed')
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                if (widget.transaction.isReceiverDeleted) {
                  context.show(
                      message: 'This receiver has been deleted by you!');
                  return;
                }
                ReceiverViewModel _receiverViewModel = sl();
                _receiverViewModel.selectedReceiver.value = _receiverViewModel
                    .receiverList!.receiverListBody
                    .firstWhere((element) =>
                        element.receiverId == widget.transaction.receiverId);
                ReceiptScreenViewModel _receiptScreen = sl();
                _receiptScreen.updateTransaction = widget.transaction;
                _receiptScreen.fromChangePaymentMethod = true;
                _receiptScreen.isRepeatTransaction = true;
                AppState appState = sl();
                appState.currentAction = PageAction(
                    state: PageState.addPage,
                    page: PageConfigs.receiptScreenPageConfig);
              },
              child: Container(
                decoration: const ShapeDecoration(
                  shape: StadiumBorder(),
                  color: Color(0xFF282A3B),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Text('Repeat Transaction',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.white, fontSize: 12)),
              ),
            ),
          ),
        SizedBox(height: 5.h),
      ],
    );
  }

  Widget _dottedLine() {
    return const DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 2.0,
      dashLength: 8.0,
      dashColor: Colors.white70,
      dashRadius: 0.0,
      dashGapLength: 4.0,
      dashGapColor: Colors.transparent,
    );
  }

  Widget _detailItem(BuildContext context, String title, String details,
      [Color color = Colors.white]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.white, fontSize: 12.sp)),
        Text(details,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: color, fontSize: 12.sp)),
      ],
    );
  }

  Widget _bankDetailItem(BuildContext context, String title, String details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.black87, fontSize: 12.sp)),
        Text(details,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.white, fontSize: 12.sp)),
      ],
    );
  }

  Widget _timeItem(BuildContext context, String title, String details) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w600),
        ),
        Text(
          details,
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
