import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/dashboard/presentation/manager/dashboard_view_model.dart';
import 'package:uremit/features/dashboard/presentation/widgets/dashboard_page_content.dart';
import 'package:uremit/features/home/presentation/manager/home_view_model.dart';
import 'package:uremit/features/payment/payment_details/presentation/manager/payment_details_view_model.dart';

import '../../../../../app/globals.dart';
import '../../../receivers/presentation/manager/receiver_view_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with AutomaticKeepAliveClientMixin {
  final DashboardViewModel _viewModel = sl();
  final HomeViewModel _viewModel2 = sl();
  final PaymentDetailsViewModel _paymentDetailsViewModel = sl();
  final ReceiverViewModel _receiverViewModel = sl();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: _viewModel),
            ChangeNotifierProvider.value(value: _viewModel2),
            ChangeNotifierProvider.value(value: _paymentDetailsViewModel),
            ChangeNotifierProvider.value(value: _receiverViewModel),
          ],
          child: const DashboardPageContent(),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
