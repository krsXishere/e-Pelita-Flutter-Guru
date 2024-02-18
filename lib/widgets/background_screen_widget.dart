import 'package:flutter/material.dart';
import '../common/theme.dart';

class BackgroundScreenWidget extends StatelessWidget {
  final bool isRounded;
  
  const BackgroundScreenWidget({
    super.key,
    this.isRounded = false,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          height: height * 0.3,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: isRounded == false
                ? BorderRadius.zero
                : BorderRadius.vertical(
                    bottom: Radius.circular(
                      defaultBorderRadius,
                    ),
                  ),
          ),
        ),
        Container(
          height: height * 0.36,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: white,
          ),
        ),
      ],
    );
  }
}
