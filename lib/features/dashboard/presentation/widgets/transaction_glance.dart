import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../manager/dashboard_view_model.dart';

class TransactionGlance extends StatelessWidget {
  const TransactionGlance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      opacity: 0.9,
      color: Colors.black,
      offset: const Offset(0, 0),
      sigma: 20,
      child: Container(
        width: double.infinity,
        height: 100.h,
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE9E9E9),
              Color(0xFF98989C),
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _item('Total', context.read<DashboardViewModel>().getTransactionLists!.getTransactionListResponseModelBody.transactionsStats.totalTransaction.toString(), context),
            _divider(),
            _item('Successful',context.read<DashboardViewModel>().getTransactionLists!.getTransactionListResponseModelBody.transactionsStats.successfullTransaction.toString(), context),
            _divider(),
            _item('Pending', context.read<DashboardViewModel>().getTransactionLists!.getTransactionListResponseModelBody.transactionsStats.pendingTransaction.toString(), context),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return VerticalDivider(color: Colors.grey, thickness: 1.5, indent: 16.h, endIndent: 16.h);
  }

  Widget _item(String title, String count, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        SizedBox(height: 5.h),
        Text(
          count,
          style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
