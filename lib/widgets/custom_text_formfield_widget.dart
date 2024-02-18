import 'package:flutter/material.dart';
import '../common/theme.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final bool isPasswordField;
  final TextEditingController controller;
  final bool isObsecure;
  final Function() onTap;
  final bool isNumber;
  final TextInputType type;

  const CustomTextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.isPasswordField,
    required this.controller,
    this.isObsecure = false,
    required this.onTap,
    this.isNumber = false,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return isPasswordField == false
        ? TextFormField(
          style: secondaryTextStyle,
          cursorColor: primaryColor,
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            filled: false,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: primaryTextStyle.copyWith(
              fontWeight: regular,
              color: grey400,
              fontSize: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: grey500,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide(
                color: primaryColor,
              ),
            ),
          ),
        )
        : TextFormField(
          style: secondaryTextStyle,
          cursorColor: primaryColor,
          controller: controller,
          keyboardType: type,
          obscureText: isObsecure,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: onTap,
              child: Icon(
                isObsecure ? Icons.visibility_off : Icons.visibility,
                color: isObsecure ? grey500 : primaryColor,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            filled: false,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: primaryTextStyle.copyWith(
              fontWeight: regular,
              color: grey400,
              fontSize: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: grey500,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide(
                color: primaryColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide.none,
            ),
          ),
        );
  }
}
