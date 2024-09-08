import 'package:donezo/config/theme/app_color.dart';
import 'package:donezo/core/widgets/app_button.dart';
import 'package:donezo/core/widgets/common_text_field.dart';
import 'package:flutter/material.dart';

class AddCategoryDialog extends StatefulWidget {
  final Function() onTap;
  final TextEditingController controller;
  const AddCategoryDialog(
      {super.key, required this.onTap, required this.controller});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: MediaQuery.of(context).size.width > 600
              ? 410.0
              : MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColor.scaffoldBackground,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Add Category', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 16),
              CommonTextField(
                hintText: 'Enter category name',
                controller: widget.controller,
              ),
              const SizedBox(height: 16),
              AppButton(
                width: MediaQuery.of(context).size.width > 600
                    ? 410.0 - 12
                    : constraints.maxWidth - 12,
                onTap: widget.onTap,
                child: const Text(
                  'Add',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
