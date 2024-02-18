import 'dart:async';
import 'dart:io';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../common/theme.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_listile_widget.dart';

class UpdateAccountInformationsPage extends StatefulWidget {
  const UpdateAccountInformationsPage({super.key});

  @override
  State<UpdateAccountInformationsPage> createState() =>
      _UpdateAccountInformationsPageState();
}

class _UpdateAccountInformationsPageState
    extends State<UpdateAccountInformationsPage>
    with AfterLayoutMixin<UpdateAccountInformationsPage> {
  UserProvider? userProvider;

  // movePage() {
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     PageTransition(
  //       child: const NavigationBarWidget(),
  //       type: PageTransitionType.rightToLeft,
  //     ),
  //     (Route<dynamic> route) => false,
  //   );
  // }

  Future<void> getImage(
    UserProvider value2,
    bool isGallery,
  ) async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
      source: isGallery ? ImageSource.gallery : ImageSource.camera,
    );
    File file = File(image!.path);
    value2.checkFile(file);
  }

  @override
  void initState() {
    userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    if (userProvider != null) {
      userProvider!.deleteFile();
    }
    // throw UnimplementedError();
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

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, UserProvider>(
      builder: (context, value, value2, child) {
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
              "Ubah Profil",
              style: secondaryTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: defaultPadding,
              ),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  SizedBox(
                    child: Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            onBackgroundImageError: (exception, stackTrace) {},
                            backgroundColor: primaryColor,
                            backgroundImage:
                                NetworkImage(value.userModel!.image.toString()),
                            // backgroundImage: const AssetImage("assets/png/tutwuri-handayani-logo.png"),
                            child: value.userModel?.image != ""
                                ? Icon(
                                    Icons.person,
                                    size: 50,
                                    color: white,
                                  )
                                : const SizedBox.shrink(),
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                      defaultBorderRadius,
                                    ),
                                  ),
                                ),
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: height(context) * 0.25,
                                    decoration: BoxDecoration(
                                      color: white,
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Container(
                                            height: 5,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: defaultPadding,
                                            ),
                                            Text(
                                              "Pilih foto",
                                              style:
                                                  secondaryTextStyle.copyWith(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.01,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.all(defaultPadding),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: width(context) * 0.35,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        primaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        defaultBorderRadius,
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    getImage(
                                                      value2,
                                                      true,
                                                    ).then((value) async {
                                                      if (value2.file != null) {
                                                        if (await value2
                                                            .addProfilePicure(
                                                                value2.file!)) {
                                                          showSnackBar(
                                                            "Berhasil upload foto profil",
                                                            Colors.green,
                                                          );
                                                        } else {
                                                          showSnackBar(
                                                            "Gagal upload foto profil",
                                                            Colors.red,
                                                          );

                                                          value2.deleteFile();
                                                        }
                                                      } else {
                                                        showSnackBar(
                                                          "Batal upload foto profil",
                                                          Colors.red,
                                                        );

                                                        value2.deleteFile();
                                                      }
                                                    });
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Galeri",
                                                        style: primaryTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        Icons.photo_rounded,
                                                        color: white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width(context) * 0.35,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        primaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        defaultBorderRadius,
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Kamera",
                                                        style: primaryTextStyle,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .photo_camera_rounded,
                                                        color: white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Ubah Foto Profil",
                              style: primaryTextStyle.copyWith(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Divider(
                    color: black,
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  changeField(
                    context,
                    value,
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget changeField(
    BuildContext context,
    UserProvider value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Info Profil",
          style: secondaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: bold,
          ),
        ),
        CustomListTileWidget(
          title: "Nama",
          subtitle: value.userModel?.name ?? "Disdik Sumedang",
          isEnable: false,
          onTap: () {},
        ),
        CustomListTileWidget(
          title: "Email",
          subtitle: value.userModel?.email ?? "disdik@gmail.com.com",
          onTap: () {},
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Divider(
          color: black,
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Text(
          "Info Pribadi",
          style: secondaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: bold,
          ),
        ),
        // CustomListTileWidget(
        //   title: "NISN",
        //   subtitle: value.userModel?.nisn ?? "",
        //   isEnable: false,
        //   onTap: () {},
        // ),
        // CustomListTileWidget(
        //   title: "NIS",
        //   subtitle: value.userModel?.nis ?? "",
        //   isEnable: false,
        //   onTap: () {},
        // ),
        // CustomListTileWidget(
        //   title: "Sekolah",
        //   subtitle: value.userModel?.sekolah ?? "",
        //   isEnable: false,
        //   onTap: () {},
        // ),
        // CustomListTileWidget(
        //   title: "Kelas",
        //   subtitle: value.userModel?.kelas ?? "",
        //   isEnable: false,
        //   onTap: () {},
        // ),
        // CustomListTileWidget(
        //   title: "Alamat",
        //   subtitle: value.userModel?.alamat ?? "",
        //   onTap: () {},
        // ),
        // CustomListTileWidget(
        //   title: "No. WhatsApp Siswa",
        //   subtitle: value.userModel?.noWASiswa ?? "",
        //   onTap: () {},
        // ),
        // CustomListTileWidget(
        //   title: "No. WhatsApp Orang Tua/Wali",
        //   subtitle: value.userModel?.noWAOrtu ?? "",
        //   onTap: () {},
        // ),
      ],
    );
  }
}
