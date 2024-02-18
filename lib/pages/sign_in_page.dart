import 'package:e_pelita_guru/common/theme.dart';
import 'package:e_pelita_guru/pages/sign_up_page.dart';
import 'package:e_pelita_guru/providers/auth_provider.dart';
import 'package:e_pelita_guru/widgets/custom_auth_button_widget.dart';
import 'package:e_pelita_guru/widgets/custom_text_formfield_widget.dart';
import 'package:e_pelita_guru/widgets/navigation_bar_widget.dart';
import 'package:e_pelita_guru/widgets/powered_by_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button_question_auth_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  navigate() {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: const NavigationBarWidget(),
        type: PageTransitionType.rightToLeft,
      ),
      (Route<dynamic> route) => false,
    );
  }

  showSnackBar(
    String message,
    Color color,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          message,
          style: primaryTextStyle.copyWith(
            color: white,
          ),
        ),
      ),
    );
  }

  masuk(AuthProvider value) async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      if (await value.signIn(emailController.text, passwordController.text)) {
        navigate();
      } else {
        showSnackBar(
          value.userModel?.message ?? "Error",
          Colors.red,
        );
      }
    } else {
      showSnackBar(
        "Isi semua data",
        Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height(context) * 0.1,
                    ),
                    Text(
                      "Masuk",
                      style: secondaryTextStyle.copyWith(
                        fontSize: 30,
                        fontWeight: bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Selamat datang kembali!\nMasuk untuk melanjutkan",
                      style: secondaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomTextFormFieldWidget(
                      hintText: "Email anda",
                      isPasswordField: false,
                      type: TextInputType.emailAddress,
                      controller: emailController,
                      onTap: () {},
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    CustomTextFormFieldWidget(
                      hintText: "Kata sandi anda",
                      isPasswordField: true,
                      type: TextInputType.text,
                      controller: passwordController,
                      isObsecure: value.isObsecure,
                      onTap: () {
                        value.checkObsecure();
                      },
                    ),
                    // SizedBox(
                    //   height: defaultPadding,
                    // ),
                    // Center(
                    //   child: Text(
                    //     "Lupa kata sandi",
                    //     style: primaryTextStyle.copyWith(
                    //       color: primaryColor,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomAuthButtonWidget(
                      text: "Masuk",
                      color: primaryColor,
                      isLoading: value.isLoading,
                      onPressed: () {
                        masuk(value);
                      },
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    const CustomButtonQuestionAuthWidget(
                      question: "Belum punya akun?",
                      buttonText: "Daftar",
                      page: SignUpPage(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: const PoweredByWidget(),
        );
      },
    );
  }
}
