import 'package:e_pelita_guru/pages/update_account_informations_page.dart';
import 'package:e_pelita_guru/pages/verify_account_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../common/theme.dart';
import '../providers/user_provider.dart';
import '../widgets/edupelita_text_widget.dart';
import '../widgets/profile_menu_button_widget.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
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
              "Akun Saya",
              style: secondaryTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CircleAvatar(
                            onBackgroundImageError: (exception, stackTrace) {},
                            backgroundColor: primaryColor,
                            backgroundImage:
                                NetworkImage(value.userModel!.image.toString()),
                            // backgroundImage: const AssetImage("assets/png/tutwuri-handayani-logo.png"),
                            child: value.userModel?.image != ""
                                ? Icon(
                                    Icons.person,
                                    size: 30,
                                    color: white,
                                  )
                                : const SizedBox.shrink(),
                          ),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.userModel!.name.toString(),
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: bold,
                                ),
                              ),
                              SizedBox(
                                width: width(context) * 0.45,
                                child: Text(
                                  value.userModel!.email.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: secondaryTextStyle.copyWith(
                                    fontSize: 12,
                                    color: grey400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageTransition(
                              child: const UpdateAccountInformationsPage(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          );
                        },
                        child: Icon(
                          Icons.edit_rounded,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                  // input(context),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    "Pengaturan Akun",
                    style: secondaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  ProfileMenuButtonWidget(
                    icon: Icons.verified_rounded,
                    title: "Verifikasi akun",
                    onTap: () {
                      Navigator.of(context).push(
                        PageTransition(
                          child: VerifyAccountPage(
                            email: value.userModel?.email ?? "",
                          ),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    },
                  ),
                  ProfileMenuButtonWidget(
                    icon: Icons.lock_rounded,
                    title: "Keamanan akun",
                    onTap: () {},
                  ),
                  ProfileMenuButtonWidget(
                    icon: Icons.health_and_safety_rounded,
                    title: "Privasi",
                    onTap: () {},
                  ),
                  Row(
                    children: [
                      const EduPelitaTextWidget(size: 16),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "care",
                        style: eduPelitaTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  ProfileMenuButtonWidget(
                    icon: Icons.history_rounded,
                    title: "Riwayat Pengaduan",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget input(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      child: Column(
        children: [
          TextFormField(
            style: secondaryTextStyle,
            cursorColor: primaryColor,
            // controller: aboutController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              filled: true,
              fillColor: white,
              border: InputBorder.none,
              hintText: "Hal yang mau disampaikan",
              hintStyle: primaryTextStyle.copyWith(
                fontWeight: regular,
                color: grey400,
                fontSize: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: white,
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
          SizedBox(
            height: defaultPadding,
          ),
          SizedBox(
            height: height(context) * 0.1,
            child: TextFormField(
              expands: true,
              maxLines: null,
              minLines: null,
              style: secondaryTextStyle,
              cursorColor: primaryColor,
              // controller: descriptionController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                filled: true,
                fillColor: white,
                border: InputBorder.none,
                hintText: "Ceritain lengkapnya dong...",
                hintStyle: primaryTextStyle.copyWith(
                  fontWeight: regular,
                  color: grey400,
                  fontSize: 12,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
