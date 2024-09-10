import 'package:flutter/material.dart';

class AppDropdownFormField extends StatelessWidget {
  final Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? items;
  final String? hint;
  final bool isValid;
  const AppDropdownFormField(
      {super.key, this.onChanged, this.items, this.hint, this.isValid = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isValid ? Colors.black : Colors.red,
          width: 1.3,
        ),
        boxShadow: [
          BoxShadow(
            color: isValid ? Colors.black : Colors.red,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField(
        dropdownColor: Colors.white,
        itemHeight: 48,
        hint: Text(hint ?? 'Select',
            style: TextStyle(color: isValid ? Colors.black54 : Colors.red)),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(color: isValid ? Colors.black : Colors.red),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.only(left: 12),
        ),
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
