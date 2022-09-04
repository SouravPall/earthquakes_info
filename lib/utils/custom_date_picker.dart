import 'package:flutter/material.dart';

void customDatePicker(BuildContext context, Function(DateTime dateTime)onSelect) async
{
  final date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1990), lastDate: DateTime.now());
  if (date != null){
    onSelect(date);
  }else{
    onSelect(DateTime.now());
  }
}