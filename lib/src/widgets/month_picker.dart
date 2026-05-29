import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MonthPicker extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function? onDateSelected;
  const MonthPicker({
    super.key,
    this.controller,
    this.labelText,
    required this.firstDate,
    required this.lastDate,
    this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // show date picker on field
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: labelText ?? "Ngày hết hạn",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 0, 0, 0),
            width: 4,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 0, 0, 0),
            width: 4,
          ),
        ),
        prefixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () =>
          showMonthPicker(
            context: context,
            firstDate: firstDate,
            lastDate: lastDate,
          ).then((selectedDate) {
            onDateSelected?.call(selectedDate);
          }),
    );
  }
}
