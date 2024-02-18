import 'package:flutter/material.dart';
import '../common/theme.dart';

class SupportedByDisdikWidget extends StatelessWidget {
  const SupportedByDisdikWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Supported by:",
          style: primaryTextStyle.copyWith(
            color: grey400,
            fontSize: 12,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(
                "assets/png/tutwuri-handayani-logo.png",
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  "DISDIK",
                  style: secondaryTextStyle,
                ),
                Text(
                  "Kab. Sumedang",
                  style: secondaryTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Dr. Dian Sukmara, M.Pd",
          textAlign: TextAlign.center,
          style: secondaryTextStyle.copyWith(
            fontSize: 12,
          ),
        ),
        Text(
          "Dadang Sudanta, S.Pd., M.MPd",
          textAlign: TextAlign.center,
          style: secondaryTextStyle.copyWith(
            fontSize: 12,
          ),
        ),
        SizedBox(
          height: height(context) * 0.05,
        ),
      ],
    );
  }
}
