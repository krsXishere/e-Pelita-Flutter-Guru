import 'package:e_pelita_guru/common/theme.dart';
import 'package:flutter/material.dart';

class PoweredByWidget extends StatelessWidget {
  const PoweredByWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !keyboardIsOpen(context),
      child: Container(
        decoration: BoxDecoration(color: white),
        height: 45,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Powered by:",
              style: primaryTextStyle.copyWith(
                color: grey400,
                fontSize: 12,
              ),
            ),
            Text(
              "Rahadian Suntara",
              style: secondaryTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
