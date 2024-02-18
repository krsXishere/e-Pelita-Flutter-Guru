import 'dart:ui';
import 'package:e_pelita_guru/widgets/custom_auth_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/theme.dart';

class VerifyAccountPage extends StatefulWidget {
  final String email;
  const VerifyAccountPage({super.key, required this.email,});

  @override
  State<VerifyAccountPage> createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage> {
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    emailController.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: white,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: black,
              ),
            ),
            centerTitle: true,
            title: Text(
              "Verifikasi Akun",
              style: secondaryTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      border: Border.all(
                        color: primaryColor,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 2.0,
                          sigmaY: 2.0,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Verifikasi email kamu yuk!",
                                style: secondaryTextStyle,
                              ),
                              Text(
                                "Ajukan verifikasi email biar akun kamu bisa dapetin centang hijau loh",
                                textAlign: TextAlign.left,
                                style: secondaryTextStyle.copyWith(
                                  color: grey400,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Container(
                    color: white,
                    child: TextFormField(
                      enabled: false,
                      style: secondaryTextStyle.copyWith(
                        color: grey400,
                      ),
                      cursorColor: primaryColor,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        filled: true,
                        fillColor: white,
                        border: InputBorder.none,
                        hintText: "",
                        hintStyle: primaryTextStyle.copyWith(
                          fontWeight: regular,
                          color: grey400,
                          fontSize: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: grey400,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  CustomAuthButtonWidget(
                    text: "Ajukan Sekarang!",
                    color: primaryColor,
                    isLoading: false,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
