import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/manager/receipt_screen_view_model.dart';
class PaymentSchduleWidget extends StatelessWidget {
  const PaymentSchduleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF7FCFF)
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.calendar_today,color:  Colors.blue,),
          const  SizedBox(width: 10,),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const[
              Text("Schedule",style: TextStyle(fontWeight: FontWeight.bold),),
              Text('or setup recurring transfer')
            ],),
          const Expanded(child: SizedBox.shrink()),
          ValueListenableBuilder<bool>(
            valueListenable: context.read<ReceiptScreenViewModel>().isSchedule,
            builder: (_, value, __) {
              return FlutterSwitch(
                width: 50.h,
                height: 26.h,
                valueFontSize: 35.0,
                toggleSize: 15.0,
                activeColor: Colors.green,
                inactiveColor: Colors.grey,
                // inactiveIcon: const Icon(Icons.cancel),
                // activeIcon: const Icon(
                //   Icons.check,
                //   color: Colors.green,
                // ),
                value: value,
                borderRadius: 30.0,
                showOnOff: false,
                onToggle: (val) {
                  context.read<ReceiptScreenViewModel>().isSchedule.value = val;

                },
              );
            },
          )
        ],
      ),
    );
  }
}
