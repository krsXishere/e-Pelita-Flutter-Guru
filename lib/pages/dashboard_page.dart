import 'dart:ui';
import 'package:e_pelita_guru/common/theme.dart';
import 'package:e_pelita_guru/pages/student_page.dart';
import 'package:e_pelita_guru/providers/auth_provider.dart';
import 'package:e_pelita_guru/providers/kelas_provider.dart';
import 'package:e_pelita_guru/widgets/custom_listile_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<void> getData() async {
    Provider.of<UserProvider>(
      context,
      listen: false,
    ).getGuru();

    Provider.of<KelasProvider>(
      context,
      listen: false,
    ).getKelas();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });

    return Consumer3<AuthProvider, UserProvider, KelasProvider>(
      builder: (context, value, value2, value3, child) {
        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: getData,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(defaultPadding),
                            ),
                          ),
                          child: Text(
                            "Selamat datang, ${cuttedName(value2.userModel?.name ?? " ")}",
                            style: primaryTextStyle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: defaultPadding),
                          child: CircleAvatar(
                            onBackgroundImageError: (exception, stackTrace) {},
                            backgroundColor: primaryColor,
                            backgroundImage: NetworkImage(
                                value.userModel?.image.toString() ?? ""),
                            child: value.userModel?.image != ""
                                ? Icon(
                                    Icons.person,
                                    size: 30,
                                    color: white,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
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
                              child: Text(
                                "e-Pelita Guru merupakan aplikasi yang berfungsi untuk mengelola kehadiran siswa dan juga dapat melaporkan pelanggaran di instansi sekolah menggunakan fitur e-Pelita Care",
                                style: secondaryTextStyle.copyWith(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Text(
                        "Daftar absen dari setiap kelas",
                        style: secondaryTextStyle.copyWith(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: value3.kelas.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final kelas = value3.kelas[index];
            
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: defaultPadding),
                          child: CustomListTileWidget(
                            title: "Kelas ${kelas.kelas.toString()}",
                            subtitle: "Klik untuk verifikasi",
                            onTap: () {
                              Navigator.of(context).push(
                                PageTransition(
                                  child: StudentPage(
                                    kelasId: kelas.id.toString(),
                                    kelas: kelas.kelas.toString(),
                                  ),
                                  type: PageTransitionType.rightToLeft,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<DataColumn> listDataColumn(BuildContext context) {
    return [
      DataColumn(
        label: Text(
          "Status",
          style: primaryTextStyle,
        ),
      ),
      DataColumn(
        label: Text(
          "Tanggal",
          style: primaryTextStyle,
        ),
      ),
      DataColumn(
        label: Text(
          "Waktu",
          style: primaryTextStyle,
        ),
      ),
      DataColumn(
        label: Text(
          "Keterangan",
          style: primaryTextStyle,
        ),
      ),
    ];
  }

  List<DataCell> listDataCell(
    BuildContext context,
    String status,
    String tanggal,
    String waktu,
    String keterangan,
    // PresensiProvider value2,
  ) {
    return [
      DataCell(
        Text(
          status,
          style: primaryTextStyle,
        ),
      ),
      DataCell(
        Text(
          tanggal,
          style: primaryTextStyle,
        ),
      ),
      DataCell(
        Text(
          waktu,
          style: primaryTextStyle,
        ),
      ),
      DataCell(
        Text(
          keterangan,
          style: primaryTextStyle,
        ),
      ),
    ];
  }

  List<DataRow> listDataRow(
    BuildContext context,
    // PresensiProvider value2,
  ) {
    return [
      DataRow(
        cells: listDataCell(
          context,
          "",
          "",
          "",
          "",
        ),
      ),
    ];
  }
}
