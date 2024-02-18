import 'dart:async';
import 'dart:ui';
import 'package:after_layout/after_layout.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_pelita_guru/widgets/custom_auth_button_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../common/theme.dart';
import '../providers/edupelita_care_provider.dart';
import '../services/notification_service.dart';
import '../widgets/edupelita_text_widget.dart';
import '../widgets/supported_by_disdik_widget.dart';

class EduPelitaCarePage extends StatefulWidget {
  const EduPelitaCarePage({super.key});

  @override
  State<EduPelitaCarePage> createState() => _EduPelitaCarePageState();
}

class _EduPelitaCarePageState extends State<EduPelitaCarePage>
    with AfterLayoutMixin<EduPelitaCarePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  EduPelitaCareProvider? eduPelitaCareProvider;
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  NotificationService notificationService = NotificationService();

  Future<void> pickFile(EduPelitaCareProvider value) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'png',
        'jpg',
        'jpeg',
        'mp4',
        'mp3',
      ],
    );
    if (result != null) {
      value.checkFilePicked(result);
    }
  }

  movePage() {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    eduPelitaCareProvider = Provider.of<EduPelitaCareProvider>(
      context,
      listen: false,
    );
    // print(eduPelitaCareProvider!.image);
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (eduPelitaCareProvider != null) {
      eduPelitaCareProvider!.deleteFilePicked();
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
    return Consumer<EduPelitaCareProvider>(
      builder: (context, value, child) {
        return Scaffold(
          key: _scaffoldKey,
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
              "e-Pelita Care",
              style: secondaryTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: const Alignment(-5.0, 0.0),
                  child: SizedBox(
                    height: height(context) * 0.9,
                    width: width(context) * 0.9,
                    child: SvgPicture.asset(
                      "assets/svg/sion-welcome.svg",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height(context) * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height(context) * 0.1,
                              width: width(context) * 0.3,
                              child: SvgPicture.asset(
                                "assets/svg/sion-edupelita-care.svg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            const EduPelitaTextWidget(size: 20),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "care",
                              style: eduPelitaTextStyle.copyWith(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height(context) * 0.05,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: white.withOpacity(0.5),
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                            border: Border.all(
                              color: primaryColor,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
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
                                      "Sampaikan keluhan anda ke Dinas Pendidikan",
                                      style: secondaryTextStyle,
                                    ),
                                    Text(
                                      "Isi form di bawah ini agar kami bisa segera\nmeninjaunya",
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
                        input(
                          context,
                          value,
                        ),
                        SizedBox(
                          height: defaultPadding,
                        ),
                        Container(
                          padding: EdgeInsets.all(defaultPadding),
                          height: height(context) * 0.4,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(defaultPadding),
                            boxShadow: [
                              primaryShadow,
                            ],
                          ),
                          child: DottedBorder(
                            dashPattern: const [
                              10,
                              5,
                            ],
                            color: primaryColor,
                            strokeCap: StrokeCap.round,
                            child: value.filePicked != null
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          value.filePicked!.names.toString(),
                                          style: primaryTextStyle.copyWith(
                                            color: primaryColor,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            value.deleteFilePicked();
                                          },
                                          icon: Icon(
                                            Icons.delete_rounded,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      pickFile(value);
                                    },
                                    child: SizedBox(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.file_present_rounded,
                                              color: primaryColor,
                                              size: 30,
                                            ),
                                            Text(
                                              "Tambahkan bukti\n(opsional)",
                                              style: secondaryTextStyle,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: defaultPadding,
                        ),
                        CustomAuthButtonWidget(
                          text: "Kirim Sekarang!",
                          color: primaryColor,
                          isLoading: value.isLoading,
                          onPressed: () async {
                            if (value.kategoriPengaduan != "" &&
                                descriptionController.text.isNotEmpty) {
                              // value.checkFile(value)
                              if (await value.pengaduan(
                                value.kategoriPengaduan,
                                descriptionController.text,
                                value.filePicked,
                              )) {
                                showSnackBar(
                                  "Berhasil mengirim aduan.",
                                  Colors.green,
                                );

                                notificationService.showNotification(
                                  id: 3,
                                  title: "Pengaduan Berhasil",
                                  body: "Pengaduan akan segera kami tinjau.",
                                );

                                value.deleteFilePicked();
                                value.updateKategoriPengaduan("");
                                descriptionController.text = "";

                                // movePage();
                              } else {
                                showSnackBar(
                                  "Gagal mengirim aduan.",
                                  Colors.red,
                                );

                                notificationService.showNotification(
                                  id: 3,
                                  title: "Pengaduan Gagal",
                                  body:
                                      "Pengaduan kamu belum terkirim coba lagi nanti ya.",
                                );
                              }
                            } else {
                              showSnackBar(
                                "Isi semua data.",
                                Colors.red,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: height(context) * 0.1,
                        ),
                        const SupportedByDisdikWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget input(
    BuildContext context,
    EduPelitaCareProvider value,
  ) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      child: Column(
        children: [
          DropdownButtonFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              filled: true,
              fillColor: white,
              border: InputBorder.none,
              hintText: "Pilih bentuk file bukti di sini",
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
            items: [
              "Kekerasan Fisik",
              "Kekerasan Psikis",
              "Perundungan",
              "Kekerasan Seksual",
              "Diskriminasi dan Intoleransi",
              "Pungli (Pungutan Liar)",
              "Bentuk Kekerasan Lainnya",
            ]
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
              // print(valueEnd);
              value.updateKategoriPengaduan(valueEnd!);
              // print(value.kategoriPengaduan);
            },
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
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
              ),
              cursorColor: primaryColor,
              controller: descriptionController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                filled: true,
                fillColor: white,
                border: InputBorder.none,
                hintText: "Deskripsikan aduan anda",
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
