import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/theme.dart';
import '../providers/presence_provider.dart';

class StudentPage extends StatefulWidget {
  final String kelasId, kelas;
  const StudentPage({
    super.key,
    required this.kelasId,
    required this.kelas,
  });

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  Future<void> getData(String kelasId) async {
    Provider.of<PresenceProvider>(
      context,
      listen: false,
    ).getPresence(kelasId);
  }

  navigate() {
    Navigator.of(context).pop();
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

  verify(
    Function() onPressed,
    String title,
  ) {
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
                    "$title?",
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Batal",
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
                      onPressed: onPressed,
                      child: Text(
                        title,
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData(widget.kelasId);
    });

    return Consumer<PresenceProvider>(
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
              "Daftar Absensi ${widget.kelas}",
              style: secondaryTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: value.presence.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final presensi = value.presence[index];

                return value.presence.isNotEmpty
                    ? ListTile(
                        title: Text(
                          "${presensi.name.toString()} | ${presensi.tipePresensi.toString()}",
                          overflow: TextOverflow.ellipsis,
                          style: secondaryTextStyle.copyWith(
                            color: grey400,
                          ),
                        ),
                        subtitle: Text(
                          "${formatWaktu(false, tanggal: DateTime.parse(presensi.waktuMasuk.toString()))} | ${presensi.statusVerifikasi.toString()}",
                          overflow: TextOverflow.ellipsis,
                          style: secondaryTextStyle,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                verify(
                                  () async {
                                    if (await value.verifyPresence(
                                        presensi.id.toString(),
                                        "Tidak diverifikasi")) {
                                      showSnackBar(
                                        "Berhasil verifikasi",
                                        Colors.green,
                                      );

                                      navigate();
                                      getData(widget.kelasId);
                                    } else {
                                      showSnackBar(
                                        "Gagal verifikasi",
                                        Colors.red,
                                      );
                                    }
                                  },
                                  "Jangan verifikasi",
                                );
                              },
                              child: const Icon(
                                Icons.disabled_by_default_rounded,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                verify(
                                  () async {
                                    if (await value.verifyPresence(
                                        presensi.id.toString(),
                                        "Sudah verifikasi")) {
                                      showSnackBar(
                                        "Berhasil verifikasi",
                                        Colors.green,
                                      );

                                      navigate();
                                      getData(widget.kelasId);
                                    } else {
                                      showSnackBar(
                                        "Gagal verifikasi",
                                        Colors.red,
                                      );
                                    }
                                  },
                                  "Verifikasi",
                                );
                              },
                              child: Icon(
                                Icons.check_box,
                                color: primaryColor,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: height(context) * 0.3),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.archive_rounded,
                                color: primaryColor,
                                size: height(context) * 0.1,
                              ),
                              Text(
                                "Data absensi belum masuk",
                                style: secondaryTextStyle,
                              ),
                            ],
                          ),
                        ),
                      );
              },
            ),
          ),
        );
      },
    );
  }
}
