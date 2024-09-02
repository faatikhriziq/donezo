import 'package:flutter/material.dart';

class AppDropdownFormField extends StatelessWidget {
  final Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? items;
  final String? hint;
  const AppDropdownFormField(
      {super.key, this.onChanged, this.items, this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.3,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField(
          dropdownColor: Colors.white,
          itemHeight: 48,
          hint: Text(hint ?? 'Select'),
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.only(left: 12),
          ),
          items: items,
          onChanged: (value) {}),
    );
  }
}
