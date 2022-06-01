import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uremit/features/payment/receipt_screen/modal/getPaymentMethodResponseModal.dart';
class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({required this.paymentMethod, Key? key}) : super(key: key);
  final PaymentMethodBody paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              gradient: const LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                Color(0xFF20597D),
                Color(0xFF5FB3EA),
              ]),
            ),
            child: Row(children: [
              const Padding(padding: const EdgeInsets.symmetric(horizontal: 15),child: Icon(Icons.credit_card_sharp,color: Colors.white,),),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,children: [
                  Text(paymentMethod.name,style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  ),),
                  Text('${paymentMethod.charges} AUD in total fees',style: const TextStyle(fontSize: 12,color: Colors.white),),
                  const SizedBox(height: 5,),
                  Text(paymentMethod.description,style: const TextStyle(color: Colors.white,fontSize: 12),)

                ],),
              ),

             const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.keyboard_arrow_down,color: Colors.white,))


            ],));
      },
    );
  }
}
