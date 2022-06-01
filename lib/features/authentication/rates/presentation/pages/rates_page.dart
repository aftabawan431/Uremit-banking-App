import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/authentication/rates/presentation/manager/rates_view_model.dart';

import '../../../../../app/globals.dart';
import '../widgets/rates_page_content.dart';

class RatesPage extends StatefulWidget {
  const RatesPage({Key? key}) : super(key: key);

  @override
  State<RatesPage> createState() => _RatesPageState();
}

class _RatesPageState extends State<RatesPage> {
  final RatesViewModel _viewModel = sl();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider.value(
          value: _viewModel,
          builder: (context, snapshot) {
            return const RatesPageContent();
          },
        ),
      ),
    );
  }
}
