import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:uremit/features/dashboard/models/get_transaction_list_response_model.dart';
import 'package:uremit/features/dashboard/presentation/manager/dashboard_view_model.dart';
import 'package:uremit/features/dashboard/presentation/widgets/transaction_details.dart';
import 'package:uremit/features/dashboard/presentation/widgets/transaction_tree.dart';
import 'package:uremit/features/dashboard/presentation/widgets/update_pending_transaction.dart';

import '../../../../app/widgets/clippers/payment_details_clipper.dart';
import '../../../../utils/constants/app_level/app_assets.dart';

class TransactionsListItem extends StatelessWidget {
  TransactionsListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<TransactionList>>(
        valueListenable: context.read<DashboardViewModel>().transactionList,
        builder: (_, value, __) {
          if (value.isEmpty) {
            return const Center(
              child: Text(
                'No record found',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: value.length,
              itemBuilder: (_, index) {
                ValueNotifier<int> selectedTab = ValueNotifier(1);
                return ExpansionTile(
                  leading: CircleAvatar(
                    radius: 20.r,
                    backgroundImage:
                        const AssetImage(AppAssets.transactionPlaceholderPng),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value[index].receiverName,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(color: Colors.white),
                            ),
                            Text(value[index].date,
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                      ),
                      Text(
                        '\$${value[index].sendingAmount.toString()}',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  iconColor: Colors.white,
                  collapsedIconColor: const Color(0xFF818492),
                  children: [
                    ClipPath(
                      clipper: PaymentDetailsClipper(),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFF404152),
                              Color(0xFF383A45),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: ToggleSwitch(
                                initialLabelIndex: 1,
                                totalSwitches: 2,
                                labels: const ['Update', 'Detail'],
                                inactiveBgColor: Colors.transparent,
                                inactiveFgColor: const Color(0xFF9EA0AE),
                                activeFgColor: Colors.white,
                                dividerColor: Colors.white,
                                fontSize: 11.sp,
                                activeBgColor: const [
                                  Colors.transparent,
                                  Colors.transparent
                                ],
                                onToggle: (index) {
                                  selectedTab.value = index!;
                                },
                              ),
                            ),
                            Divider(thickness: 1, height: 5.h),
                            SizedBox(height: 10.h),
                            ValueListenableBuilder<int>(
                                valueListenable: selectedTab,
                                builder: (_, selectedIndex, __) {
                                  return AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    child: selectedIndex == 0
                                        ? value[index].status == 'Requested'
                                            ? UpdatePendingTransaction(
                                                transaction: value[index],
                                              )
                                            : TreeDesign(
                                                statusList:
                                                    value[index].statusList,
                                              )
                                        : TransactionDetails(
                                            transaction: value[index],
                                          ),
                                  );
                                }),

                            // const UpdatePendingTransaction(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              });
        });
  }
}
