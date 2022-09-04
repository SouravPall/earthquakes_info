import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getFormattedDateTime(num dt, String pattern) {
  return DateFormat(pattern)
      .format(DateTime.fromMillisecondsSinceEpoch(dt.toInt()));
}
String getFormattedTime(num dt) {
  return DateFormat('hh:mm a')
      .format(DateTime.fromMillisecondsSinceEpoch(dt.toInt()));
}

void showMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
    ),
  );
}

void showMsgWithAction(
    {required BuildContext context, required String msg, required VoidCallback onPressed}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(days: 365),
      content: Text(msg),
      action: SnackBarAction(
        label: 'Goto Settings',
        onPressed: (){
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          onPressed();
        },
      ),
    ),
  );
}
