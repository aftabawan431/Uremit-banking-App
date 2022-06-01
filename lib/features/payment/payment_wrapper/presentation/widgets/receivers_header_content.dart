import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../receivers/presentation/manager/receiver_view_model.dart';
import 'header_receivers_items.dart';

class ReceiversHeaderContent extends StatefulWidget {
  const ReceiversHeaderContent({Key? key}) : super(key: key);

  @override
  State<ReceiversHeaderContent> createState() => _ReceiversHeaderContentState();
}

class _ReceiversHeaderContentState extends State<ReceiversHeaderContent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted)
    context.read<ReceiverViewModel>().getReceiverList(recall: false);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: context.read<ReceiverViewModel>().isLoadingNotifier,
      builder: (_, value, __) {
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: value
                ? const Center(child: CircularProgressIndicator())
                : const HeaderReceiversItems());
      },
    );
  }
}
