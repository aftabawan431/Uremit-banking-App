import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/bottom_sheets/delete_receiver_info_bottom_sheet.dart';
import 'package:uremit/features/receivers/models/receiver_list_response_model.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';
import 'package:uremit/features/receivers/presentation/widgets/receiver_banks.dart';
import 'package:uremit/utils/encryption/encryption.dart';

import '../../../../app/widgets/customs/custom_form_field.dart';
import '../../../../utils/router/uremit_router_delegate.dart';

class ReceiverExpandedDetails extends StatefulWidget {
  ReceiverExpandedDetails({required this.receiverDetails, Key? key}) : super(key: key);

  final ReceiverListBody receiverDetails;

  @override
  State<ReceiverExpandedDetails> createState() => _ReceiverExpandedDetailsState();
}

class _ReceiverExpandedDetailsState extends State<ReceiverExpandedDetails> {
  ValueNotifier<bool> showEditNameOptionNotifier = ValueNotifier(false);

  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _controller.text = widget.receiverDetails.nickName;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Column(
        children: [
          const Divider(thickness: 1.5, color: Colors.grey),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Details', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.blueAccent)),
              GestureDetector(
                child: const Icon(CupertinoIcons.delete, color: Colors.redAccent),
                onTap: () {
                  DeleteReceiverInfoBottomSheet _bottomSheet =
                      DeleteReceiverInfoBottomSheet(context: context, isDeleteReceiver: true, receiverId: widget.receiverDetails.receiverId);
                  globalHomeContext = context;
                  _bottomSheet.show();
                },
              ),
            ],
          ),
          SizedBox(height: 22.h),
          Row(
            children: [
              Text('Nick Name', style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
              const Spacer(),
              ValueListenableBuilder<bool>(
                  valueListenable: showEditNameOptionNotifier,
                  builder: (_, value, __) {
                    if (value) {
                      return const SizedBox.shrink();
                    } else {
                      return Text(widget.receiverDetails.nickName,
                          style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold));
                    }
                  }),
              SizedBox(width: 5.w),
              Form(
                key: context.read<ReceiverViewModel>().editNickNameKey,
                child: ValueListenableBuilder<bool>(
                    valueListenable: showEditNameOptionNotifier,
                    builder: (_, value, __) {
                      if (value) {
                        return SizedBox(
                          height: 70,
                          width: 170,
                          child: CustomTextFormField(
                            maxLines: 1,
                            readOnly: false,
                            contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            validator: context.read<ReceiverViewModel>().validateNickName,
                            onChanged: context.read<ReceiverViewModel>().onNickNameChange,
                            keyboardType: TextInputType.name,
                            labelText: 'Nick Name',
                            hintText: '',
                            controller: _controller,
                            suffix: GestureDetector(
                                onTap: () {
                                  if (context.read<ReceiverViewModel>().editNickNameKey.currentState!.validate()) {
                                    context
                                        .read<ReceiverViewModel>()
                                        .updateReceiverNickName(context, widget.receiverDetails.receiverId, _controller.text, showEditNameOptionNotifier);
                                  }
                                },
                                child: const Icon(Icons.check_circle_outline, color: Colors.green)),
                            suffixIconOnTap: () {
                            },
                            onTap: () async {},
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            showEditNameOptionNotifier.value = true;
                          },
                          child: const Icon(
                            Icons.edit,
                            color: Colors.green,
                            size: 20,
                          ),
                        );
                      }
                    }),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _detailItem(context, 'First Name', widget.receiverDetails.firstName),
          SizedBox(height: 12.h),
          _detailItem(context, 'Middle Name', widget.receiverDetails.middleName),
          SizedBox(height: 12.h),
          _detailItem(context, 'Last Name', widget.receiverDetails.lastName),
          SizedBox(height: 12.h),
          _detailItem(context, 'Relationship', widget.receiverDetails.relationship),
          SizedBox(height: 12.h),
          _detailItem(context, 'Email', widget.receiverDetails.email),
          SizedBox(height: 12.h),
          _detailItem(context, 'Phone Number', widget.receiverDetails.mobileNumber),
          SizedBox(height: 10.h),
          const Divider(thickness: 1.5, color: Colors.grey),
          SizedBox(height: 10.h),
          ReceiverBanks(
            receiverId: widget.receiverDetails.receiverId,
            receiverBanks: widget.receiverDetails.banks,
            countryName: widget.receiverDetails.countryName,
            countryId: Encryption.encryptObject(widget.receiverDetails.countryId),
          ),
          SizedBox(height: 22.h),
        ],
      ),
    );
  }

  Widget _detailItem(BuildContext context, String title, String detail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).primaryColor)),
        Expanded(child: Text(detail, style: Theme.of(context).textTheme.caption, textAlign: TextAlign.right)),
      ],
    );
  }
}
