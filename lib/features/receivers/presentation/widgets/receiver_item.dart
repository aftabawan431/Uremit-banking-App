import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/receivers/models/receiver_list_response_model.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/features/receivers/presentation/widgets/receiver_expanded_details.dart';
import 'package:uremit/utils/constants/app_level/app_url.dart';

class ReceiverItems extends StatelessWidget {
  const ReceiverItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.read<ReceiverViewModel>().receiverListNotifier.value.isEmpty) {
      return Center(
        child: Text('No receivers found', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white70)),
      );
    }
    return ValueListenableBuilder<List<ReceiverListBody>>(
        valueListenable: context.read<ReceiverViewModel>().receiverListNotifier,
        builder: (_, receiverList, __) {
          if (receiverList.isEmpty) {
            return Center(
              child: Text('No receivers with such name', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white70)),
            );
          }
          return ListView.separated(
            itemCount: receiverList.length + 1,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return Divider(thickness: 1.5, color: Colors.grey, indent: 22.w, endIndent: 22.w);
            },
            itemBuilder: (_, index) {
              if (index == receiverList.length) {
                return SizedBox(
                  height: 28.h,
                );
              }
              ValueNotifier<bool> isExpansionOpenNotifier = ValueNotifier<bool>(false);
              return ValueListenableBuilder<bool>(
                valueListenable: isExpansionOpenNotifier,
                builder: (_, expansionOpen, __) {
                  var color = expansionOpen ? Theme.of(context).primaryColor : Colors.white;
                  return ExpansionTileCard(
                    baseColor: Colors.transparent,
                    expandedColor: Colors.white,
                    leading: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.grey, width: 1),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(getFirstLetter(receiverList[index].firstName) + getFirstLetter(receiverList[index].lastName),
                              style: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.bold)),
                        ),
                        ClipOval(
                          child: SizedBox(
                            height: 20.w,
                            width: 20.w,
                            child: SvgPicture.network(AppUrl.fileBaseUrl + receiverList[index].svgPath, width: 20.w, height: 20.w, fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                    title: Text(receiverList[index].nickName, style: Theme.of(context).textTheme.subtitle2?.copyWith(color: color)),
                    trailing: const Icon(Icons.expand_more, color: Color(0xFF818492)),
                    animateTrailing: true,
                    expandedTextColor: Theme.of(context).primaryColor,
                    onExpansionChanged: (value) => isExpansionOpenNotifier.value = value,
                    borderRadius: BorderRadius.circular(25.r),
                    finalPadding: EdgeInsets.symmetric(vertical: 16.w),
                    duration: const Duration(milliseconds: 300),
                    children: [
                      ReceiverExpandedDetails(receiverDetails: receiverList[index]),
                    ],
                  );
                },
              );
            },
          );
        });
  }

  String getFirstLetter(String value){
    if(value.isNotEmpty){
      return value[0].toUpperCase();
    }else{
      return '';
    }
  }
}
