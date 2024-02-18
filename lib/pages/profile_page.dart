import 'package:e_pelita_guru/pages/sign_in_page.dart';
import 'package:e_pelita_guru/pages/terms_condition_privacy_policy_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/theme.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/background_screen_widget.dart';
import '../widgets/profile_menu_button_widget.dart';
import 'account_settings_page.dart';
import 'edupelita_care_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  navigate() {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: const SignInPage(),
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

  signOut(AuthProvider value2) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(defaultBorderRadius),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: white,
          ),
          height: height(context) * 0.3,
          child: Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Center(
                  child: Text(
                    "Keluar dari akun?",
                    style: secondaryTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                        ),
                      ),
                      onPressed: () async {
                        if (await value2.signOut()) {
                          navigate();
                        } else {
                          showSnackBar(
                            "Gagal keluar",
                            Colors.red,
                          );
                        }
                      },
                      child: value2.isLoading == true
                          ? CupertinoActivityIndicator(
                              color: white,
                            )
                          : Text(
                              "Keluar",
                              style: primaryTextStyle,
                            ),
                    ),
                    SizedBox(
                      width: defaultPadding,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Batal",
                        style: primaryTextStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, AuthProvider>(
      builder: (context, value, value2, child) {
        return Scaffold(
          backgroundColor: white,
          body: Stack(
            children: [
              const BackgroundScreenWidget(
                isRounded: true,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height(context) * 0.33,
                      ),
                      ...listProfileMenuButton(
                        context,
                        value2,
                      ),
                      SizedBox(
                        height: height(context) * 0.15,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: height(context) * 0.3,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(
                      defaultBorderRadius,
                    ),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: width(context) * 0.1,
                          onBackgroundImageError: (exception, stackTrace) {},
                          backgroundColor: white,
                          backgroundImage:
                              NetworkImage(value.userModel!.image.toString()),
                          // backgroundImage: const AssetImage("assets/png/tutwuri-handayani-logo.png"),
                          child: value.userModel?.image != ""
                              ? Icon(
                                  Icons.person,
                                  size: 50,
                                  color: primaryColor,
                                )
                              : const SizedBox.shrink(),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          value.userModel!.name.toString(),
                          // "Disdik Sumedang",
                          style: primaryTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: width(context) * 0.35,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                          ),
                          child: value.userModel?.emailVerifiedAt != null
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.verified_rounded,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    Text(
                                      "Terverifikasi",
                                      style: primaryTextStyle.copyWith(
                                        color: Colors.green,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Text(
                                    "Belum verifikasi",
                                    style: primaryTextStyle.copyWith(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> listProfileMenuButton(
    BuildContext context,
    AuthProvider value2,
  ) {
    return [
      ProfileMenuButtonWidget(
        icon: Icons.health_and_safety_rounded,
        title: "EduPelita Care",
        isEduPelita: true,
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
              child: const EduPelitaCarePage(),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
      ),
      ProfileMenuButtonWidget(
        icon: Icons.settings_rounded,
        title: "Pengaturan akun",
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
              child: const AccountSettingsPage(),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
      ),
      ProfileMenuButtonWidget(
        icon: Icons.list_alt_rounded,
        title: "Syarat dan ketentuan, dan Kebijakan privasi",
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
              child: const TermsConditionPrivacyPolicyPage(),
              type: PageTransitionType.rightToLeft,
            ),
          );
        },
      ),
      ProfileMenuButtonWidget(
        icon: Icons.person,
        isCustomerService: true,
        title: "Customer Service",
        onTap: () {
          _launchUrl("https://wa.me/6281321330331");
        },
      ),
      Divider(
        color: black,
      ),
      SizedBox(
        height: defaultPadding,
      ),
      ProfileMenuButtonWidget(
        icon: Icons.logout,
        title: "Keluar",
        isSignOut: true,
        onTap: () {
          signOut(value2);
        },
      ),
    ];
  }
}
