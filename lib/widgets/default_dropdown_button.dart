import 'package:flutter/material.dart';

class DefaultDropdownButton extends StatelessWidget {
  final String dropdownValue;
  final List<String> dropdownItems;
  final Function(String? val) onChange;
  const DefaultDropdownButton(
      {super.key,
      required this.dropdownValue,
      required this.dropdownItems,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 20.0,
          offset: Offset(8, 8),
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      child: Center(
        child: DropdownButton(
          elevation: 0,
          onChanged: onChange,
          value: dropdownValue,
          items: dropdownItems.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
        ),
      ),
    );
  }
}
