import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/home/presentation/manager/home_view_model.dart';

import '../../../../../app/globals.dart';
import '../manager/payment_wrapper_view_model.dart';
import '../widgets/payment_wrapper_page_content.dart';

class PaymentWrapperPage extends StatefulWidget {
  const PaymentWrapperPage({Key? key}) : super(key: key);

  @override
  State<PaymentWrapperPage> createState() => _PaymentWrapperPageState();
}

class _PaymentWrapperPageState extends State<PaymentWrapperPage> {
  final PaymentWrapperViewModel _viewModel = sl();
  final HomeViewModel _homeViewModal = sl();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradient,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body:MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: _viewModel),
              ChangeNotifierProvider.value(value: _homeViewModal),
            ],
            child:  const PaymentWrapperPageContent(),
          )


        ),
      ),
    );
  }
}
