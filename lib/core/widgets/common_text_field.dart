// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:donezo/config/theme/app_color.dart';

class CommonTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final bool isValid;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  const CommonTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    this.isValid = true,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    log('CommonTextField build');
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.isValid ? Colors.black : AppColor.redInvalid,
          width: 1.3,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.isValid ? Colors.black : AppColor.redInvalid,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        keyboardType: widget.keyboardType ?? TextInputType.text,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        onEditingComplete: widget.onEditingComplete,
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
        controller: widget.controller,
        obscureText: widget.obscureText ? !showPassword : false,
        decoration: InputDecoration(
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: AppColor.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                )
              : null,
          fillColor: Colors.white,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: widget.isValid ? AppColor.greyText : AppColor.redInvalid,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.only(left: 12),
        ),
      ),
    );
  }
}
