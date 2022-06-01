import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/dashboard/models/get_transaction_list_response_model.dart';

import '../../../../utils/constants/app_level/app_assets.dart';
import '../../../home/presentation/manager/home_view_model.dart';

class TransactionDetails extends StatefulWidget {
  TransactionDetails({Key? key, required this.transaction}) : super(key: key);
  TransactionList transaction;

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  @override
  Widget build(BuildContext context) {
    var transactionLists = widget.transaction;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All Transactions',
          style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white54),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
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
        _detailItem(context, 'You Sent', transactionLists.amount.toString()),
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
            Text(transactionLists.charges.toString(), style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontSize: 12.sp)),
          ],
        ),
        SizedBox(height: 5.h),
        _detailItem(context, 'We Converted', transactionLists.totalAmount.toString()),
        SizedBox(height: 5.h),
        _detailItem(context, 'Exchange Rate', transactionLists.exchnageRate.toString()),
        SizedBox(height: 10.h),
        // _dottedLine(),
        // SizedBox(height: 10.h),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     Text(
        //       'Samar',
        //       style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white),
        //     ),
        //     Text(
        //       '12343.23 PKR',
        //       style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white54),
        //     ),
        //   ],
        // ),
        SizedBox(height: 10.h),
        _dottedLine(),
        SizedBox(height: 10.h),
        _detailItem(context, 'Reference', context.read<HomeViewModel>().profileHeader!.profileHeaderBody.first.fullName),
        SizedBox(height: 5.h),
        _detailItem(context, 'Transaction Number', transactionLists.txn),
        SizedBox(height: 10.h),
        _dottedLine(),
        SizedBox(height: 10.h),
        _detailItem(context, 'Payment Method', transactionLists.bankName),
        SizedBox(height: 5.h),
        _detailItem(context, 'Status of Transaction', transactionLists.status, Colors.green),
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
                'Samar Bank Details',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white54),
              ),
              SizedBox(height: 10.h),
              _bankDetailItem(context, 'Recipient Type', transactionLists.amount.toString()),
              SizedBox(height: 5.h),
              _bankDetailItem(context, 'IBAN', transactionLists.iban),
              SizedBox(height: 5.h),
              _bankDetailItem(context, 'BANK CODE (BIC/SWIFT)', transactionLists.bankCode),
            ],
          ),
        ),
        SizedBox(height: 14.h),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              decoration: const ShapeDecoration(
                shape: StadiumBorder(),
                color: Color(0xFF282A3B),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Text('Repeat Transaction', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white, fontSize: 12)),
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

  Widget _detailItem(BuildContext context, String title, String details, [Color color = Colors.white]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontSize: 12.sp)),
        Text(details, style: Theme.of(context).textTheme.bodyText2?.copyWith(color: color, fontSize: 12.sp)),
      ],
    );
  }

  Widget _bankDetailItem(BuildContext context, String title, String details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black87, fontSize: 12.sp)),
        Text(details, style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontSize: 12.sp)),
      ],
    );
  }

  Widget _timeItem(BuildContext context, String title, String details) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w600),
        ),
        Text(
          details,
          style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
