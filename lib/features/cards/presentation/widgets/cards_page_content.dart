import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/cards/presentation/widgets/card_item.dart';
import 'package:uremit/features/cards/presentation/widgets/card_loading_item.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../app/widgets/customs/custom_app_bar.dart';
import '../manager/cards_view_model.dart';

class CardsPageContent extends StatefulWidget {
  const CardsPageContent({Key? key}) : super(key: key);

  @override
  _CardsPageContentState createState() => _CardsPageContentState();
}

class _CardsPageContentState extends State<CardsPageContent> {
  @override
  void initState() {
    context.read<CardsViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    context.read<CardsViewModel>().getAllCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(title: 'Cards'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cards', style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white)),
                DottedLine(
                  direction: Axis.horizontal,
                  lineLength: 20.w,
                  lineThickness: 4.0,
                  dashLength: 4.0,
                  dashColor: Colors.white70,
                  dashRadius: 20.0,
                  dashGapLength: 2,
                  dashGapColor: Colors.transparent,
                ),
              ],
            ),
            SizedBox(height: 22.h),
            Expanded(
              child: ValueListenableBuilder<bool>(
                valueListenable: context.read<CardsViewModel>().isLoadingNotifier,
                builder: (_, value, __) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: value ? const CardLoadingItem() : const CardItem(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
