import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/bottom_sheets/delete_card_bottom_sheet.dart';
import 'package:uremit/features/cards/presentation/manager/cards_view_model.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../utils/router/uremit_router_delegate.dart';

class CardItem extends StatelessWidget {
  const CardItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool cardsCondition = context.read<CardsViewModel>().allCards?.allCardsBody.isEmpty ?? true;
    if (context.read<CardsViewModel>().allCards == null || cardsCondition) {
      return Center(
        child: Text('No cards added yet!', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white70)),
      );
    }

    return ListView.separated(
      itemCount: context.read<CardsViewModel>().allCards!.allCardsBody.length + 1,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 22.h);
      },
      itemBuilder: (_, index) {
        if (index == context.read<CardsViewModel>().allCards!.allCardsBody.length) {
          return SizedBox(
            height: 16.h,
          );
        }
        return Container(
          height: 100.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF45496B),
                Color(0xFF282A3B),
              ],
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(context.read<CardsViewModel>().allCards!.allCardsBody[index].brand.getCardSvg(), width: 44.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        DeleteCardBottomSheet bottomSheet = DeleteCardBottomSheet(
                          context: context,
                          cardNumber: context.read<CardsViewModel>().allCards!.allCardsBody[index].maskedNumber,
                          id: context.read<CardsViewModel>().allCards!.allCardsBody[index].id,
                        );
                        globalHomeContext = context;
                        await bottomSheet.show();
                      },
                      child: Icon(CupertinoIcons.delete, color: Theme.of(context).errorColor),
                    ),
                    Text(context.read<CardsViewModel>().allCards!.allCardsBody[index].holder.toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white)),
                    Text(context.read<CardsViewModel>().allCards!.allCardsBody[index].maskedNumber,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
