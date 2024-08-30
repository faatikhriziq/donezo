import 'package:flutter/material.dart';

class AppDropdownFormField extends StatelessWidget {
  const AppDropdownFormField({super.key});

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
          hint: const Text('Select a category'),
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Enter task category',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.only(left: 12),
          ),
          items: [
            DropdownMenuItem(
              child: Text('Item 1'),
              value: '1',
              alignment: Alignment.center,
            ),
            DropdownMenuItem(
              child: Text('Item 2'),
              value: '2',
              alignment: Alignment.center,
            ),
            DropdownMenuItem(
              child: Text('Item 3'),
              value: '3',
              alignment: Alignment.center,
            ),
          ],
          onChanged: (value) {}),
    );
  }
}
