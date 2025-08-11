import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.onChanged,
    required this.text,
    this.textInputAction,
  });

  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String text;
  final TextInputAction? textInputAction;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hintColor = Colors.grey.shade500;
    final enabledBorderColor = Colors.lightBlue.shade100;
    final focusedBorderColor = Colors.lightBlue.shade300;
    final errorColor = theme.colorScheme.error;

    final outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: enabledBorderColor, width: 1.5.w),
    );

    final focusedOutlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: focusedBorderColor, width: 2.0.w),
    );

    return TextField(
      textAlign: TextAlign.center,
      onChanged: widget.onChanged,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: focusedOutlineInputBorder,
        errorBorder: outlineInputBorder.copyWith(
          borderSide: BorderSide(color: errorColor, width: 1.5.w),
        ),
        focusedErrorBorder: outlineInputBorder.copyWith(
          borderSide: BorderSide(color: errorColor, width: 2.0.w),
        ),
        isDense: true,
        hintText: widget.text,
        hintStyle: TextStyle(color: hintColor),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      ),
      style: TextStyle(color: Colors.black, fontSize: 18.sp),
      cursorColor: Colors.black,
    );
  }
}
