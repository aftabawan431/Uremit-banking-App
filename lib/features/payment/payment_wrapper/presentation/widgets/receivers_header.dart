import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/globals.dart';
import 'package:uremit/features/payment/payment_wrapper/presentation/widgets/receivers_header_content.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
class ReceiversHeaders extends StatelessWidget {
   ReceiversHeaders({Key? key}) : super(key: key);
  ReceiverViewModel viewModel=sl();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: ChangeNotifierProvider.value(value: viewModel,child:const ReceiversHeaderContent(),));
  }
}
