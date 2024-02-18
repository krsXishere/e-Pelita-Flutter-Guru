// import 'package:sision/common/theme.dart';
// import 'package:sision/pages/profile_page.dart';
// import 'package:sision/pages/qr_presence_scanner_page.dart';
import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../pages/dashboard_page.dart';
import '../common/theme.dart';
import '../pages/profile_page.dart';
import '../providers/navigation_bar_provider.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  final List<Widget> pages = const [
    DashboardPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationBarProvider>(
      builder: (context, value, child) {
        return Stack(
          children: [
            pages.elementAt(value.currentIndex),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Align(
                alignment: const Alignment(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      primaryShadow,
                    ],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: white,
                      currentIndex: value.currentIndex,
                      selectedItemColor: primaryColor,
                      unselectedItemColor: grey400,
                      selectedLabelStyle: primaryTextStyle.copyWith(
                        color: primaryColor,
                      ),
                      unselectedLabelStyle: primaryTextStyle.copyWith(
                        color: grey400,
                      ),
                      // showSelectedLabels: false,
                      // showUnselectedLabels: false,
                      onTap: (valueIndex) {
                        value.updateCurrentIndex(valueIndex);
                      },
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(
                            value.currentIndex == 0
                                ? Icons.dashboard_rounded
                                : Icons.dashboard_outlined,
                          ),
                          label: 'Beranda',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            value.currentIndex == 1
                                ? Icons.person_rounded
                                : Icons.person_outlined,
                          ),
                          label: 'Profil',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Align(
            //   alignment: const Alignment(0.0, 0.925),
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         PageTransition(
            //           child: const QRPresenceScannerPage(),
            //           type: PageTransitionType.scale,
            //           alignment: const Alignment(0.0, 1.0),
            //           duration: const Duration(milliseconds: 500),
            //         ),
            //       );
            //     },
            //     child: CircleAvatar(
            //       backgroundColor: primaryColor,
            //       child: Icon(
            //         Icons.qr_code_scanner_rounded,
            //         color: white,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
