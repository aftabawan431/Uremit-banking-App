import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../app/globals.dart';
import '../../../../../utils/constants/app_level/app_url.dart';
import '../../../../receivers/models/receiver_list_response_model.dart';
import '../../../../receivers/presentation/manager/receiver_view_model.dart';
import '../../../receiver_info/presentation/manager/receiver_info_view_model.dart';
import '../manager/payment_wrapper_view_model.dart';

class HeaderReceiversItems extends StatelessWidget {
  const HeaderReceiversItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ReceiverListBody>>(
      valueListenable: context.read<ReceiverViewModel>().receiverListNotifierHeader,
      builder: (_, receiverList, __) {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: receiverList.length+1,
            itemBuilder: (context, index) {
              if(index==0){
                return GestureDetector(
                    onTap: (){
                      context.read<PaymentWrapperViewModel>().buttonTap(1);
                    },
                    child: const HeaderReceiverItem( item: null,));
              }
              return  HeaderReceiverItem(item: receiverList[index-1]);
            });
      },
    );
  }

}

class HeaderReceiverItem extends StatelessWidget {
  const HeaderReceiverItem({Key? key, required this.item}) : super(key: key);
  final ReceiverListBody? item;


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ReceiverListBody?>(
      valueListenable: context.read<ReceiverViewModel>().selectedReceiver,
      builder: (_,value,__) {
        return GestureDetector(
          onTap: item==null?null:(){
            context.read<ReceiverViewModel>().selectedReceiver.value=item;
            ReceiverInfoViewModel receiverInfoViewModel=sl();
            receiverInfoViewModel.countryId=context.read<ReceiverViewModel>().selectedReceiver.value!.countryId;
print(receiverInfoViewModel.countryId);
            if(item!.banks.isNotEmpty){
              context.read<ReceiverViewModel>().selectedReceiverBank.value=item!.banks[0];


            }else{
              context.read<ReceiverViewModel>().selectedReceiverBank.value=null;
            }


          },
          child: Container(
            margin:const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
               const SizedBox(height: 10,),
                ClipOval(
                  child: SizedBox(
                    height: 45.w,
                    width: 45.w,
                    child:
                   item==null?const Icon(Icons.person,color: Colors.white,): SvgPicture.network(AppUrl.fileBaseUrl + item!.svgPath, width: 45.w, height: 45.w, fit: BoxFit.cover),
                  ),
                ),
              const  SizedBox(height: 7,),
                Text(item==null?'Add New': item!.nickName, style: Theme.of(context).textTheme.subtitle2?.copyWith(color:Colors.white )),
                const  SizedBox(height: 10,),
                if(item!=null&&item==value)
                Container(height: 4,width: 34,decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),color: Colors.white,),)

              ],
            ),
          ),
        );
      }
    );
  }
}
