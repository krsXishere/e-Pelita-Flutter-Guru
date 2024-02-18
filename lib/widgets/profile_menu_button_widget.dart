import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../common/theme.dart';
import 'edupelita_text_widget.dart';

class ProfileMenuButtonWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSignOut;
  final bool isEduPelita;
  final bool isCustomerService;
  final Function() onTap;

  const ProfileMenuButtonWidget({
    super.key,
    required this.icon,
    required this.title,
    this.isEduPelita = false,
    this.isSignOut = false,
    this.isCustomerService = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: defaultPadding),
      minLeadingWidth: 5,
      leading: isEduPelita == false && isCustomerService == false
          ? Icon(
              icon,
              color: isSignOut == false ? black : Colors.red,
              size: 20,
            )
          : isCustomerService == false && isEduPelita == true
              ? SizedBox(
                  height: 25,
                  child: SvgPicture.asset(
                    "assets/svg/sion-edupelita-care.svg",
                    fit: BoxFit.cover,
                  ),
                )
              : SizedBox(
                  height: 20,
                  width: 20,
                  child: SvgPicture.asset(
                    "assets/svg/customer-service.svg",
                    color: black,
                    fit: BoxFit.cover,
                  ),
                ),
      title: isEduPelita == false
          ? Text(
              title,
              style: primaryTextStyle.copyWith(
                color: isSignOut == false ? black : Colors.red,
                fontSize: 14,
              ),
            )
          : Row(
              children: [
                const EduPelitaTextWidget(size: 14),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "care",
                  style: eduPelitaTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
      onTap: onTap,
    );
  }
}
