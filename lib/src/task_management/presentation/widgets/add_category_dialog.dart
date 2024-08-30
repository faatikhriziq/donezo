import 'package:donezo/config/theme/app_color.dart';
import 'package:donezo/core/widgets/app_button.dart';
import 'package:donezo/core/widgets/common_text_field.dart';
import 'package:flutter/material.dart';

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: MediaQuery.of(context).size.width > 600 ? 410.0 : MediaQuery.of(context).size.width,
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
                controller: controller,
              ),
              const SizedBox(height: 16),
              AppButton(
                width: MediaQuery.of(context).size.width > 600 ? 410.0 - 12 : MediaQuery.of(context).size.width - 12,
                child: const Text('Add', style: TextStyle(fontSize: 20)),
                onTap: () {},
              ),
            ],
          ),
        );
      }),
    );
  }
}
