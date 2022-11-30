import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/payment/receiver_info/presentation/manager/receiver_info_view_model.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: context.read<ReceiverInfoViewModel>().status,
      builder: (_, value, __) {
        return FlutterSwitch(
          width: 50.h,
          height: 26.h,
          valueFontSize: 35.0,
          toggleSize: 15.0,
          activeColor: Colors.green,
          inactiveColor: Colors.grey,
          inactiveIcon: const Icon(Icons.cancel),
          activeIcon: const Icon(
            Icons.check,
            color: Colors.green,
          ),
          value: value,
          borderRadius: 30.0,
          showOnOff: false,
          onToggle: (val) {
            if (context.read<ReceiverInfoViewModel>().validateReceiverInfo()) {
              if (val == true) {
                context.read<ReceiverInfoViewModel>().pageController.animateToPage(1, duration: Duration(milliseconds: 400), curve: Curves.ease);
              }
              context.read<ReceiverInfoViewModel>().status.value = val;
            } else {
              context.read<ReceiverInfoViewModel>().status.value = false;
            }
          },
        );
      },
    );
  }
}
