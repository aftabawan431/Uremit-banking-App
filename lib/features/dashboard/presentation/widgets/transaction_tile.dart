// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../utils/constants/app_level/app_assets.dart';
// class TransactionTile extends StatelessWidget {
//   const TransactionTile({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ExpansionTile(
//       leading: CircleAvatar(
//         radius: 20.r,
//         backgroundImage: const AssetImage(AppAssets.transactionPlaceholderPng),
//       ),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   value[index].receiverName,
//                   style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white),
//                 ),
//                 Text(value[index].date, style: Theme.of(context).textTheme.caption),
//               ],
//             ),
//           ),
//           Text(
//             '\$${value[index].sendingAmount.toString()}',
//             style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white),
//           ),
//         ],
//       ),
//       iconColor: Colors.white,
//       collapsedIconColor: const Color(0xFF818492),
//       children: [
//         ClipPath(
//           clipper: PaymentDetailsClipper(),
//           child: Container(
//             width: double.infinity,
//             padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 14.h),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20.r),
//               gradient: const LinearGradient(
//                 begin: Alignment.topRight,
//                 end: Alignment.bottomLeft,
//                 colors: [
//                   Color(0xFF404152),
//                   Color(0xFF383A45),
//                 ],
//               ),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: ToggleSwitch(
//                     initialLabelIndex: 1,
//                     totalSwitches: 2,
//                     labels: const ['Update', 'Detail'],
//                     inactiveBgColor: Colors.transparent,
//                     inactiveFgColor: const Color(0xFF9EA0AE),
//                     activeFgColor: Colors.white,
//                     dividerColor: Colors.white,
//                     fontSize: 11.sp,
//                     activeBgColor: const [Colors.transparent, Colors.transparent],
//                     onToggle: (index) {
//                       selectedTab.value = index!;
//                       print('switched to: $index');
//                     },
//                   ),
//                 ),
//                 Divider(thickness: 1, height: 5.h),
//                 SizedBox(height: 10.h),
//                 ValueListenableBuilder<int>(
//                     valueListenable: selectedTab,
//                     builder: (_, selectedIndex, __) {
//                       return AnimatedSwitcher(
//                         duration: const Duration(milliseconds: 200),
//                         child: selectedIndex == 0
//                             ? TreeDesign(
//                           statusList: value[index].statusList,
//                         )
//                             : TransactionDetails(
//                           transaction: value[index],
//                         ),
//                       );
//                     }),
//
//                 // const UpdatePendingTransaction(),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
