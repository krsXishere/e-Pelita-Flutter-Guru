import 'package:e_pelita_guru/pages/sign_in_page.dart';
import 'package:e_pelita_guru/providers/auth_provider.dart';
import 'package:e_pelita_guru/providers/edupelita_care_provider.dart';
import 'package:e_pelita_guru/providers/kelas_provider.dart';
import 'package:e_pelita_guru/providers/navigation_bar_provider.dart';
import 'package:e_pelita_guru/providers/presence_provider.dart';
import 'package:e_pelita_guru/providers/sekolah_provider.dart';
import 'package:e_pelita_guru/providers/user_provider.dart';
import 'package:e_pelita_guru/services/notification_service.dart';
import 'package:e_pelita_guru/widgets/navigation_bar_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

AndroidOptions _getAndroidOptions() {
  return const AndroidOptions(
    encryptedSharedPreferences: true,
  );
}

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
String token = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id', null);

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  NotificationService().initializeNotification();
  tz.initializeTimeZones();

  NotificationService().getNotificationPermission();

  // NotificationService().scheduleNotification();

  token = await storage.read(
        key: "token",
        aOptions: _getAndroidOptions(),
      ) ??
      "";

  runApp(const EPelitaGuru());
}

class EPelitaGuru extends StatefulWidget {
  const EPelitaGuru({super.key});

  @override
  State<EPelitaGuru> createState() => _EPelitaGuruState();
}

class _EPelitaGuruState extends State<EPelitaGuru> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NavigationBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EduPelitaCareProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SekolahProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => KelasProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PresenceProvider(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: token != "" ? const NavigationBarWidget() : const SignInPage(),
        );
      }),
    );
  }
}
