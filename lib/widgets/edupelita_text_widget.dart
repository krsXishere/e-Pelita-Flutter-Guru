import 'package:flutter/material.dart';
import '../common/theme.dart';

class EduPelitaTextWidget extends StatefulWidget {
  final double size;
  const EduPelitaTextWidget({
    super.key,
    required this.size,
  });

  @override
  State<EduPelitaTextWidget> createState() => _EduPelitaTextWidgetState();
}

class _EduPelitaTextWidgetState extends State<EduPelitaTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "e-",
          style: eduPelitaTextStyle.copyWith(
            color: Colors.red,
            fontSize: widget.size,
          ),
        ),
        Text(
          "pelita",
          style: eduPelitaTextStyle.copyWith(
            color: primaryColor,
            fontSize: widget.size,
          ),
        ),
      ],
    );
  }
}
