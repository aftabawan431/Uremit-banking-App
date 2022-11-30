import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/cards/presentation/manager/cards_view_model.dart';
import 'package:uremit/utils/constants/app_level/app_assets.dart';
import 'package:uremit/utils/extensions/extensions.dart';

class SelectCardBottomSheet {
  final BuildContext context;

  SelectCardBottomSheet(this.context);

  Future show() async {
    return showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
            ),
            padding: EdgeInsets.only(top: 34.h, bottom: 12.w, left: 22.w, right: 22.w),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select card', style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 22.h),
                Expanded(
                  child: ListView.separated(
                    itemCount: context.read<CardsViewModel>().allCards!.allCardsBody.length + 1,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(thickness: 0.8, color: Colors.grey.withOpacity(0.8));
                    },
                    itemBuilder: (_, index) {
                      if (index == context.read<CardsViewModel>().allCards!.allCardsBody.length) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: SvgPicture.asset(AppAssets.icCardSvg, width: 44.w),
                          title: Text('Payment with new card'.toUpperCase(), style: Theme.of(context).textTheme.bodyText2),
                          // subtitle: Text(card.maskedNumber, style: Theme.of(context).textTheme.caption),
                          onTap: () {
                            context.read<CardsViewModel>().selectedCard = null;
                            context.read<CardsViewModel>().cardController.clear();
                            Timer(const Duration(milliseconds: 200), () {
                              FocusScopeNode currentFocus = FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.focusedChild?.unfocus();
                              }
                            });
                            Navigator.of(context).pop();
                          },
                        );
                      }
                      var card = context.read<CardsViewModel>().allCards!.allCardsBody[index];

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: SvgPicture.asset(card.brand.getCardSvg(), width: 44.w),
                        title: Text(card.holder.toUpperCase(), style: Theme.of(context).textTheme.bodyText2),
                        subtitle: Text(card.maskedNumber, style: Theme.of(context).textTheme.caption),
                        onTap: () {
                          context.read<CardsViewModel>().cardController.text = card.maskedNumber;
                          context.read<CardsViewModel>().selectedCard = card;
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
