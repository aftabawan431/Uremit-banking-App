import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/cards/presentation/manager/cards_view_model.dart';
import 'package:uremit/features/cards/presentation/widgets/cards_page_content.dart';

import '../../../../app/globals.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> with AutomaticKeepAliveClientMixin {
  final CardsViewModel _viewModel = sl();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider.value(
        value: _viewModel,
        builder: (context, snapshot) {
          return const CardsPageContent();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
