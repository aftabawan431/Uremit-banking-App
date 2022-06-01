import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../globals.dart';
import '../../providers/date_time_provider.dart';

class DateTimeBottomSheet {
  final BuildContext context;
  final DateTime initialSelectedDate;
  final bool isDob;
  DateTime? maxDate;

  DateTimeBottomSheet({required this.context, required this.initialSelectedDate, this.isDob = true, this.maxDate});

  DateTimeProvider get dateTimeProvider => sl();

  Future show() {
    DateTime selectDateTime = DateTime.now();
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r), topRight: Radius.circular(15.r)),
        ),
        padding: EdgeInsets.all(22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select Date', style: Theme.of(context).textTheme.subtitle1),
            SizedBox(height: 3.h),
            Text('Select ${isDob ? 'date of birth which must be 18+' : 'expiry date'}', style: Theme.of(context).textTheme.bodyText2),
            SizedBox(height: 22.h),
            SizedBox(
              height: 170.h,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                minimumDate: !isDob ? DateTime.now() : null,
                maximumDate: isDob ? initialSelectedDate : maxDate,
                initialDateTime: !isDob ? DateTime.now() : initialSelectedDate,
                onDateTimeChanged: (val) {
                  selectDateTime = val;
                },
              ),
            ),
            SizedBox(height: 10.h),
            OutlinedButton(
              onPressed: () {
                if (isDob) {
                  dateTimeProvider.dateTime.value = selectDateTime;
                } else {
                  dateTimeProvider.updateExpiryDate.value = selectDateTime;
                }
                Navigator.of(_).pop();
              },
              child: Text(
                'Pick',
                style: Theme.of(context).textTheme.button?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w300),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 48.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
