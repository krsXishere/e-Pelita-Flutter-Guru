import 'package:flutter/material.dart';
import '../common/theme.dart';

class CustomListTileWidget extends StatelessWidget {
  final String title, subtitle;
  final bool isEnable;
  final Function() onTap;

  const CustomListTileWidget({
    super.key,
    required this.title,
    this.subtitle = "",
    this.isEnable = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: secondaryTextStyle.copyWith(
          color: grey400,
        ),
      ),
      subtitle: Text(
        subtitle,
        overflow: TextOverflow.ellipsis,
        style: secondaryTextStyle,
      ),
      trailing: Visibility(
        visible: isEnable,
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: black,
          size: 15,
        ),
      ),
    );
  }
}
