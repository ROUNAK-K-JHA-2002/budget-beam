// ignore_for_file: unused_element

import 'package:budgetbeam/routes/router.dart';
import 'package:budgetbeam/services/object_box.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

late ObjectBoxStore _objectBoxStore;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Failed to load .env file: $e");
    return;
  }
  _objectBoxStore = await ObjectBoxStore.create();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  MobileAds.instance.initialize();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: kPrimaryColor, // status bar color
  ));

  runApp(const ProviderScope(child: MyApp()));
}

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

final String bannerAdsId = dotenv.env['BANNER_ADS_TEST_ID'] ?? '';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Budget Beam',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'OpenSans',
        ),
        initialRoute: auth.currentUser == null ? '/onboarding' : '/',
        routes: appRoutes,
      );
    });
  }
}
