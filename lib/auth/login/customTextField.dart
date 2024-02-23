import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app1/theme/AppTheme.dart';

typedef myValidator = String? Function(String?);

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.validator,
      this.keybaordType = TextInputType.text});
  String hintText;
  TextInputType keybaordType;
  myValidator validator;

  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      style: TextStyle(
        color: AppTheme.blackColor,
      ),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          filled: true,
          fillColor: AppTheme.greyColor.withOpacity(0.6),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppTheme.redColor),
              borderRadius: BorderRadius.circular(25)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppTheme.redColor),
              borderRadius: BorderRadius.circular(25)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppTheme.blackColor),
              borderRadius: BorderRadius.circular(25)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: AppTheme.blackColor),
              borderRadius: BorderRadius.circular(25))),
      controller: controller,
    );
  }
}
