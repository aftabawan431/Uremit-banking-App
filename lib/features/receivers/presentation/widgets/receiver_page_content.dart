import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/features/receivers/presentation/widgets/receiver_item.dart';
import 'package:uremit/features/receivers/presentation/widgets/receiver_loading_item.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../app/globals.dart';
import '../../../../app/widgets/customs/custom_app_bar.dart';
import '../../../../utils/constants/enums/page_state_enum.dart';
import '../../../../utils/router/app_state.dart';
import '../../../../utils/router/models/page_action.dart';
import '../../../../utils/router/models/page_config.dart';

class ReceiverPageContent extends StatefulWidget {
  const ReceiverPageContent({Key? key}) : super(key: key);

  @override
  _ReceiverPageContentState createState() => _ReceiverPageContentState();
}

class _ReceiverPageContentState extends State<ReceiverPageContent> {
  @override
  void initState() {
    context.read<ReceiverViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    context.read<ReceiverViewModel>().getReceiverList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(title: 'Dashboard'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Row(
              children: [
                Text('Your Receivers', style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white)),
                const Spacer(flex: 1),
                SimpleShadow(
                  opacity: 0.9,
                  color: Colors.black,
                  offset: const Offset(0, 0),
                  sigma: 10,
                  child: GestureDetector(
                    onTap: () {
                      AppState appState = sl();
                      appState.currentAction = PageAction(state: PageState.addPage, page: PageConfigs.addReceiverPageConfig);
                    },
                    child: Container(
                      decoration: const ShapeDecoration(
                        shape: StadiumBorder(),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 7.h),
                      child: Text('Add New', style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).primaryColor)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: CupertinoTextField(
              suffix: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: const Icon(CupertinoIcons.search, color: Color(0xFF818492)),
              ),
              padding: EdgeInsets.only(left: 14.w, right: 4.w, top: 12.h, bottom: 12.h),
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: const Color(0xFF818492)),
                borderRadius: BorderRadius.circular(25.r),
              ),
              style: TextStyle(color: const Color(0xFF818492), fontSize: 12.sp),
              placeholder: 'Search',
              placeholderStyle: TextStyle(color: const Color(0xFF818492), fontSize: 12.sp),
              textAlignVertical: TextAlignVertical.center,
              onChanged: context.read<ReceiverViewModel>().filterSearchResults,
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ValueListenableBuilder<bool>(
              valueListenable: context.read<ReceiverViewModel>().isLoadingNotifier,
              builder: (_, value, __) {
                return AnimatedSwitcher(duration: const Duration(milliseconds: 500), child: value ? const ReceiverLoadingItem() : const ReceiverItems());
              },
            ),
          ),
          // const Expanded(child: ReceiverLoadingItem())
        ],
      ),
    );
  }
}
