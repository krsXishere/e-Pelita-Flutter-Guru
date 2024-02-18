import 'package:e_pelita_guru/pages/sign_in_page.dart';
import 'package:e_pelita_guru/providers/sekolah_provider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../common/theme.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_auth_button_widget.dart';
import '../widgets/custom_button_question_auth_widget.dart';
import '../widgets/custom_text_formfield_widget.dart';
import '../widgets/navigation_bar_widget.dart';
import '../widgets/powered_by_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nipController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationPasswordController =
      TextEditingController();
  TextEditingController mataPelajaranController = TextEditingController();
  TextEditingController noWAController = TextEditingController();

  movePage(
    BuildContext context,
    int index,
  ) {
    AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    authProvider.checkIndex(index);
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

  daftar(AuthProvider value) async {
    if (await value.signUp(
      nipController.text,
      nameController.text,
      emailController.text,
      passwordController.text,
      mataPelajaranController.text,
      noWAController.text,
      value.sekolahId,
    )) {
      navigate();
    } else {
      showSnackBar(
        "Gagal daftar\nError ${value.userModel?.status ?? ""}",
        Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, SekolahProvider>(
      builder: (context, value, value2, child) {
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
                      "Daftar",
                      style: secondaryTextStyle.copyWith(
                        fontSize: 30,
                        fontWeight: bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Buat akun untuk memulai!",
                      style: secondaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    AnimatedSwitcher(
                      switchInCurve: Curves.easeInOutQuart,
                      switchOutCurve: Curves.easeInOutQuart,
                      duration: const Duration(milliseconds: 500),
                      child: value.indexWidget == 0
                          ? inputWidget1(
                              context,
                              value,
                            )
                          : inputWidget2(
                              context,
                              value,
                              value2,
                            ),
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    const CustomButtonQuestionAuthWidget(
                      question: "Sudah punya akun?",
                      buttonText: "Masuk",
                      page: SignInPage(),
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

  Widget inputWidget1(
    BuildContext context,
    AuthProvider value,
  ) {
    checkInputWidget1() {
      if (nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmationPasswordController.text.isNotEmpty) {
        if (passwordController.text == confirmationPasswordController.text) {
          movePage(context, 1);
        } else {
          showSnackBar(
            "Kata sandi harus sama",
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

    return Column(
      key: const Key("inputWidget1"),
      children: [
        CustomTextFormFieldWidget(
          hintText: "Nama anda",
          isPasswordField: false,
          controller: nameController,
          type: TextInputType.text,
          onTap: () {},
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
        SizedBox(
          height: defaultPadding,
        ),
        CustomTextFormFieldWidget(
          hintText: "Konfirmasi kata sandi anda",
          isPasswordField: true,
          type: TextInputType.text,
          controller: confirmationPasswordController,
          isObsecure: value.isObsecureConfirmation,
          onTap: () {
            value.checkObsecureConfirmation();
          },
        ),
        const SizedBox(
          height: 40,
        ),
        CustomAuthButtonWidget(
          text: "Selanjutnya",
          color: primaryColor,
          isLoading: value.isLoading,
          onPressed: checkInputWidget1,
        ),
      ],
    );
  }

  Widget inputWidget2(
    BuildContext context,
    AuthProvider value,
    SekolahProvider value2,
  ) {
    checkInputWidget2() {
      if (nipController.text.isNotEmpty &&
          mataPelajaranController.text.isNotEmpty &&
          noWAController.text.isNotEmpty &&
          value.sekolahId != "0") {
        daftar(value);
      } else {
        showSnackBar(
          "Isi semua data",
          Colors.red,
        );
      }
    }

    return Column(
      key: const Key("inputWidget2"),
      children: [
        SizedBox(
          height: defaultPadding,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                movePage(
                  context,
                  0,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: defaultPadding,
        ),
        CustomTextFormFieldWidget(
          hintText: "NIP/NUPTK anda",
          isPasswordField: false,
          type: TextInputType.number,
          controller: nipController,
          onTap: () {},
        ),
        SizedBox(
          height: defaultPadding,
        ),
        CustomTextFormFieldWidget(
          hintText: "Mata pelajaran",
          isPasswordField: false,
          type: TextInputType.text,
          controller: mataPelajaranController,
          onTap: () {},
        ),
        SizedBox(
          height: defaultPadding,
        ),
        CustomTextFormFieldWidget(
          hintText: "No. WhatsApp",
          isPasswordField: false,
          type: TextInputType.number,
          controller: noWAController,
          isNumber: true,
          onTap: () {},
        ),
        SizedBox(
          height: defaultPadding,
        ),
        DropdownButtonFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            filled: false,
            border: InputBorder.none,
            hintText: "Pilih sekolah kamu di sini",
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
          items: ["SMP 3"]
              .map(
                (object) => DropdownMenuItem<String>(
                  value: object,
                  child: Text(
                    object,
                    style: secondaryTextStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (valueEnd) {
            // value.checkSekolahId(value2.)
            final selectedSekolah = value2.sekolahs.firstWhere(
              (element) => element.namaSekolah == valueEnd,
            );

            // ignore: unnecessary_null_comparison
            if (selectedSekolah != null) {
              String selectedSekolahId = selectedSekolah.id.toString();

              Provider.of<AuthProvider>(
                context,
                listen: false,
              ).checkSekolahId(selectedSekolahId);

              // print("EUY: ${value.sekolahId}");
            } else {
              // print('Tidak ada sekolah yang dipilih');
            }
          },
        ),
        const SizedBox(
          height: 40,
        ),
        CustomAuthButtonWidget(
          text: "Daftar",
          color: primaryColor,
          isLoading: value.isLoading,
          onPressed: checkInputWidget2,
        ),
      ],
    );
  }
}
